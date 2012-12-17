require 'openssl'
require 'test/unit'
require File.join(File.dirname(__FILE__), '..', 'lib','rb-bsdiff')

class TestPatch < Test::Unit::TestCase
  def setup
    FileUtils.rm_f FileList['../tmp/**/*']
  end

  # NOT calling this on teardown to aid in debugging.
  # def teardown
  #   FileUtils.rm_f FileList['../tmp/**/*']
  # end

  def test_diff_and_patch

    #../bsdiff b0 b1 p0
    #../bspatch b0 b3 p0

    b0_chk = OpenSSL::Digest::MD5.hexdigest(File.read('test/fixtures/b0'))
    b1_chk = OpenSSL::Digest::MD5.hexdigest(File.read('test/fixtures/b1'))

    # create patch file from bspatch.o to bsdiff.o
    BSDiff.diff('test/fixtures/b0', 'test/fixtures/b1', 'tmp/p0')

    # apply patch to bspatch.o as bspatch2.o
    BSDiff.patch('test/fixtures/b0', 'tmp/b3', 'tmp/p0')

    b3_chk = OpenSSL::Digest::MD5.hexdigest(File.read('tmp/b3'))

    # bspatch2.o should equal bsdiff.o
    assert_equal(b1_chk,b3_chk)
  end
end
