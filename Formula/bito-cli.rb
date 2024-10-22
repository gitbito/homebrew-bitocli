class BitoCli < Formula
  desc "Bito CLI Version 4.9"
  version "4.9.0"
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
    sha256 "f5252205c524c60f0bcef340230f8690b45d4c499e5325fc6a1ab6fd6ee89198"
  elsif installOS == "macos" && installArch == "x86"
    sha256 "7a24b422bb04803b417f68eefb453c00ccf48cbf388a405b95cbc5205976ff42"
  elsif installOS == "linux" && installArch == "arm"
    sha256 "e838a1a762f64c1f39d32de0ef52b931e77e7adac685c70b0e335c8298674d52"
  elsif installOS == "macos" && installArch == "arm"
    sha256 "cc813c838ef51ae54737257c51bbccdbb1f6635e677c1a074ea5928600ed62fc"
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