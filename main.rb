require_relative "game_manager"
puts "システム起動中..."
#ゲームマネージャーのインスタンスを作成し、ゲームを開始しているのでこっちでもrubyのインスタンスを作る必要はない。
manager = GameManager.new
manager.start_game