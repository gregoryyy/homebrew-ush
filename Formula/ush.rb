class Ush < Formula
  desc "Shell assistant for zsh: ask in plain language, get the commands"
  homepage "https://github.com/gregoryyy/ushell"
  url "https://github.com/gregoryyy/ushell/archive/refs/tags/v0.2.3.tar.gz"
  version "0.2.3"
  sha256 "4c3ed9915a414e6c9290e1168140fc1d03d388257198529bb13d7b2afacbd1db"
  license "MIT"

  depends_on "go" => :build

  def install
    cd "src/go" do
      ENV["CGO_ENABLED"] = "0"
      system "go", "build", "-trimpath", "-buildvcs=false",
             "-ldflags", "-s -w -X main.version=#{version}", "-o", bin/"ush", "./cmd/ush"
    end
    (share/"ush").install "src/shell/ush.plugin.zsh"
    man1.install "src/man/ush.1"
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
