require 'test/unit'
require File.join(File.dirname(__FILE__),'..', 'lib','rb-bsdiff')

class TestPatch < Test::Unit::TestCase
  def test_responds_to_version
    assert_match /^\d+\.\d+(\.\d+)?(\.\w+)$/, BSDiff.version
  end
end
