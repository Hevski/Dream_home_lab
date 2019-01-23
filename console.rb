require('pry')
require_relative('models/property')

Property.delete_all()

home1 = Property.new({'value' => '£500,000', 'no_of_bedrooms' => '4', 'status' => 'buy', 'build' => 'detached'})
home1.save()
home2 = Property.new({'value' => '300,000', 'no_of_bedrooms' => '5', 'status' => 'let', 'build' => 'flat'})
home2.save()
home3 = Property.new({'value' => '270,000', 'no_of_bedrooms' => '3', 'status' => 'buy', 'build' => 'semi-detached'})
home3.save()
home4 = Property.new({'value' => '800,000', 'no_of_bedrooms' => '10', 'status' => 'buy', 'build' => 'detached'})
home4.save()
home1.value = "450,000"
home1.update()

home1.delete()

binding.pry
nil
