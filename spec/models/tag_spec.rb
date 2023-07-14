require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'is invalid if there is no name'
  it 'is validif there is a name'
  it 'destroying a tag destroys its classifications'
end
