module WorldCup
  class Event
    attr_accessor :id, :type, :player, :time

    def initialize(input_hash)
      self.id = input_hash['id']
      self.type = input_hash['type_of_event']
      self.player = input_hash['player']
      self.time = input_hash['time']
    end

    def to_s
      "##{id}: #{type}@#{time} - #{player}"
    end
  end
end
