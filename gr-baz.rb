require 'formula'

class GrBaz < Formula
  homepage 'http://wiki.spench.net/wiki/Gr-baz'
  head 'https://github.com/balint256/gr-baz.git',
    :revision => 'c20fdd8b7443aea54b416b93958cc7181300d250'

  depends_on 'cmake' => :build
  depends_on 'gnuradio'

  def install
    mkdir 'build' do
      system 'cmake', '..', '-DPYTHON_LIBRARY=/usr/local/Frameworks/Python.framework/Versions/2.7/Python ', *std_cmake_args
      system 'make'
      system 'make install'
    end
  end
end
