require 'sinatra'
require 'puma'
require 'httpparty'

set :protection, except: :host

DEFAULT_AZURE_SCOPE = 'api://AzureADTokenExchange/.default'
NULL_FILE = '/dev/null'

set :server, :puma

def azure_access_token
  client_id = ENV.fetch('AZURE_CLIENT_ID', nil)
  client_assertion = File.read(ENV.fetch('AZURE_FEDERATED_TOKEN_FILE', NULL_FILE))
  tenant_id = ENV.fetch('AZURE_TENANT_ID', nil)
  azure_credentials_source = "https://login.microsoftonline.com/#{tenant_id}/oauth2/v2.0/token"

  aad_token_request_body = {
    grant_type: 'client_credentials',
    client_id: client_id,
    scope: DEFAULT_AZURE_SCOPE,
    client_assertion_type: 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer',
    client_assertion: client_assertion
  }

   HTTParty.get(azure_credentials_source, body: aad_token_request_body)
end

get '/azure_access_token' do
  azure_token_response = azure_access_token

  if azure_token_response.success?
    # Set response content type to plain text
    content_type 'text/plain'

    # Return only the token as plain text
    azure_token_response.parsed_response['access_token']
  else
    halt 500, "Failed to get token"
  end
end
