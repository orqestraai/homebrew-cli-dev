class OrqestraDev < Formula
  desc "AI-powered SDLC orchestration CLI (dev channel)"
  homepage "https://orqestra.work"
  version "0.9.36.dev20260626123356"

  on_macos do
    on_arm do
      url "https://github.com/orqestraai/orqestra-releases/releases/download/latest-dev/orqestra-macos-arm64.tar.gz"
      sha256 "86a96c771bbe94c687fca24ac7471cd43dc64329a33e5afae11c2244a9a7876d"
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
