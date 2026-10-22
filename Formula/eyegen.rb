class Eyegen < Formula
  desc "Local image generation on Apple Silicon — MLX, MFLUX, GGUF, FLUX.3"
  homepage "https://github.com/CodeAndCanvas728/eyegen-playground"
  # Bump the version and the tag together at every release.
  url "https://github.com/CodeAndCanvas728/eyegen-playground/releases/download/v#{version}/eyegen-#{version}.tar.gz"
  version "0.2.2"
  license "MIT"

  depends_on "python@3.14"

  def install
    # The virtual environment lives in the user's home, not in the Cellar.
    # Homebrew replaces the Cellar on upgrade, and a virtual environment
    # inside it would not survive: every upgrade would take the backends
    # with it, which is the opposite of what this is for.
    venv = Pathname.new(ENV.fetch("EYEGEN_VENV", "~/.local/share/eyegen/venv")).expanduser
    unless venv.directory?
      system "python3.14", "-m", "venv", venv
    end
    python = venv/"bin/python"
    system python, "-m", "pip", "install", "--upgrade", "pip"
    system python, "-m", "pip", "install", "-r", "requirements.txt"
    system python, "-m", "pip", "install", "."
    bin.install_symlink venv/"bin/generate"
  end

  def caveats
    <<~EOS
      The virtual environment is in #{ENV.fetch("EYEGEN_VENV", "~/.local/share/eyegen/venv")},
      not in the Cellar, so it survives an upgrade.

      The backends are Python packages, and a new model arrives when one of
      them is released. To see what is out there and to install it:

        eyegen update-backends
        eyegen update-backends --apply

      The first install downloads a few gigabytes: torch and mlx among them.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/generate --version 2>&1 || true")
  end
end
