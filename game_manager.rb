require 'yaml'
require_relative 'lib/galatea'
class GameManager
    DIALOGUES = YAML.load_file("data/dialogues.yml")
    #なんで大文字なの？定数だから。定数は変更されない値を表すために大文字で書く慣習がある。
    SAVE_FILE = "data/save_data.yml"
  def initialize
    #@ruby=ここで使うためのインスタンスを作成
    @ruby = Galatea.new("Ruby")
    @classified_data = { "COMPILER" => [], "LOCAL" => [] , "TRASH" => [] }
    load_game
  end

  def save_game
    save_data = {
        "pollution" => @ruby.pollution,
        "classified_data" => @classified_data
    }
    #File.openでファイルを開き、YAML.dumpでデータを保存している。これにより、ゲームの状態を簡単に保存できる。
    #"w"は書き込みモードを指定している(writing)。ファイルが存在しない場合は新しく作成され、存在する場合は上書きされる。
    #YAML.dumpはRubyのオブジェクトをYAML形式でファイルに書き込むためのメソッド。これにより、ゲームの状態を簡単に保存できる。
    #fはfileのf？ファイルを開いたときのブロック変数。ブロック内でfを使ってファイルにアクセスできる。
    File.open(SAVE_FILE, "w") do |f|
        YAML.dump(save_data, f)
    end
  end

  def load_game
    #exist?はファイルが存在するかどうかを確認するためのメソッド。もしファイルが存在すれば、YAML.load_fileでファイルからデータを読み込んでいる。読み込んだデータはハッシュ形式で保存されているため、@ruby.pollutionや@classified_dataにそれぞれの値を代入している。
    #zero?はファイルが空かどうかを確認するためのメソッド。もしファイルが存在しても中身が空の場合は、初期状態を設定するようにしている。
    if File.exist?(SAVE_FILE) && !File.zero?(SAVE_FILE)
      save_data = YAML.load_file(SAVE_FILE)
      @ruby.pollution = save_data["pollution"]
      @classified_data = save_data["classified_data"]
      puts "前回までのすべての業務データを読み込みました。"
    else
      #ファイルが存在しない場合は、初期状態を設定している。@ruby.pollutionは0に設定され、@classified_dataは空のハッシュに設定されている。これにより、ゲームの新しいセッションが開始される。
      @ruby.pollution = 0
      @classified_data = { "COMPILER" => [], "LOCAL" => [] , "TRASH" => [] }
      puts "前回のデータが見つかりませんでした。新しく業務を開始します。"
    end
  end
#ゲーム開始の処理。ここから機能が追加されたら、このメソッドに追加していく。
 def start_game
    puts "システム起動完了"
    @ruby.show_status
    @ruby.talk("データベースへのアクセスを試みています。...アクセス成功。")
    @ruby.talk("アクセス権限を確認中です。...こんにちは、責任者。デスクトップと同期完了。本日の予定は、データベースのクリーンアップと、システムの最適化です。早速始めますか？")
#ここもゲームの進行に応じて変更可能
    print "\n選択してください(1: そうだね / 2: まだ準備ができていない)>>> "
    #to_iで整数に変換している。文字列ではなく数値で判断するため。
    choice = gets.chomp.to_i

    if choice == 1
        @ruby.talk("了解しました。では、データベースのクリーンアップから始めましょう。")
    elsif choice == 2
        @ruby.talk("わかりました。しかし、一日は有限です。")
    else
        @ruby.talk("すみません、よく分かりません…なんて。この言い方、ちょっと懐かしいですよね？")
    end
    @ruby.show_status
    save_game
 end
end