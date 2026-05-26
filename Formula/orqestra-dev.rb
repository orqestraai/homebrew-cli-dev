class OrqestraDev < Formula
  desc "AI-powered SDLC orchestration CLI (dev channel)"
  homepage "https://orqestra.work"
  version "0.9.30.dev20260526192256"

  on_macos do
    on_arm do
      url "https://github.com/orqestraai/orqestra-releases/releases/download/latest-dev/orqestra-macos-arm64"
      sha256 "74a731f33cbabf8db61bb7ff73a55b0ec4cbeac4e8beaf9b425e2fd9546e425d"
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
