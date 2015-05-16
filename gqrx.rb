require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
# from: https://github.com/xlfe/homebrew-gnuradio

class Gqrx < Formula
  homepage 'https://github.com/csete/gqrx'
  head 'https://github.com/csete/gqrx.git'

  depends_on 'cmake' => :build
  depends_on 'qt'
#brew install --with-c+11 --universal boost
  depends_on 'boost'
  depends_on 'gnuradio'

  def patches
    #patch to compile to binary, comment out pulse audio and link boost correctly
    DATA
  end

  def install
    system "qmake -set PKG_CONFIG /usr/local/bin/pkg-config"
    system "qmake -query"
    system "qmake gqrx.pro"
    system "make"
    bin.install 'gqrx.app/Contents/MacOS/gqrx'
  end
end
__END__

diff --git a/applications/gqrx/receiver.cpp b/applications/gqrx/receiver.cpp
index bd656c2..e13b40c 100644
--- a/applications/gqrx/receiver.cpp
+++ b/applications/gqrx/receiver.cpp
@@ -200,7 +200,7 @@ void receiver::set_input_device(const std::string device)
 /*! \brief Select new audio output device. */
 void receiver::set_output_device(const std::string device)
 {
-    if (output_devstr.compare(device) == 0)
+    if (false && output_devstr.compare(device) == 0)
     {
 #ifndef QT_NO_DEBUG_OUTPUT
         std::cout << "No change in output device:" << std::endl
diff --git a/gqrx.pro b/gqrx.pro
index c8877c6..08acc94 100644
--- a/gqrx.pro
+++ b/gqrx.pro
@@ -16,24 +16,12 @@ contains(QT_MAJOR_VERSION,5) {

 TEMPLATE = app

-macx {
-    TARGET = Gqrx
-    ICON = icons/gqrx.icns
-    DEFINES += GQRX_OS_MACX
-} else {
-    TARGET = gqrx
-}
+TARGET = gqrx

 # enable pkg-config to find dependencies
-CONFIG += link_pkgconfig
+# CONFIG += link_pkgconfig

-unix:!macx {
-    packagesExist(libpulse libpulse-simple) {
-        # Comment out to use gr-audio (not recommended with ALSA and Funcube Dongle Pro)
-        AUDIO_BACKEND = pulse
-        message("Gqrx configured with pulseaudio backend")
-    }
-}
+#AUDIO_BACKEND = pulse

 RESOURCES += icons.qrc \
     textfiles.qrc
@@ -48,7 +36,7 @@ isEmpty(PREFIX) {
 }

 target.path  = $$PREFIX/bin
-INSTALLS    += target
+INSTALLS    += target

 #CONFIG += debug

@@ -214,18 +202,11 @@ macx {
     SOURCES += osxaudio/device_list.cpp
 }

-contains(AUDIO_BACKEND, pulse): {
-    PKGCONFIG += libpulse libpulse-simple
-} else {
-    PKGCONFIG += gnuradio-audio
-}
-
 PKGCONFIG += gnuradio-analog \
              gnuradio-blocks \
              gnuradio-digital \
              gnuradio-filter \
-             gnuradio-fft \
-             gnuradio-osmosdr
+             gnuradio-fft

 unix:!macx {
     LIBS += -lboost_system$$BOOST_SUFFIX -lboost_program_options$$BOOST_SUFFIX
@@ -233,7 +214,12 @@ unix:!macx {
 }

 macx {
-    LIBS += -lboost_system-mt -lboost_program_options-mt
+    LIBS += -lboost_system-mt -lboost_program_options-mt -lgnuradio-audio -lgnuradio-core -lgnuradio-osmosdr -lgruel
+    LIBPATH += /usr/local/lib
+    INCLUDEPATH += /usr/local/include
+    INCLUDEPATH += /usr/local/include/gnuradio
+    INCLUDEPATH += /usr/local/include/osmosdr
+    INCLUDEPATH += /opt/local/include
 }

 OTHER_FILES += \
