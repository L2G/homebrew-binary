class Mpress < Formula
  desc "High-performance packer for Darwin executables"
  homepage "http://www.matcode.com/mpress.htm"
  url "http://www.matcode.com/mac-mpress.tar.gz"
  version "1.21"
  sha256 "2c3d9e5a20645e1f28e699a8527c3eaa27b8cabe8863be58bb08662ea6f86718"
  revision 1

  depends_on :arch => :intel

  # Install only the i386 slice since x86_64 has problems. See:
  # https://github.com/Homebrew/homebrew-binary/pull/252
  def install
    bin.mkpath
    system "lipo", "-thin", "i386", "mmpress", "-o", "#{bin}/mpress"
  end

  def caveats; <<-EOS.undent
    Because of intractable x86_64 issues, the installed mpress binary is
    stripped down to i386 code and can only compress other i386 binaries.
    EOS
  end

  test do
    assert_match(/MACHO-MPRESS v#{version}$/,
                 shell_output("#{bin}/mpress", 1),
                 "Version in formula should match version of binary")

    test_program = <<-EOS.undent
    #include <stdio.h>
    int main() { puts("Hello world!"); }
    EOS

    (testpath/"test.c").write test_program
    system ENV.cc, "test.c", "-arch", "i386", "-o", "test"
    system "#{bin}/mpress", "test"
    assert_match shell_output("./test").chomp, "Hello world!"
  end
end
