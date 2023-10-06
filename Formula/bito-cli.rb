class BitoCli < Formula
    desc "Bito CLI for Linux x86 based architecure with version 3.6 for test"
    version "3.5.0"
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
      sha256 "61ae30565853704954286a2c2cf0d3cd0d8a8d1f7c7000c03f78237a09e0ab57"
    elsif installOS == "macos" && installArch == "x86"
      sha256 "c65f5c75f858ce399488b4f91f97b5dab8d04a7732b344e9f706971f0a2d718c"
    elsif installOS == "linux" && installArch == "arm"
      sha256 "87d8e6d1e66367cb349d2800ac5e2c0de597400de632c7370264ad593eea56a7"
    elsif installOS == "macos" && installArch == "arm"
      sha256 "fec2beaf87ab5d4e49bd56bc49b5ec9ba54df245d86bad5e67a4975166135862"
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