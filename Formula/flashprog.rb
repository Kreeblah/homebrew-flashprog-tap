class Flashprog < Formula
  desc "IC programmer application"
  homepage "https://flashprog.org"
  url "https://github.com/SourceArcade/flashprog/archive/refs/tags/v1.5.tar.gz"
  sha256 "2a0f9f4a00d89ccd6ed4ca71a16a6f83734559aa9fd14b59eb89e76feb36ce16"
  license "GPL-2.0-or-later"
  head "https://github.com/SourceArcade/flashprog.git", branch: "main"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build

  depends_on "libftdi"
  depends_on "libjaylink"
  depends_on "libusb"

  def install
    ENV["CONFIG_ENABLE_LIBPCI_PROGRAMMERS"] = "no"

    # install DirectHW for osx x86 builds
    if OS.mac? && Hardware::CPU.intel?
      (buildpath/"DirectHW").install resource("DirectHW")
      ENV.append "CFLAGS", "-I#{buildpath}"
    end

    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system bin/"flashprog", "--version"

    output = shell_output("#{bin}/flashprog --erase --programmer dummy 2>&1", 1)
    assert_match "No EEPROM/flash device found", output
  end
end
