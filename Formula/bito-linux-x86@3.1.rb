class BitoLinuxX86AT31 < Formula
  desc ""
  homepage ""
  url "https://github.com/gitbito/CLI/releases/download/v3.1.0/bito-linux-x86.tar.gz"
  sha256 "5552b20267454b2b959a60a4cda01f060bfa4fe75beef963cec8e5ac6fd5405f"
  license ""

  def install
    # Unlink the previous version if it exists
    # if File.symlink?("#{bin}/bito")
    #   old_link = File.readlink("#{bin}/bito")
    #   rm "#{bin}/bito"
    #   ohai "Unlinked previous version: #{old_link}"
    # end
    bin.install "bito-linux-x86" => "bito"
  end

  def post_install
    # Remove any existing symlink for bito-cli if it exists
    old_symlink = HOMEBREW_PREFIX/"bin/bito"
    old_symlink.unlink if old_symlink.exist?
    
    # Create a new symlink pointing to the installed version
    bin.install_symlink "#{bin}/bito" => "bito"
  end

  def post_upgrade
    # Same steps as post_install for handling upgrades
    post_install
  end

  test do
    system "#{bin}/bito"
  end
end
