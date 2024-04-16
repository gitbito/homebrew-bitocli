class BitoCli < Formula
  desc "Bito CLI Version 4.3"
  version "4.3.0"
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
    sha256 "2c616e1b4a3f79599f8573f9026f7e0f2d7718adf1dadc7a23089df6a64b5abb"
  elsif installOS == "macos" && installArch == "x86"
    sha256 "e93a5ddf697c6254398b54bcbc0197efea1df7e2ef555af5204ac800aa3ecd41"
  elsif installOS == "linux" && installArch == "arm"
    sha256 "e7fb29cb3a022aff2fbe1d5cfb9351743af47b5686c50efd62e707801a5d42d3"
  elsif installOS == "macos" && installArch == "arm"
    sha256 "aef617b50a4563f8a470ea5bb9cc8353933e56095399a6fc0c295b6555423c62"
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