class BitoLinuxX86AT31 < Formula
  desc "Bito CLI for Linux x86 based architecure with version 3.1 for test"
  version "3.1.0"
  homepage "https://github.com/gitbito/CLI"
  url "https://github.com/gitbito/CLI/releases/download/v3.1.0/bito-linux-x86.tar.gz"
  sha256 "5552b20267454b2b959a60a4cda01f060bfa4fe75beef963cec8e5ac6fd5405f"
  license ""

  def install
    bin.install "bito-linux-x86" => "bito"
  end

  test do
    system "#{bin}/bito"
  end
end
