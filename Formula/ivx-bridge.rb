# Rendered by .github/workflows/homebrew.yml and pushed to ivxlabs/homebrew-tap
# as Formula/ivx-bridge.rb. 0.2.1 and 63ec341612853e39209f323424a38365920795eeb7628224356d37402eba88d9 are filled in there.
class IvxBridge < Formula
  desc "Loopback CORS bridge for any LLM endpoint: logs no headers or bodies"
  homepage "https://github.com/ivxlabs/ivxai-app"
  version "0.2.1"
  license "GPL-3.0-or-later"

  url "https://github.com/ivxlabs/ivxai-app/releases/download/v#{version}/ivx-bridge-v#{version}-macos-universal.tar.gz"
  sha256 "63ec341612853e39209f323424a38365920795eeb7628224356d37402eba88d9"

  # The tarball holds a macOS universal binary, so this is not installable on
  # Linuxbrew even though the bridge itself builds fine on Linux.
  depends_on :macos

  def install
    bin.install "ivx-bridge"
    doc.install "README.md"
  end

  # `brew services start ivx-bridge` instead of `ivx-bridge --install-service`.
  # Both end up as a launchd job; this one Homebrew knows how to remove.
  service do
    run [opt_bin/"ivx-bridge"]
    keep_alive true
    log_path var/"log/ivx-bridge.log"
    error_log_path var/"log/ivx-bridge.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ivx-bridge --version")
  end
end
