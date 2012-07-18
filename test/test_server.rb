$LOAD_PATH << "../lib/"
$LOAD_PATH << "./lib"
require 'test/unit'
require 'flexmock/test_unit'
require 'tmux'



class TC_Server < Test::Unit::TestCase

  def setup
    @server = flexmock()
    @server.should_receive(:invoke_command).with("list-sessions").and_return("0: 3 windows (created Wed Jul 18 08:51:41 2012) [184x53] (attached)")
    @server = Tmux::Server.new
  end

  def test_server_has_sessions
    sessions = @server.sessions
    assert_equal(Array, sessions.class)
    assert_equal(1, sessions.length)
    assert_equal(Tmux::Session, sessions[0].class)
  end
end
