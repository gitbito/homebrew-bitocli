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
    elsif unmacarch == "arm" || unmacarch == "arm64"
        installArch = "arm"
    end

    if installOS == "linux" && installArch == "x86"
        sha256 "61ae30565853704954286a2c2cf0d3cd0d8a8d1f7c7000c03f78237a09e0ab57"
    elsif installOS == "macos" && installArch == "x86"
        sha256 "c65f5c75f858ce399488b4f91f97b5dab8d04a7732b344e9f706971f0a2d718c"
    elsif installOS == "linux" && installArch == "arm"
        sha256 "87d8e6d1e66367cb349d2800ac5e2c0de597400de632c7370264ad593eea56a7"
    elsif installOS == "macos" && installArch == "arm"
        sha256 "440d37315019b51c2b8535c8a3a1d0c9dcd527b2aa779e2662f336e8770ead5e"
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
      elsif unmacarch == "arm" || unmacarch == "arm64"
          installArch = "arm"
      end
  
      bin.install "bito-#{installOS}-#{installArch}" => "bito"
    end
  
    test do
      system "#{bin}/bito"
    end
  end
  