class Phrase
  def initialize(string)
    @words = string.downcase.scan(/\w+'?\w|\d/)
  end

  def word_count
    @words.group_by(&:itself)
          .reduce({}) { |hash, (word, words)| hash.merge(word => words.size) }
  end
end
