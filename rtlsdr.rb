require 'formula'

class Rtlsdr < Formula
  homepage 'http://sdr.osmocom.org/trac/wiki/rtl-sdr'
  head 'git://git.osmocom.org/rtl-sdr.git',
    :shallow => false,
    :revision => 'e3c03f738f5aef4dc51e2b741fbdb542b9cc1bb1'

  depends_on 'pkg-config' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'cmake' => :build
  depends_on 'libusb'

  if MacOS::Xcode.version.to_f >= 4.3
    depends_on 'autoconf'
  end

  def install
    args = ["--prefix=#{prefix}"]
    system "autoreconf -i"
    system "./configure", *args
    system "make install"
  end
end
