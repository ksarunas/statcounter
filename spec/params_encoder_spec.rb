RSpec.describe Statcounter::ParamsEncoder do
  subject(:params_encoder) { described_class.new(credentials) }
  let(:credentials) { nil }

  before { allow(Statcounter).to receive(:default_credentials).and_return(default_credentials) }

  describe '#encode' do
    subject(:query) { params_encoder.encode(params) }
    let(:params) { { test: 1 } }
    let(:parsed_query) { Rack::Utils.parse_nested_query(subject) }

    before { Timecop.freeze }

    it 'appends default params' do
      expect(parsed_query).to include(
        'vn' => '3',
        't' => Time.now.to_i.to_s,
        'f' => 'json',
        'u' => default_credentials[:username],
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

    context 'when custom credentials given' do
      let(:credentials) { { username: username, secret: secret } }
      let(:username) { 'tom_brown' }
      let(:secret) { 'toms_little_secret' }

      it 'uses default credentials' do
        expect(parsed_query).to include('u' => username)
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
