require 'formula'

class GrFosphor < Formula
  homepage 'http://sdr.osmocom.org/trac/wiki/GrOsmoSDR'
  head 'git://git.osmocom.org/gr-fosphor', :shallow => false,
    :revision => '7b6b9961bc2d9b84daeb42a5c8f8aeba293d207c'

  depends_on 'cmake' => :build
  depends_on 'himikk/sdrtools/gr-osmosdr'
  depends_on 'himikk/sdrtools/gnuradio'

  def install
    mkdir 'build' do
      system 'cmake', '..', *std_cmake_args << "-DPYTHON_LIBRARY=#{python_path}/Frameworks/Python.framework/"
      system 'make'
      system 'make install'
    end
  end

  def python_path
    python = Formulary.factory('python')
    kegs = python.rack.children.reject { |p| p.basename.to_s == '.DS_Store' }
    kegs.find { |p| Keg.new(p).linked? } || kegs.last
  end
end
