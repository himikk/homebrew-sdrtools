require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
# from: https://github.com/xlfe/homebrew-gnuradio

class Gqrx < Formula
  homepage 'https://github.com/csete/gqrx'
  head 'https://github.com/csete/gqrx.git',
    :revision => '7f98552701ec6fb27fa5d5a6ba1273c000761c5a'

  depends_on 'cmake' => :build
  depends_on 'qt'
#brew install --with-c+11 --universal boost
  depends_on 'boost'
  depends_on 'himikk/sdrtools/gnuradio'

  def patches
    #patch to compile to binary, comment out pulse audio and link boost correctly
    DATA
  end

  def install
    ENV.append_path "PKG_CONFIG_PATH", "#{lib}/pkgconfig"
    pkg_config_string = "export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig; "
    system pkg_config_string + "qmake -set PKG_CONFIG /usr/local/bin/pkg-config"
    system pkg_config_string + "qmake -query"
    system pkg_config_string + "qmake gqrx.pro"
    system pkg_config_string + "make"
    bin.install 'gqrx.app/Contents/MacOS/gqrx'
  end
end
__END__

diff --git a/gqrx.pro b/gqrx.pro
index c8877c6..032ff3e 100644
--- a/gqrx.pro
+++ b/gqrx.pro
@@ -24,6 +24,8 @@ macx {
     TARGET = gqrx
 }
 
+PKG_CONFIG_PATH += /usr/local/lib/pkgconfig
+
 # enable pkg-config to find dependencies
 CONFIG += link_pkgconfig
 
@@ -234,8 +236,16 @@ unix:!macx {
 
 macx {
     LIBS += -lboost_system-mt -lboost_program_options-mt
+    LIBPATH += /usr/local/lib
+    #INCLUDEPATH += /usr/local/include
+    #INCLUDEPATH += /usr/local/include/gnuradio
+    #INCLUDEPATH += /usr/local/include/osmosdr
+    INCLUDEPATH += /usr/local/include/boost
+    #INCLUDEPATH += /opt/local/include
 }
 
+QT_LIB_PATH += /usr/local/lib
+
 OTHER_FILES += \
     bookmarks.csv \
     gqrx.desktop \
