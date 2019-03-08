class Complement
  class << self
    def of_dna(dna)
      # dna.each_char.reduce("") { |rna, key| rna << of_dna_key(key) }
      dna.chars.map(&method(:of_dna_key)).join
    end

    private

    def of_dna_key(key)
      case key
      when 'G'
       'C'
      when 'C'
       'G'
      when 'T'
       'A'
      when 'A'
       'U'
      end
    end
  end
end
