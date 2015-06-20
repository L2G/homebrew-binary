# Find downloads at: https://helpx.adobe.com/air/kb/archived-air-sdk-version.html
class AdobeAirSdkFlex < Formula
  desc "Adobe AIR SDK & compiler"
  homepage "https://www.adobe.com/devnet/air/air-sdk-download.html"
  url "http://airdownload.adobe.com/air/mac/download/18.0/AdobeAIRSDK.tbz2"
  version "18.0.0.180"
  sha256 "e431348a81e99c8d07b1b42b4b35895f202ad9df53a5cb1f08b3461c5bed16d4"

  conflicts_with "adobe-air-sdk"

  def install
    rm_f Dir["bin/*.bat"]
    libexec.install Dir["*"]
    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  def caveats; <<-EOS.undent
    To set AIR_HOME:
      export AIR_HOME=#{libexec}
    EOS
  end

  test do
    assert_equal "#{version}\n", shell_output("#{bin}/adt -version")
  end
end
