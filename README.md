# Simple Soft Delete

Simple soft delete is a rails 3 gem for flagging models once they have
been deleted/destroyed with the following commands:

- Model.delete_all
- Model.destroy_all
- model.delete
- model.destroy

## Installation

Add a deleted column to the model you want to soft delete

```
class AddDeletedToModel < ActiveRecord::Migration                 
  def change                                         
    add_column :models, :deleted, :boolean, :null => false, :default => false 
  end                                                                           
end
```

Add SimpleSoftDelete module to the model

```
class Model < ActiveRecord::Base                                                                             
  include SimpleSoftDelete
  
  # Scope any uniqueness validations
  validates_uniqueness_of :attribute_name, :scope => :deleted
end
```

## Example usage

```
Model.count => 10
model = Model.find 3
model.delete # UPDATE `models` SET `deleted` = 1, `updated_at` = '2012-01-27 22:34:52' WHERE `models`.`id` = 3
Model.count => 9 # SELECT COUNT(*) FROM `models` WHERE `models`.`deleted` = 0
Model.unscoped.count => 10 # SELECT COUNT(*) FROM `models`
Model.with_deleted.count => 10
```

```
Model.count => 10
Model.delete_all
Model.count => 0
Model.with_deleted.count => 10
```
*it also works the same for destroy which just aliases their delete counterparts*