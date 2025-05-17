# Chill JWT

A Rails API application demonstrating JWT (JSON Web Token) authentication.

## System Requirements

* Ruby 3.2.8
* PostgreSQL 14+
* Rails 8.0

## Setup

1. Clone the repository:
```bash
git clone https://github.com/your-username/chill_jwt.git
cd chill_jwt
```

2. Install dependencies:
```bash
bundle install
```

3. Database setup:
```bash
cp .env.example .env  # Copy and configure your environment variables
rails db:create db:migrate
```

## Environment Variables

Create a `.env` file with:
```
DB_HOST=localhost
DB_PASSWORD=your_password
```

## Running Tests

```bash
bundle exec rspec
```

## API Endpoints

### Authentication

- POST `/v1/sessions`
  - Authenticates user and returns JWT token
  - Parameters: `email`, `password`
  - Returns: `{ token: "jwt_token_here" }`

### Protected Routes

All other routes require authentication using the JWT token in the Authorization header:
```
Authorization: Bearer your_jwt_token_here
```

## Implementation Details

- Uses `has_secure_password` for password encryption
- JWT tokens expire after 24 hours
- Built with Rails API mode
- PostgreSQL database