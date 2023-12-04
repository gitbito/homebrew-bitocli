class BitoCliAT36 < Formula
    desc "Bito CLI Version 3.6"
    version "3.6.0"
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
      sha256 "94e3c2136084d09c1b9469a8cdcfac3fe8e779040d12ca497c062e5156023ae2"
    elsif installOS == "macos" && installArch == "x86"
      sha256 "b9c884d472dee125163fcc5d3bc6ac0c9cc9d05c18b4f0bc0f6f227f2d2ae74f"
    elsif installOS == "linux" && installArch == "arm"
      sha256 "2ab39f150a410af82d7f264d0c70cb39c5f04030aca7d22ebc51462004db0b0b"
    elsif installOS == "macos" && installArch == "arm"
      sha256 "8bb884c4f53115db01c9399be89665279a1913b96baa18a1b35bfa6949aa4da2"
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