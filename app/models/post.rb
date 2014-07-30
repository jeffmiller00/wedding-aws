class Post < ActiveRecord::Base
  cattr_writer :admin

  def self.admin
    @@admin || false
  end
end
