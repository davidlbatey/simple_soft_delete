class Bar < ActiveRecord::Base
  include SimpleSoftDelete

  validates_uniqueness_of :name, :scope => :deleted
end
