RSpec.shared_context 'post setup' do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, user: user) }
end
