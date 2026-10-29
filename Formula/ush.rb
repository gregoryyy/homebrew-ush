class Ush < Formula
  desc "Shell assistant for zsh: ask in plain language, get the commands"
  homepage "https://github.com/gregoryyy/ushell"
  url "https://github.com/gregoryyy/ushell/archive/refs/tags/v0.2.0.tar.gz"
  version "0.2.0"
  sha256 "f427d5e867b5ac5c13074b6e2cd66e6a5d8192727a5681515ae8a303ee35628d"
  license "MIT"

  depends_on "go" => :build

  def install
    cd "ushgo" do
      ENV["CGO_ENABLED"] = "0"
      system "go", "build", "-trimpath", "-buildvcs=false",
             "-ldflags", "-s -w -X main.version=#{version}", "-o", bin/"ush", "./cmd/ush"
    end
    (share/"ush").install "ushpy/shell/ush.plugin.zsh"
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
  end
end
