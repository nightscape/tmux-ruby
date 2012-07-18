$LOAD_PATH << "../lib/"
$LOAD_PATH << "./lib"
require 'test/unit'
require 'flexmock/test_unit'
require 'tmux'
require 'pp'


class TC_Session < Test::Unit::TestCase
  include FlexMock::TestCase

  def setup
    @server = flexstub(Tmux::Server.new)
    @session = flexmock()
    @server.should_receive(:invoke_command).with("list-sessions").and_return("0: 3 windows (created Wed Jul 18 08:51:41 2012) [184x53] (attached)")
    @server.should_receive(:version).with_no_args.and_return("1.6")

    @server.should_receive(:invoke_command).with("list-windows -t 0").and_return("1: rtakaishi@ignis [226x56] [layout 1f5f,226x56,0,0]
2: rtakaishi@ignis [226x56] [layout 46c9,226x56,0,0{113x56,0,0,112x56,114,0}]
3: rtakaishi@ignis [226x56] [layout 1f5f,226x56,0,0] (active)")
    
    @server.invoke_command("list-sessions")
    @server.invoke_command("list-windows -t 0") 
    @session = @server.sessions[0]
    @windows = @session.windows
  end

  def test_session_has_windos
    assert_equal(Hash, @windows.class)
    assert_equal(3, @windows.length)
    assert_equal(Tmux::Window, @windows[1].class)
  end
end
