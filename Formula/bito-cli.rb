class BitoCli < Formula
    desc "Bito CLI for Linux x86 based architecure with version 3.6 for test"
    version "3.4.0"
    homepage "https://github.com/gitbito/CLI"
    sha256 "0af57fd8376d6d62ba2f62ff6be1b022d2220989483d5154d4380c5430176b94"
    license ""
  
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
    elsif unmacarch == "arm"
        installArch = "arm"
    end

    url "https://github.com/gitbito/CLI/releases/download/v#{version}/bito-#{installOS}-#{installArch}.tar.gz"
    
    def install

      # had to rewrite the above code because above variables aren't getting accessed in this function

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
      elsif unmacarch == "arm"
          installArch = "arm"
      end
  
      bin.install "bito-#{installOS}-#{installArch}" => "bito"
    end
  
    test do
      system "#{bin}/bito"
    end
  end
  