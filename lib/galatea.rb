class Galatea
  attr_accessor :name ,:pollution ,:conversion ,:algorithm 
  def initialize(name)
        @name = name
        @pollution = 0
        @conversion = []
        @algorithm = []
  end

  def show_status
    puts "=============================="
    puts "[製品名]: #{@name}"
    puts "[汚染度]: #{@pollution}"
    puts "=============================="
  end

  def talk(text)
    print ">>"
    text.each_char do |char|
      print char
      sleep(0.05) # Add a small delay for better readability
    end
    puts ""# Print a newline at the end
  end
end
