class PerforceServer < Formula
  homepage "http://www.perforce.com/"
  version "2015.1.1171507"

  if MacOS.prefer_64_bit?
    url "http://filehost.perforce.com/perforce/r15.1/bin.darwin90x86_64/p4d"
    sha256 "b42758ebe7b54e672b513c34c88f399d0da7b4de1fd23b9f56d222a4f1f3bae5"
  else
    url "http://filehost.perforce.com/perforce/r15.1/bin.darwin90x86/p4d"
    sha256 "0ecfd0510091232a53c24e426e1d48d460604ec3f9ea896d02736f93d151d5a5"
  end

  def install
    bin.install "p4d"
    (var+"p4root").mkpath
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/p4d</string>
        <string>-p</string>
        <string>1666</string>
        <string>-r</string>
        <string>#{var}/p4root</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{var}/p4root</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/p4d.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/p4d.log</string>
    </dict>
    </plist>
    EOS
  end

  test do
    os_tag = (MacOS.prefer_64_bit? ? "P4D/DARWIN90X86_64" : "P4D/DARWIN90X86")
    (version_year, version_minor, version_build) = version.to_s.split(".")
    assert_match(
      %r[#{os_tag}/#{version_year}\.#{version_minor}/#{version_build} ],
      shell_output("#{bin}/p4d -V")
    )
  end
end
