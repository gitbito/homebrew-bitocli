class BitoLinuxX86 < Formula
  desc "Bito CLI for Linux x86 based architecure with new version 3.5 for test"
  version "3.5.0"
  homepage "https://github.com/gitbito/CLI"
  url "https://github.com/gitbito/CLI/releases/download/v3.5.0/bito-linux-x86.tar.gz"
  sha256 "27c4f990012a7f282498162ad03f160d6b6bcf00b146c7e1048ec79cdcf15d79"
  license ""

  def install
    # Unlink the previous version if it exists
    if File.symlink?("#{bin}/bito")
      old_link = File.readlink("#{bin}/bito")
      rm "#{bin}/bito"
      ohai "Unlinked previous version: #{old_link}"
    end

    bin.install "bito-linux-x86" => "bito"
  end

  test do
    system "#{bin}/bito"
  end
end
