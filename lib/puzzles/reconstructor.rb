class Reconstructor
  #atte_readerとは、クラスの外部からインスタンス変数を「読み取る」ためのメソッドを定義するためのものです。
  #このコードでは、shuffled_chips、reconstructed、およびoriginal_textの3つのインスタンス変数に対してattr_readerが定義されています。
  #これにより、クラスの外部からこれらのインスタンス変数の値を読み取ることができますが、変更することはできません。
  #ここでattr_readerを使用することで、クラスの外部からこれらの変数にアクセスできるようになり、コードの可読性と保守性が向上します。
    attr_reader :shuffled_chips,  :reconstructed, :original_text
  def initialize(original_text)
    @original_text = original_text
    @shuffled_chips = original_text.chars.shuffle
    @reconstructed = []
  end
  def active?
    #shuffled_chipsが空でないことを確認するためのメソッド。これにより、まだ再構築が完了していないかどうかを判断できます。
    #falseが返ってきたら、すべてのチップが再構築されていることを意味します。
    !@shuffled_chips.empty?
  end
  
  def pick_chip(index)
    #falseを返す、もしインデックスが負の数または@shuffled_chipsの長さ以上の場合（lengthは配列の要素数を返す）
      return false if index < 0 || index >= @shuffled_chips.length # 安全装置 - インデックスが範囲外の場合はfalseを返す
      #ifはここで終わり。falseが返ってこなかったら自動的に次の行へ。
    @reconstructed << @shuffled_chips.delete_at(index) # シャッフル配列から削除して、復元配列に追加
    #最後にtrueを返す。これにより、チップが正常に選択されたことを示すことができます。
    true
  end

  def success?
    #def　ちゃんと成功した？
    final_text = @reconstructed.join 
    @original_text == final_text 
  end
end