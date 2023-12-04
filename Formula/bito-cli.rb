class BitoCli < Formula
    desc "Bito CLI Version 3.7"
    version "3.7.0"
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
      sha256 "2b4f0eb130e987bbf9d61ac4f659b337ca8fca418b12f10a9d859995b8916979"
    elsif installOS == "macos" && installArch == "x86"
      sha256 "a645906c0aa7bcd030510e1b31b76e77b45da5d09818ee285b55d7bb06ae209d"
    elsif installOS == "linux" && installArch == "arm"
      sha256 "f200f8b6c4e5f0b5f726bbedfd3508f0c2026dda4f5d17b6d6c98cbfa2c7a243"
    elsif installOS == "macos" && installArch == "arm"
      sha256 "082bd29fd83328939cde9417824315b140b77ecf7bb181cc8386cc38ebf60209"
    end

     url "https://github.com/gitbito/CLI/releases/download/v#{version}/bito-#{installOS}-#{installArch}.tar.gz"
     
     def install
      installOS, installArch = self.class.set_arch_and_os
      bin.install "bito-#{installOS}-#{installArch}" => "bito"
    end

     test do
      system "#{bin}/bito"
    end
  end