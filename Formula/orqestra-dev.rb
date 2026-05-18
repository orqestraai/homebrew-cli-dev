class OrqestraDev < Formula
  desc "AI-powered SDLC orchestration CLI (dev channel)"
  homepage "https://orqestra.work"
  version "0.9.25.dev20260518134451"

  on_macos do
    on_arm do
      url "https://github.com/orqestraai/orqestra-releases/releases/download/latest-dev/orqestra-macos-arm64"
      sha256 "e1ce9fa5fea479cd911d1165b59a92dc843f13828fba0e4a15934bb0dfc2517d"
    end
  end

  def install
    bin.install "orqestra-macos-arm64" => "orqestra-dev"
  end

  def caveats
    <<~EOS
      Run `orqestra-dev auth login` to connect to the staging Control Center.
    EOS
  end

  test do
    output = shell_output("#{bin}/orqestra-dev --version 2>&1")
    assert_match "channel: dev", output
  end
end
