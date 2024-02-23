class BitoCli < Formula
  desc "Bito CLI Version 4.0"
  version "4.0.0"
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
    sha256 "1b7acd6fe8a640517c830e7d17a05e256b7abfbb6e07923a46df5c5fe1c39f78"
  elsif installOS == "macos" && installArch == "x86"
    sha256 "c90877bb4ed9bc54c4dd4065c105277529006be31ade988ea671df45b58e5ad5"
  elsif installOS == "linux" && installArch == "arm"
    sha256 "d7860986b4b64f8bfa4c19210ff832dad350a1ef9ac0141e01b917541085b5d2"
  elsif installOS == "macos" && installArch == "arm"
    sha256 "04732c9f7aacc0483c454a626db170b97b8b29fe8ccd1194b6b7639380b08850"
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
    
    bin.install_symlink "#{bin}/bito" => "bito" 
    # Run the brew link command for bito-cli
    # system("brew link bito-cli")
  end

  test do
    system "#{bin}/bito"
  end
end