class BitoCli < Formula
    desc "Bito CLI for Linux x86 based architecure with version 3.1 for test"
    version "3.1.0"
    homepage "https://github.com/gitbito/CLI"
    url ""
    sha256 "5552b20267454b2b959a60a4cda01f060bfa4fe75beef963cec8e5ac6fd5405f"
    license ""
  
    installOS=""
    installArch=""

    def install
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
        elsif unmacarch == "arm"
            installArch = "arm"
        end

        url "https://github.com/gitbito/CLI/releases/download/v#{version}/bito-#{installOS}-#{installArch}.tar.gz"

      bin.install "bito-#{installOS}-#{installArch}" => "bito"
    end
  
    test do
      system "#{bin}/bito"
    end
  end
  