$LOAD_PATH << "../lib/"
$LOAD_PATH << "./lib"
require 'test/unit'
require 'flexmock/test_unit'
require 'tmux'
require 'pp'


class TC_Window < Test::Unit::TestCase
  include FlexMock::TestCase

  def setup
    @server = flexstub(Tmux::Server.new)
    @session = flexmock()
    @server.should_receive(:invoke_command).with("list-sessions").and_return("0: 3 windows (created Wed Jul 18 08:51:41 2012) [184x53] (attached)")
    @server.should_receive(:version).with_no_args.and_return("1.6")

    @server.should_receive(:invoke_command).with("list-windows -t 0").and_return("1: rtakaishi@ignis [226x56] [layout 1f5f,226x56,0,0]
2: rtakaishi@ignis [226x56] [layout 46c9,226x56,0,0{113x56,0,0,112x56,114,0}]
3: rtakaishi@ignis [226x56] [layout 1f5f,226x56,0,0] (active)")

    @server.should_receive(:invoke_command).with("list-panes -t 0:1").and_return("0: [56x56] [history 58/50000, 18069 bytes] %5 (active)
1: [55x56] [history 1264/50000, 321147 bytes] %1")
    
    @server.invoke_command("list-sessions")
    @server.invoke_command("list-windows -t 0") 
    @session = @server.sessions[0]
    @window = @session.windows[1]
    @panes = @window.panes
  end

  def test_window_has_panes
    assert_equal(Array, @panes.class)
    assert_equal(2, @panes.length)
    assert_equal(Tmux::Pane, @panes[0].class)
  end
end
