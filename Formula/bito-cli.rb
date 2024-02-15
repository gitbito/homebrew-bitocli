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
      sha256 "f0f71dad2083c71e2faa2c856233b81deb3ff3daf74b60d890d88988153d72e3"
    elsif installOS == "macos" && installArch == "x86"
      sha256 "26c706a60b735250caa525a1effa47875d392d1f351585e35b7b7d129b48eadf"
    elsif installOS == "linux" && installArch == "arm"
      sha256 "513d4e2352542a8876d88bed05dec6dbdead90cf99b15ddd83a180ce24668122"
    elsif installOS == "macos" && installArch == "arm"
      sha256 "79a8f1f9022848e01ab1380655162653735f997de8099f861b925f0fd4689a4f"
    end

     url "https://github.com/gitbito/CLI/releases/download/v#{version}/bito-#{installOS}-#{installArch}.tar.gz"

     def install
      installOS, installArch = self.class.set_arch_and_os

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

      # Use curl to download files
      system "curl", "-L", "#{lca_bundle_url}", "-o", "#{lca_bundle}"
      system "curl", "-L", "#{supported_files_url}", "-o", "#{supported_files}"

      # Unpack the lca_bundle tar.gz file
      system "tar", "-xzf", "#{lca_bundle}", "-C", "#{prefix}"
       # Rename the lca_bundle before unpacking
      system "mv", "#{prefix}"+"/"+lca_os_specific, "#{prefix}"+"/"+renew_lca_bundle

      # Move the supported_files to the prefix directory
      FileUtils.mv("#{supported_files}", "#{prefix}")

      # Change the permissions of the directory and all its contents
      FileUtils.chmod_R(0777, prefix)

      # Remove the directory and its contents
      FileUtils.remove_dir("#{bin}/bito", true)

      bin.install "bito-#{installOS}-#{installArch}" => "bito"
    end

     test do
      system "#{bin}/bito"
    end
  end