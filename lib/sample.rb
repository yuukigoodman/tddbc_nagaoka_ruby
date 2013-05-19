# -*- encoding: utf-8 -*-

class Version
  def initialize(var)
    @var = var
  end

  def self.valid?(var)
    !!(var =~ /^JDK\d*u\d*$/)
  end

  def self.parse(var)
    return raise unless self.valid?(var)
    Version.new(var)
  end

  def family_number
    return $1.to_i if /JDK(\d*)/ =~ @var
  end

  def update_number
    return $1.to_i if /JDK\d*u(\d*)/ =~ @var
  end

  def lt(ver_obj)
    return update_number < ver_obj.update_number if family_number == ver_obj.family_number
    family_number < ver_obj.family_number
  end
end
