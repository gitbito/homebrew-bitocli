class BitoCliLinuxX86 < Formula
  desc "Bito CLI for Linux x86 based architecure"
  homepage "https://github.com/gitbito/CLI"
  url "https://github.com/gitbito/CLI/releases/download/v3.4.0/bito-linux-x86.tar.gz"
  sha256 "25bf6c0dd73e260ac515af85fb8ea465dc79489659824f93c35a5ad1dd870bf5"
  license ""

  def install
    bin.install "bito"
  end

  test do
    system "#{bin}/bito"
  end
end
