class Bob
  class << self
    def hey(remark)
      remark= remark.strip
      return 'Fine. Be that way!' if remark.empty?
      return "Calm down, I know what I'm doing!" if shouting?(remark) && question?(remark)
      return 'Whoa, chill out!' if shouting?(remark)
      return 'Sure.' if question?(remark)
      'Whatever.'
    end

    private

    def shouting?(remark)
      remark.upcase == remark && remark.match(/[A-Z]/)
    end

    def question?(remark)
      remark.end_with?('?')
    end
  end
end
