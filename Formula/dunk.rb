class Dunk < Formula
  desc "Mason-inspired terminal UI for Homebrew"
  homepage "https://github.com/lesliesrussell/dunk"
  url "https://github.com/lesliesrussell/dunk/releases/download/v0.1.0/dunk-0.1.0.tar.gz"
  sha256 "204e455b1162ec1ed7005ee4ca558b2ea2f0c67989d12ebb0183582897b33645"
  license "MIT"

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
