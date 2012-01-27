ActiveRecord::Schema.define do                                                  
  create_table "foos", :force => true do |t|                                    
    t.string   "name"                                                              
    t.boolean  "deleted", :null => false, :default => false                        
  end                                                                              
end      
