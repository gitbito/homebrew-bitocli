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
    sha256 "704862dd4a517cdef73bdd7e2aafffed4b99f79c79a9a6a4676d75ec5d581bab"
  elsif installOS == "macos" && installArch == "x86"
    sha256 "dc3c48c6ccb688790e8d3cba0f5e56539e5fba191f56bcf158526d17cfb1d8e2"
  elsif installOS == "linux" && installArch == "arm"
    sha256 "1665bb406c96652913f2abe7a1565c4ef3dd37c3e0edab1565f84fc1fa99c595"
  elsif installOS == "macos" && installArch == "arm"
    sha256 "59d0fac840385f08fc8b2d95f4bf7347a58a99439fdef0b65af9a47dabb70eb0"
  end

   url "https://github.com/gitbito/CLI/releases/download/v#{version}/bito-#{installOS}-#{installArch}.tar.gz"
   
   def install
    installOS, installArch = self.class.set_arch_and_os

    puts("Post installation script")

    lca_bundle_url = "https://github.com/gitbito/CLI/releases/download/packages/bito-lca-#{installOS}.tar.gz"
    supported_files_url = "https://github.com/gitbito/CLI/releases/download/packages/slashCommands.json"

    lca_bundle = "bito-lca-#{installOS}.tar.gz"
    lca_os_specific = "bito-lca-#{installOS}"
    lca_binary = "bito-lca"
    supported_files = "slashCommands.json"
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

    # Run the brew link command for bito-cli
    # system("brew link --overwrite bito-cli")
  end

  test do
    system "#{bin}/bito"
  end
end