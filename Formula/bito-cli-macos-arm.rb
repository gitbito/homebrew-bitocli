class BitoCliMacosArm < Formula
  desc "Bito CLI for MacOS Arm based architecure"
  version "3.5.0"
  homepage "https://github.com/gitbito/CLI"
  url "https://github.com/gitbito/CLI/releases/download/vm3.5.0/bito-macos-arm.tar.gz"
  sha256 "1b0884a3e6cfe2771545db7f4e1d0a5bf5a6bf91e5b0c47b15f3a87412843758"
  license ""

  def install
    bin.install "bito-macos-arm" => "bito"
  end

  test do
    system "#{bin}/bito"
  end
end
