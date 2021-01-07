class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.find_all do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    interested = Hash.new {|h,k| h[k] = []}
     @exhibits.each do |exhibit|
      @patrons.each do |patron|
        if patron.interests.include?(exhibit.name)
          interested[exhibit] << patron
        else
          interested[exhibit]
        end
      end
    end
     interested
  end

  def ticket_lottery_contestants(exhibit)
    patrons_by_exhibit_interest.find_all do |exhibit, patrons|
      patrons.map do |patron|
         patron.spending_money < exhibit.cost
      end
    end.flatten
  end
end