class BitoCli < Formula
  desc "Bito CLI Version 4.7"
  version "4.7.0"
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
    sha256 "4b2aa7aa9b56951fd31418a387bda70b964d133ac4ab1b1ee3abc595b8845d86"
  elsif installOS == "macos" && installArch == "x86"
    sha256 "f297b41bfadbd576e0e212168960b057cb42aa34a5bf868f1e1d452d508e7ace"
  elsif installOS == "linux" && installArch == "arm"
    sha256 "d75b567e7b55286b15a069657b2a3ef9509399eb9be7203ed43505bc32f138a6"
  elsif installOS == "macos" && installArch == "arm"
    sha256 "0dca001ff06dedcd790dd287edfa58e35b0ab3306d94beb5e92b9067e9e871c0"
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