class BitoLinuxX86AT320 < Formula
  desc "Bito CLI for Linux x86 based architecure with new version 3.5 for test"
  homepage "https://github.com/gitbito/CLI"
  url "https://github.com/gitbito/CLI/releases/download/v3.2.0/bito-linux-x86.tar.gz"
  sha256 "5352f651d1a8f9ae545f4e5e5c6e067f3cda0b11d54817c9a353f54338472f62"
  license ""

  def install
    bin.install "bito-linux-x86" => "bito"
  end

  test do
    system "#{bin}/bito"
  end
end
