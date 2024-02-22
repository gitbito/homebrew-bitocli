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
    end

     test do
      system "#{bin}/bito"
    end
  end