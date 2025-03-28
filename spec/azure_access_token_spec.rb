# frozen_string_literal: true

require 'webmock/rspec'
require_relative '../azure_access_token'

RSpec.describe 'Azure Access Token API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before do
    # Set environment variables for testing
    ENV['AZURE_CLIENT_ID'] = 'test-client-id'
    ENV['AZURE_TENANT_ID'] = 'test-tenant-id'
    ENV['AZURE_FEDERATED_TOKEN_FILE'] = 'spec/test_assertion.txt'

    # Stub the file read for client assertion
    allow(File).to receive(:read).with('spec/test_assertion.txt').and_return('mocked-assertion')
  end

  context 'when Azure returns success' do
    before do
      stub_request(:get, "https://login.microsoftonline.com/test-tenant-id/oauth2/v2.0/token")
        .with(body: hash_including(
          'grant_type' => 'client_credentials',
          'client_id' => 'test-client-id',
          'scope' => 'api://AzureADTokenExchange/.default',
          'client_assertion_type' => 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer',
          'client_assertion' => 'mocked-assertion'
        ))
        .to_return(
          status: 200,
          body: { "access_token" => "mocked-token" }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'returns an access token on success' do
      get '/azure_access_token'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('mocked-token')
      expect(last_response.headers['Content-Type']).to include('text/plain')
    end
  end

  context 'when Azure returns failure' do
    before do
      stub_request(:get, "https://login.microsoftonline.com/test-tenant-id/oauth2/v2.0/token")
        .to_return(status: 500, body: 'Internal Server Error')
    end

    it 'returns 500 if the Azure request fails' do
      get '/azure_access_token'
      expect(last_response.status).to eq(500)
      expect(last_response.body).to eq('Failed to get token')
    end
  end
end
