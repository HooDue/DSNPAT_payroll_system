class DayType
  attr_reader :is_holiday, :is_special_non_working, :is_restday

  def initialize(is_holiday, is_special_non_working, is_restday)
    @is_holiday = is_holiday
    @is_special_non_working = is_special_non_working
    @is_restday = is_restday
  end
end

class RegularDay < DayType
  def initialize
    super(false, false, false)
  end
end

class RestDay < DayType
  def initialize
    super(false, false, true)
  end
end

class Holiday < DayType
  def initialize
    super(true, false, false)
  end
end

class SpecialNonWorkingDay < DayType
  def initialize
    super(false, true, false)
  end
end

class SpecialRestDay < DayType
  def initialize
    super(false, true, true)
  end
end

class HolidayRestDay < DayType
  def initialize
    super(true, false, true)
  end
end

class DayTypeFactory
  def self.create(dayType)
    case dayType
    when 0 then RegularDay.new
    when 1 then RestDay.new
    when 2 then Holiday.new
    when 3 then SpecialNonWorkingDay.new
    when 4 then SpecialRestDay.new
    when 5 then HolidayRestDay.new
    else raise "Invalid day type"
    end
  end
end