class OrqestraDev < Formula
  desc "AI-powered SDLC orchestration CLI (dev channel)"
  homepage "https://orqestra.work"
  version "0.9.36.dev20260831204302"
  preserve_rpath

  on_macos do
    on_arm do
      url "https://github.com/orqestraai/orqestra-releases/releases/download/latest-dev/orqestra-macos-arm64.tar.gz"
      sha256 "f96d4f8e72aae410f3a26288c0c330d9414a798f8b0b1c5dd7dd0e7e83a94c79"
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
