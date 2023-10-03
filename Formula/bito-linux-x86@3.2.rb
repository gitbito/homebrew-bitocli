class BitoLinuxX86AT32 < Formula
  desc "Bito CLI for Linux x86 based architecure with new version 3.6 for test"
  version "3.6.0"
  homepage "https://github.com/gitbito/CLI"
  url "https://github.com/gitbito/CLI/releases/download/v3.6.0/bito-linux-x86.tar.gz"
  sha256 "0af57fd8376d6d62ba2f62ff6be1b022d2220989483d5154d4380c5430176b94"
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
    bin.install_symlink "bito" => "bito"
  end

  def post_upgrade
    # Same steps as post_install for handling upgrades
    post_install
  end

  test do
    system "#{bin}/bito"
  end
end
