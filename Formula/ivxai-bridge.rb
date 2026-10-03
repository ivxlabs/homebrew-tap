# Rendered by .github/workflows/homebrew.yml and pushed to ivxlabs/homebrew-tap
# as Formula/ivxai-bridge.rb. 0.3.0 and 89c7c7da8104ecad686c38081a8e976c6aa0d4cf1d6685092e75f63451b3a8e8 are filled in there.
class IvxaiBridge < Formula
  desc "Loopback CORS bridge for any LLM endpoint: logs no headers or bodies"
  homepage "https://github.com/ivxlabs/ivxai-app"
  version "0.3.0"
  license "GPL-3.0-or-later"

  url "https://github.com/ivxlabs/ivxai-app/releases/download/v#{version}/ivxai-bridge-v#{version}-macos-universal.tar.gz"
  sha256 "89c7c7da8104ecad686c38081a8e976c6aa0d4cf1d6685092e75f63451b3a8e8"

  # The tarball holds a macOS universal binary, so this is not installable on
  # Linuxbrew even though the bridge itself builds fine on Linux.
  depends_on :macos

  def install
    bin.install "ivxai-bridge"
    doc.install "README.md"
  end

  # `brew services start ivxai-bridge` instead of `ivxai-bridge --install-service`.
  # Both end up as a launchd job; this one Homebrew knows how to remove.
  service do
    run [opt_bin/"ivxai-bridge"]
    keep_alive true
    log_path var/"log/ivxai-bridge.log"
    error_log_path var/"log/ivxai-bridge.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ivxai-bridge --version")
  end
end
