class BitoCliLinuxX86 < Formula
  desc "Bito CLI for MacOS Arm based architecure"
  homepage "https://github.com/gitbito/CLI"
  url "https://github.com/gitbito/CLI/releases/download/vm3.4.0/bito-macos-arm.tar.gz"
  sha256 "0bb392ec76f59286a3e3530529b6b1734f0072ae09ea4dffd45ac9be95554b1d"
  license ""

  def install
    bin.install "bito-macos-arm" => "bito"
  end

  test do
    system "#{bin}/bito"
  end
end
