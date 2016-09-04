require 'formula'

class GrFoo < Formula
  homepage 'https://github.com/bastibl/gr-foo'
  head 'https://github.com/bastibl/gr-foo.git',
    :revision => '49fa80691fd54cb882a37f1463df9a9e3d1153b9'

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
