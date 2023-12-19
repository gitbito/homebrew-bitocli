class BitoCli < Formula
    desc "Bito CLI Version 3.8"
    version "3.8.0"
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
      sha256 "0f001140a91ae082a8d176db211d1fb60b7c34667385466959d125b818537807"
    elsif installOS == "macos" && installArch == "x86"
      sha256 "2501063bf749c22b5c1e95e2236898b420a66a91018b8d5edfd5d2a251516c66"
    elsif installOS == "linux" && installArch == "arm"
      sha256 "ce07bdd0c624b63920eec40071fcf8a9f218decd1a4e00807f53879f82a4d565"
    elsif installOS == "macos" && installArch == "arm"
      sha256 "adca8b017a3a3ef5139b0a10d9b94f191d8a5c569082fe38c28ab4b4160dff50"
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