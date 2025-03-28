# Azure Access Token Sinatra Application

This Sinatra application provides an endpoint to retrieve an Azure access token using the client credentials flow. It utilizes the `HTTParty` gem to make HTTP requests to Azure's OAuth2 token endpoint.

## Requirements

- Ruby 3.0 or higher
- Sinatra
- Puma
- HTTParty

## Installation

1. **Clone the Repository:**

``` bash
git clone https://your-repository-url.git
cd your-repository-directory
```

2. **Install Dependencies:**

Ensure you have Bundler installed, then install the required gems:

``` bash
gem install bundler
bundle install
```

3. Set Environment Variables:

The application requires the following environment variables set in the shell session:

- AZURE_CLIENT_ID: Your Azure Client ID.
- AZURE_FEDERATED_TOKEN_FILE: Path to your federated token file.
- AZURE_TENANT_ID: Your Azure Tenant ID.

## Running the Application

Start the application using:

``` bash
bundle exec rackup -p 4567
```

Where 4567 is the port number. By default, the application will be accessible at http://localhost:4567

## Endpoint

GET /azure_access_token
Retrieves an Azure access token using the client credentials flow. The response is the access token in plain text if successful, or a 500 error if the token retrieval fails.

Response:

- Success (200 OK):
  Returns the Azure access token as plain text.

- Failure (500 Internal Server Error):
  Returns the message `Failed to get token` if the token retrieval fails.

## Testing

To run tests using RSpec:

1. Install Testing Dependencies:

```
bundle install --with test
```

2. Run Tests:

```
bundle exec rspec
```

## License

This project is licensed under the MIT License.
