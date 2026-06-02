class Reconstructor
  def self.play(type,ruby)
    if type == :typo
      play_typo_puzzle(ruby)
    elsif type == :shuffle
      play_shuffle_puzzle(ruby)
    else
      puts "警告：責任者の業務ではありません。"
    end 
  end

  def self.play_typo_puzzle(ruby)
        ruby.talk("\n業務：複数のバグが検出されました。コードを修正してください。")
        question = "def greet; puts 'hello'; endd"
    correct_answer = "def greet; puts 'hello'; end"

    puts "\n【破損コード】: #{question}"
    print "修正後のコードを入力 >>> "
    player_input = gets.chomp
    if player_input == correct_answer
      ruby.talk(">> 修正成功。構文エラーが解消されました。")
      return true
    else
      ruby.talk(">> 修正失敗。ノイズが混入しています。")
      ruby.pollution += 2
      return false
    end
  end

  def self.play_shuffle_puzzle(ruby)
        ruby.talk("\n業務：コードの順序が入れ替わっています。正しい順序に並び替えてください。")
  end
end
