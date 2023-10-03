class BitoLinuxX86AT31 < Formula
  desc ""
  homepage ""
  url "https://github.com/gitbito/CLI/releases/download/v3.1.0/bito-linux-x86.tar.gz"
  sha256 "5552b20267454b2b959a60a4cda01f060bfa4fe75beef963cec8e5ac6fd5405f"
  license ""

  def install
    # Unlink the previous version if it exists
      rm "#{bin}/bito"
      ohai "Unlinked previous version: #{old_link}"
    end

    bin.install "bito-linux-x86" => "bito"
    bin.install_symlink "bito-linux-x86" => "bito"
  end

  test do
    system "#{bin}/bito"
  end
end
