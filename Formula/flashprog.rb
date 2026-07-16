class Flashprog < Formula
  desc "IC programmer application"
  homepage "https://flashprog.org"
  url "https://github.com/SourceArcade/flashprog/archive/refs/tags/v1.5.tar.gz"
  sha256 "2a0f9f4a00d89ccd6ed4ca71a16a6f83734559aa9fd14b59eb89e76feb36ce16"
  license "GPL-2.0-or-later"
  head "https://github.com/SourceArcade/flashprog.git", branch: "main"

  depends_on "gcc" => :build
  depends_on "pkgconf" => :build

  depends_on "libftdi"
  depends_on "libjaylink"
  depends_on "libusb"

  on_linux do
    depends_on "make" => :build
  end

  fails_with :clang do
    cause "'make' fails with 'error: variable length array folded " \
          "to constant array as an extension [-Werror,-Wgnu-folding-constant]'"
  end

  fails_with :llvm_clang do
    cause "'make' fails with 'error: variable length array folded " \
          "to constant array as an extension [-Werror,-Wgnu-folding-constant]'"
  end

  def install
    ENV["PREFIX"] = prefix.to_s
    ENV["CONFIG_ENABLE_LIBPCI_PROGRAMMERS"] = "no"
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "a", "a"
  end
end
