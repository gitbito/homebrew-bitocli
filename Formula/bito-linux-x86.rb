class BitoLinuxX86 < Formula
  desc "Bito CLI for Linux x86 based architecure with new version 3.5 for test"
  version "3.5.0"
  homepage "https://github.com/gitbito/CLI"
  url "https://github.com/gitbito/CLI/releases/download/v3.4.0/bito-linux-x86.tar.gz"
  sha256 "be9f82619233dae8cbb96c403fb35cc745816e55f121d48ba95923ab4050f093"
  license ""

  def install
    bin.install "bito-linux-x86" => "bito"
  end

  test do
    system "#{bin}/bito"
  end
end
