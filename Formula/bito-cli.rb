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
      bin.install "bito-#{installOS}-#{installArch}" => "bito"

      lca_bundle_url = "https://github.com/gitbito/CLI/releases/download/packages/bito-lca-#{installOS}.tar.gz"
      supported_files_url = "https://github.com/gitbito/CLI/releases/download/packages/slashCommands.json"
 
      lca_bundle = "bito-lca-#{installOS}.tar.gz"
      supported_files = "slashCommands.json"

      # Get current user's information
      user_info = Etc.getpwuid

      # Extract home directory from user information
      home_directory = user_info.dir

      prefix = home_directory+"/.bitoai/etc"
  
      # Use curl to download files
      system "curl", "-L", "#{lca_bundle_url}", "-o", "#{lca_bundle}"
      system "curl", "-L", "#{supported_files_url}", "-o", "#{supported_files}"

      # Unpack the lca_bundle tar.gz file
      system "tar", "-xzf", "#{lca_bundle}", "-C", "#{prefix}"

      # Move the supported_files to the prefix directory
      FileUtils.mv("#{supported_files}", "#{prefix}")
    end

     test do
      system "#{bin}/bito"
    end
  end