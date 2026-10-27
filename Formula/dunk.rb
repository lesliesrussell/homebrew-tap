class Dunk < Formula
  desc "Mason-inspired terminal UI for Homebrew"
  homepage "https://github.com/lesliesrussell/dunk"
  url "https://github.com/lesliesrussell/dunk/releases/download/v0.1.1/dunk-0.1.1.tar.gz"
  sha256 "c30e6196db3d13bdfd51047a159bb529b37057b62672498a31892e347e39bf01"
  license "MIT"

  bottle do
    root_url "https://github.com/lesliesrussell/homebrew-tap/releases/download/dunk-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "065a44e8bafbca3156a340d47a34beaf663f607cffba7c9ebe3601bc13506096"
    sha256 cellar: :any,                 x86_64_linux:  "dc27877e9b52599642c1c8bb9d816c337e77ee6307d5a3d822ae651c3ea032f3"
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
