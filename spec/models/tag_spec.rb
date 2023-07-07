require 'rails_helper'

RSpec.describe Tag, type: :model do
  context 'Is invalid' do
    it 'if there is no name'
  end

  context 'Is valid' do
    it 'if there is a name'
  end

  context 'Associations' do
    it 'destroying a tag destroys its classifications'
  end
end
