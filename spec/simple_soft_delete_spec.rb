require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SimpleSoftDelete do

  context "an instance of a model" do
    
    it "flags foo as deleted on delete" do
      foo = Foo.create :name => "david"
      foo.delete

      Foo.find_by_name("david").should be_nil
      Foo.unscoped.find_by_name("david").should == foo
    end

    it "flags foo as deleted on destroy" do
      foo = Foo.create :name => "bob"
      foo.destroy

      Foo.find_by_name("bob").should be_nil
      Foo.unscoped.find_by_name("bob").should == foo
    end
  
  end

  context "all instances of a model" do

    it "flags all of the models as deleted" do
      Foo.create :name => "john"
      Foo.create :name => "kieran"
      Foo.delete_all

      Foo.count.should == 0
      Foo.unscoped.count.should == 2
    end

    it "flags all of the models as deleted on destroy" do
      Foo.create :name => "fraser"
      Foo.create :name => "dean"
      Foo.create :name => "steve"
      Foo.destroy_all

      Foo.count.should == 0
      Foo.unscoped.count.should == 3
    end

    it "aliases unscoped as with_deleted" do
      Foo.create :name => "bob"
      Foo.create :name => "mike"
      Foo.delete_all

      Foo.count.should == 0
      Foo.with_deleted.count.should == 2
    end

    it "flags a subsection" do
      Foo.create :name => "chris"
      Foo.create :name => "andy"

      Foo.where("name = 'andy'").delete_all
      
      Foo.count.should == 1
    end
  
  end

  context "with uniqueness validations" do
    
    it "validates name with the scope undeleted" do
      Bar.create :name => "chris"

      Bar.create(:name => "chris").should_not be_valid
      Bar.count.should == 1
    end

    it "scopes to deleted correctly" do
      bar = Bar.create :name => "lucius"
      bar.delete
 
      Bar.create(:name => "lucius").should be_valid
      Bar.count.should == 1
    end

  end

end
