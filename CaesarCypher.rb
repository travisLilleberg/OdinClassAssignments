def caesar_cypher(string, shift)
  string.each_char do |c|
    unless(c =~ /[a-zA-Z]/) 
      print c
      next
    end
    
    print caesar_wrap_char(c.ord, shift).chr
  end
end

def caesar_wrap_char(ord, shift)
  zeds = [122, 90]
  zeds.each do |z| 
    if(ord.between?(z - shift + 1, z))
      return ord + shift - 26
    end
  end
  ord + shift
end