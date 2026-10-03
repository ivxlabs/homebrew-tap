# Rendered by .github/workflows/homebrew.yml and pushed to ivxlabs/homebrew-tap
# as Formula/ivxai-bridge.rb. 0.3.1 and 8f512fb3bd08d8733b76d236b455fe7e5be6b81cb6a145a915b5b6fb339fcc75 are filled in there.
class IvxaiBridge < Formula
  desc "Loopback CORS bridge for any LLM endpoint: logs no headers or bodies"
  homepage "https://github.com/ivxlabs/ivxai-app"
  version "0.3.1"
  license "GPL-3.0-or-later"

  url "https://github.com/ivxlabs/ivxai-app/releases/download/v#{version}/ivxai-bridge-v#{version}-macos-universal.tar.gz"
  sha256 "8f512fb3bd08d8733b76d236b455fe7e5be6b81cb6a145a915b5b6fb339fcc75"

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
