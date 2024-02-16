class BitoCli < Formula
  desc "Bito CLI Version 3.9"
  version "3.9.0"
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
    sha256 "776861ffb66a700f6d3e918c87c9e9f0b3dec67df36c291d30dfd38a882b5d5a"
  elsif installOS == "macos" && installArch == "x86"
    sha256 "042569f032cc0d317ad001d216d81e31647c052c956f5d40ad2e192177d660cd"
  elsif installOS == "linux" && installArch == "arm"
    sha256 "29bbf70fd691ae02d4a065e6284d002c6707aae8391e94516b65a5994ea67858"
  elsif installOS == "macos" && installArch == "arm"
    sha256 "33480d805fde6994acfaea924224282e899375b557da8fccb453224043185e11"
  end

   url "https://github.com/gitbito/CLI/releases/download/v#{version}/bito-#{installOS}-#{installArch}.tar.gz"
   
   def install
    installOS, installArch = self.class.set_arch_and_os
    bin.install "bito-#{installOS}-#{installArch}" => "bito"
    # Run the brew link command for bito-cli
    system("brew link bito-cli")
  end

  def post_install 
    lca_bundle_url = "https://github.com/gitbito/CLI/releases/download/packages/bito-lca-#{installOS}.tar.gz"
    supported_files_url = "https://github.com/gitbito/CLI/releases/download/packages/slashCommands.json"

    lca_bundle = "bito-lca-#{installOS}.tar.gz"
    lca_os_specific = "bito-lca-#{installOS}"
    renew_lca_bundle = "bito-lca"
    supported_files = "slashCommands.json"

    # Get current user's information
    user_info = Etc.getpwuid
    # Extract home directory from user information
    home_directory = user_info.dir
    prefix = home_directory+"/.bitoai/etc"

    # Create the directory if it doesn't exist
    FileUtils.mkdir_p(prefix) unless Dir.exist?(prefix)
    # Change the permissions of the directory and all its contents
    system "sudo" , "chmod" , "-R", "0777", "#{prefix}"
    
    # Use curl to download files
    system "curl", "-L", "#{lca_bundle_url}", "-o", "#{lca_bundle}"
    system "curl", "-L", "#{supported_files_url}", "-o", "#{supported_files}"

    # Unpack the lca_bundle tar.gz file
    system "sudo", "tar", "-xzf", "#{lca_bundle}", "-C", "#{prefix}"
      # Rename the lca_bundle before unpacking
    system "sudo" ,"mv", "#{prefix}"+"/"+lca_os_specific, "#{prefix}"+"/"+renew_lca_bundle

    # Move the supported_files to the prefix directory
    system "sudo" , "mv", "#{supported_files}", "#{prefix}"
  end

   test do
    system "#{bin}/bito"
  end
end