class BitoLinuxX86 < Formula
  desc "Bito CLI for Linux x86 based architecure with new version 3.4 for test"
  version "3.4.0"
  homepage "https://github.com/gitbito/CLI"
  url "https://github.com/gitbito/CLI/releases/download/v3.4.0/bito-linux-x86.tar.gz"
  sha256 "be9f82619233dae8cbb96c403fb35cc745816e55f121d48ba95923ab4050f093"
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
