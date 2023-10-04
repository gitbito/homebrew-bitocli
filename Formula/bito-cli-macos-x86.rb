class BitoCliMacosX86 < Formula
  desc "Bito CLI for MacOS x86 based architecure"
  version "3.4.0"
  homepage "https://github.com/gitbito/CLI"
  url "https://github.com/gitbito/CLI/releases/download/vmx863.4.0/bito-macos-x86"
  sha256 "c020b6ffb0213ac3408cd9fe78e089ab93c9f00d2f33131d5cb5c657cdfbcdb2"
  license ""

  def install
    bin.install "bito-macos-x86" => "bito"
  end

  test do
    system "#{bin}/bito"
  end
end
