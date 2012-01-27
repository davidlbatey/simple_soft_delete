require "simple_soft_delete/version"
require 'active_support/concern'

module SimpleSoftDelete
  
  extend ActiveSupport::Concern

  included do
    alias_method :destroy, :delete
    default_scope where(:deleted => false)
  end

  def delete
    update_attribute(:deleted, true)
  end

  module ClassMethods

    def delete_all
      update_all(:deleted => true)
    end

    def with_deleted
      unscoped
    end

    alias_method :destroy_all, :delete_all
  end

end
