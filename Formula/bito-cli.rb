class BitoCli < Formula
  desc "Bito CLI Version 4.8"
  version "4.8.0"
  homepage "https://github.com/gitbito/CLI"
  license ""

  
   def self.set_arch_and_os
    installOS=""
    installArch=""

     # Detect machine OS
    unos = `uname`.chomp
    ohai "unos: #{unos}"
    if unos == "Darwin"
        installOS = "macos"
    elsif unos == "Linux"
        installOS = "linux"
    end

     # Detect machine architecture type
    unmacarch = `uname -m`.chomp
    ohai "unmacarch: #{unmacarch}"
    if unmacarch == "x86_64"
        installArch = "x86"
    elsif unmacarch == "arm" || unmacarch == "arm64"
        installArch = "arm"
    end
     [installOS, installArch]
  end

   installOS, installArch = self.set_arch_and_os

   if installOS == "linux" && installArch == "x86"
    sha256 "e846a171b40f47cfe6e9bc564691eec1419cd0bdf51eb463a7922f61d2d31396"
  elsif installOS == "macos" && installArch == "x86"
    sha256 "85b14720829ed9cfbdb9d7d857486400b8575f98a5d0a81e19fe9351b3f2128f"
  elsif installOS == "linux" && installArch == "arm"
    sha256 "d2d8fc226a3808a4ab597f78abdf70ba3842cc94517ba0fabeca9f5a61321b4b"
  elsif installOS == "macos" && installArch == "arm"
    sha256 "6df0d34af219b4244418bc89ae69507d8b810397a22b58663ed95fcf4a6638f0"
  end

   url "https://github.com/gitbito/CLI/releases/download/v#{version}/bito-#{installOS}-#{installArch}.tar.gz"
   
   def install
    installOS, installArch = self.class.set_arch_and_os

    puts("Post installation script")

    lca_binary = "bito-lca"
    supported_files = "bito-slashCommands.json"
    lca_bundle = "bito-lca-#{installOS}.tar.gz"

    lca_bundle_url = "https://github.com/gitbito/CLI/releases/download/packages/#{lca_bundle}"
    supported_files_url = "https://github.com/gitbito/CLI/releases/download/packages/#{supported_files}"

    lca_os_specific = "bito-lca-#{installOS}"
    prefix = "/usr/local/bin"

    # Create the directory if it doesn't exist
    FileUtils.mkdir_p(prefix) unless Dir.exist?(prefix)
    # Change the permissions of the directory and all its contents
      
    # Use curl to download files
    system "curl", "-L", "#{lca_bundle_url}", "-o", "#{lca_bundle}"
    system "curl", "-L", "#{supported_files_url}", "-o", "#{supported_files}"

    # Unpack the lca_bundle tar.gz file
    system "tar", "-xzf", "#{lca_bundle}"
  
    bin.install "bito-#{installOS}-#{installArch}" => "bito"
    bin.install "#{lca_os_specific}" => "#{lca_binary}"
    bin.install "#{supported_files}" => "#{supported_files}"
  end

  test do
    system "#{bin}/bito"
  end
end