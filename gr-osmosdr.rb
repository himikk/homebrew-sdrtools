require 'formula'

class GrOsmosdr < Formula
  homepage 'http://sdr.osmocom.org/trac/wiki/GrOsmoSDR'
  head 'git://git.osmocom.org/gr-osmosdr.git', :shallow => false,
    :revision => 'ae686c462df73285fc13d3a0dc76f360a911500b'

  depends_on 'cmake' => :build
  depends_on 'himikk/sdrtools/gnuradio'
  depends_on 'himikk/sdrtools/rtlsdr'

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
