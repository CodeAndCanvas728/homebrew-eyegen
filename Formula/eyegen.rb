class Eyegen < Formula
  desc "Local image generation on Apple Silicon — GUI and CLI, fully offline"
  homepage "https://github.com/CodeAndCanvas728/eyegen-playground"

  # Bump the version, the URL and the checksum together at every release.
  # The tarball is published by the release workflow on the GitHub mirror,
  # reached through the push mirror from the development forge. The archive
  # is reproducible, so rebuilding the same source gives the same checksum.
  #
  # The version is in the URL, which is where Homebrew reads it from.
  url "https://github.com/CodeAndCanvas728/eyegen-playground/releases/download/v0.6.0/eyegen-0.6.0.tar.gz"
  sha256 "43b54b5b132dc441dbe4dd25a4d84760199a424135080f3fc068fad9a9be1ed4"
  license "MIT"

  depends_on :macos
  depends_on "python@3.12"

  def install
    libexec.install Dir["*"]

    # The CLI lives in a user venv, not in the Cellar, so a `brew upgrade`
    # does not take the downloaded model backends with it. The venv is
    # rebuilt only when the installed version changes.
    (bin/"eyegen").write <<~SH
      #!/bin/sh
      set -e
      VENV_DIR="${EYEGEN_VENV:-$HOME/.local/share/eyegen/venv}"
      STAMP="$VENV_DIR/.eyegen-version"
      if [ ! -x "$VENV_DIR/bin/python" ] || [ "$(cat "$STAMP" 2>/dev/null)" != "#{version}" ]; then
        rm -rf "$VENV_DIR"
        "#{formula_opt_bin("python@3.12")}/python3" -m venv "$VENV_DIR"
        PIP_DISABLE_PIP_VERSION_CHECK=1 "$VENV_DIR/bin/pip" install --quiet --upgrade \
          -r "#{libexec}/requirements.txt" "#{libexec}"
        echo "#{version}" > "$STAMP"
      fi
      exec "$VENV_DIR/bin/generate" "$@"
    SH
  end

  def caveats
    <<~EOS
      The CLI is installed into a virtual environment at
        ~/.local/share/eyegen/venv
      (override with EYEGEN_VENV), not into the Cellar. The first run
      installs the Python dependencies, including the MLX backends
      (several GB). Apple Silicon is required.

      The GUI is started from the installed source with the venv Python:
        "$HOME/.local/share/eyegen/venv/bin/python" "#{libexec}/gui.py"

      The Idol image-to-3D sidecar needs Python 3.11:
        brew install python@3.11
        eyegen setup-idol
    EOS
  end

  test do
    # A full install pulls several GB of backends, so the test only checks
    # that the wrapper exists and pins the version the formula ships.
    assert_path_exists bin/"eyegen"
    assert_match version.to_s, (bin/"eyegen").read
  end
end
