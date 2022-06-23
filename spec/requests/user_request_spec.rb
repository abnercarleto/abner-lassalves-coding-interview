require 'rails_helper'

RSpec.describe "Users", type: :request do

  RSpec.shared_context 'with multiple companies' do
    let!(:company_1) { create(:company) }
    let!(:company_2) { create(:company) }

    before do
      5.times do
        create(:user, company: company_1)
      end
      5.times do
        create(:user, company: company_2)
      end
    end
  end

  describe "#index" do
    let(:result) { JSON.parse(response.body) }

    context 'when fetching users by company' do
      include_context 'with multiple companies'

      it 'returns only the users for the specified company' do
        get company_users_path(company_1)

        expect(result.size).to eq(company_1.users.size)
        expect(result.map { |element| element['id'] } ).to eq(company_1.users.ids)
      end
    end

    context 'when filtering by username' do
      include_context 'with multiple companies'
      let(:user) { company_1.users.sample }

      it do
        get company_users_path(company_1, params: { username: user.username })

        expect(result.size).to eq(1)
        expect(result.first['username']).to eq(user.username)
      end
    end

    context 'when filtering by partial username' do
      include_context 'with multiple companies'
      let(:user) { company_1.users.sample }

      it do
        get company_users_path(company_1, params: { username: user.username[0..3] })

        expect(result.size).to eq(1)
        expect(result.first['username']).to eq(user.username)
      end
    end

    context 'when fetching all users' do
      include_context 'with multiple companies'

      it 'returns all the users' do

      end
    end
  end
end
