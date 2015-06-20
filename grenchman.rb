class Grenchman < Formula
  homepage "http://leiningen.org/grench.html"
  url "https://technomancy.github.io/grenchman/downloads/grench-0.2.0-mac"
  sha256 "f70542dffc1f60e372b77582998570b02ff21c85f699fd1854c98e4359804bb6"

  depends_on :arch => :x86_64
  depends_on "libffi"

  def install
    bin.install "grench-0.2.0-mac" => "grench"
  end
end
