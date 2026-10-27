class Dunk < Formula
  desc "Mason-inspired terminal UI for Homebrew"
  homepage "https://github.com/lesliesrussell/dunk"
  url "https://github.com/lesliesrussell/dunk/releases/download/v0.1.0/dunk-0.1.0.tar.gz"
  sha256 "05201b5e73be5e57f1799d34f55113f1e5d59c7e6dd7a41ecbe66677accddeea"
  license "MIT"

  bottle do
    root_url "https://github.com/lesliesrussell/homebrew-tap/releases/download/dunk-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "19258c61262da8cf2e0532bc12d1cbb9bf9b0530e3509ec5d5b62d72db902f61"
    sha256 cellar: :any,                 x86_64_linux:  "8422f59e173b674ac7347cf23f7fc00f296186ce464cf8f019a4dc74e3b8f474"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "Mason-inspired Homebrew TUI", shell_output("#{bin}/dunk --help")
    (testpath/"brew").write <<~SH
      #!/bin/sh
      case "$1" in
        formulae) printf 'alpha\\n' ;;
        casks) printf 'beta\\n' ;;
        info) printf '%s\\n' '{"formulae":[{"full_name":"alpha","outdated":true}],"casks":[]}' ;;
        *) exit 1 ;;
      esac
    SH
    chmod 0755, testpath/"brew"
    with_env(DUNK_BREW: (testpath/"brew").to_s) do
      assert_match "2 packages, 1 installed, 1 outdated", shell_output("#{bin}/dunk --check")
    end
  end
end
