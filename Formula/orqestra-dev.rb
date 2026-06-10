class OrqestraDev < Formula
  desc "AI-powered SDLC orchestration CLI (dev channel)"
  homepage "https://orqestra.work"
  version "0.9.33.dev20260610115541"

  on_macos do
    on_arm do
      url "https://github.com/orqestraai/orqestra-releases/releases/download/latest-dev/orqestra-macos-arm64.tar.gz"
      sha256 "296caf8fffafe1363949c3f39efbd9bffb0d8043ce279d4093c43e9dbcef8758"
    end
  end

  def install
    # Homebrew unpack flattens the single top-level `orqestra/` dir from the tarball.
    (libexec/"orqestra").install "_internal", "orqestra"
    bin.install_symlink libexec/"orqestra"/"orqestra" => "orqestra-dev"
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
