class Libjaylink < Formula
  desc "Provide interoperability with JLINK hardware"
  homepage "https://gitlab.zapb.de/libjaylink/libjaylink"
  url "https://gitlab.zapb.de/libjaylink/libjaylink.git",
      tag:      "0.4.0",
      revision: "fa52ee261ba39f9806ac7cfa658d4f231132ab4a"
  license "GPL-2.0-or-later"
  head "https://gitlab.zapb.de/libjaylink/libjaylink.git", branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build

  depends_on "libusb"

  on_linux do
    depends_on "make" => :build
  end

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "a", "a"
  end
end
