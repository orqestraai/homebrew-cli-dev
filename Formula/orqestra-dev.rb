class OrqestraDev < Formula
  desc "AI-powered SDLC orchestration CLI (dev channel)"
  homepage "https://orqestra.work"
  version "0.9.36.dev20260713094606"

  on_macos do
    on_arm do
      url "https://github.com/orqestraai/orqestra-releases/releases/download/latest-dev/orqestra-macos-arm64.tar.gz"
      sha256 "964890b09836b72e669dc30d4bfebc754158d82fc845f2763513ed9ce1ed45c5"
    end
  end

  def install
    # Homebrew unpack flattens the single top-level `orqestra/` dir from the tarball.
    (libexec/"orqestra").install "_internal", "orqestra"
    bin.install_symlink libexec/"orqestra"/"orqestra" => "orqestra-dev"
  end

  def fix_dynamic_linkage
    # PyInstaller bundle resolves bundled .so files via @rpath at runtime;
    # Homebrew relocation fails on libs without header padding and isn't needed.
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
