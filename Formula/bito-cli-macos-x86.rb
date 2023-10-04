class BitoCliMacosX86 < Formula
  desc "Bito CLI for MacOS x86 based architecure"
  version "4.0.0"
  homepage "https://github.com/gitbito/CLI"
  url "https://github.com/gitbito/CLI/releases/download/vmx864.0.0/bito-macos-x86"
  sha256 "623ff133f0a6a5e96eba6f82fb644e355d8038214aeb26cb96a4ca089eb8e61b"
  license ""

  def install
    bin.install "bito-macos-x86" => "bito"
  end

  test do
    system "#{bin}/bito"
  end
end
