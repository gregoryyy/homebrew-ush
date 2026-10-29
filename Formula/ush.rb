class Ush < Formula
  desc "Shell assistant for zsh: ask in plain language, get the commands"
  homepage "https://github.com/gregoryyy/ushell"
  url "https://github.com/gregoryyy/ushell/archive/refs/tags/v0.2.2.tar.gz"
  version "0.2.2"
  sha256 "00b1c0dbcf3e4fcaebc1e5d7b839058e5ea909394c1829322c3db7ee8400c0d1"
  license "MIT"

  depends_on "go" => :build

  def install
    cd "ush/go" do
      ENV["CGO_ENABLED"] = "0"
      system "go", "build", "-trimpath", "-buildvcs=false",
             "-ldflags", "-s -w -X main.version=#{version}", "-o", bin/"ush", "./cmd/ush"
    end
    (share/"ush").install "ush/shell/ush.plugin.zsh"
    man1.install "ush/man/ush.1"
  end

  def caveats
    <<~EOS
      For proposals on your command line and unquoted // requests, add to ~/.zshrc:
        source #{opt_share}/ush/ush.plugin.zsh
      Then open a new terminal and run: ush ai configure
    EOS
  end

  test do
    assert_match "#{version} (go)", shell_output("#{bin}/ush --version")
    assert_match "usage:", shell_output("#{bin}/ush help")
    assert_path_exists man1/"ush.1"
  end
end
