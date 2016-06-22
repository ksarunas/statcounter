RSpec.describe Statcounter::ParamsEncoder do
  subject(:params_encoder) { described_class.new(credentials) }
  let(:credentials) { { username: username, secret: secret } }
  let(:username) { 'john_brown' }
  let(:secret) { 'johns_little_secret' }
  let(:default_credentials) { { username: default_username, secret: default_secret } }
  let(:default_username) { 'tom_brown' }
  let(:default_secret) { 'toms_little_secret' }

  before { allow(Statcounter).to receive(:default_credentials).and_return(default_credentials) }

  describe '#encode' do
    subject(:query) { params_encoder.encode(params) }
    let(:params) { { test: 1 } }
    let(:parsed_query) { Rack::Utils.parse_nested_query(subject) }

    before do
      Timecop.freeze(Time.now.utc)
    end

    it 'appends default params' do
      expect(parsed_query).to include(
        'vn' => '3',
        't' => Time.now.to_i.to_s,
        'f' => 'json',
        'u' => username,
        'test' => '1',
      )

      expect(parsed_query).to include('sha1')
    end

    context 'when default param is given' do
      let(:params) { { vn: 4 } }

      it 'uses given param value' do
        expect(parsed_query).to include('vn' => '4')
      end
    end

    context 'when credentials not given' do
      let(:credentials) { nil }

      it 'uses default credentials' do
        expect(parsed_query).to include('u' => default_username)
      end
    end

    context 'when param is array' do
      let(:params) { { test: [1, 2] } }

      it 'builds flat query' do
        expect(query).to match(/test=1&test=2/)
      end
    end
  end
end
