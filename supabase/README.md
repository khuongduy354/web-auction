# Supabase Database Configuration

This directory contains database schemas and configuration for the Web Auction platform.

## Structure

```
supabase/
├── schemas/
│   ├── 001_initial_schema.sql    # Initial database schema
│   └── 002_seed_data.sql         # Seed data for testing
├── schema.dbml                    # Database schema in DBML format
└── README.md
```

## Database Schema Overview

### Core Tables

- **users** - User accounts (bidders, sellers, admins)
- **categories** - Product categories (2-level hierarchy)
- **products** - Auction products/items
- **product_images** - Product images
- **bids** - Bid history
- **ratings** - User ratings and reviews
- **orders** - Post-auction order completion

### Supporting Tables

- **otp_codes** - Email verification and password reset codes
- **upgrade_requests** - Bidder to seller upgrade requests
- **description_history** - Product description update history
- **blocked_bidders** - Sellers can block specific bidders
- **watchlist** - Products users are watching
- **product_questions** - Questions and answers about products
- **order_messages** - Chat messages for order completion
- **system_config** - System-wide configuration

## Setup with Supabase Local

1. Install Supabase CLI:
```bash
npm install -g supabase
```

2. Initialize Supabase:
```bash
supabase init
```

3. Start local Supabase:
```bash
supabase start
```

4. Run migrations:
```bash
supabase db reset
```

Or manually run the SQL files:
```bash
psql -h localhost -p 54322 -U postgres -d postgres -f supabase/schemas/001_initial_schema.sql
psql -h localhost -p 54322 -U postgres -d postgres -f supabase/schemas/002_seed_data.sql
```

## Database Connection

After starting Supabase locally, you'll get connection details:
- API URL: `http://localhost:54321`
- Anon Key: (displayed in console)
- Service Role Key: (displayed in console)
- Database URL: `postgresql://postgres:postgres@localhost:54322/postgres`

Update your `.env` files with these values.

## Key Features

### User Roles
- **bidder** - Can bid on products, ask questions, rate sellers
- **seller** - Can post products, manage listings, rate buyers
- **admin** - Full system access, user management

### Auction Features
- Two-level category hierarchy
- Product auto-extension when bids come in near end time
- Automatic bidding with max bid amount
- Seller can block specific bidders
- Question/Answer system
- Rating system (+1/-1) with comments
- Post-auction order completion workflow

### Security
- Row Level Security (RLS) policies should be configured
- Password hashing with bcrypt
- JWT token authentication
- Email verification with OTP

## Notes

- The schema supports both regular and automatic bidding
- Products can have optional "buy now" price
- Sellers can update product descriptions (history is tracked)
- System configuration is stored in database for flexibility
- All timestamps use PostgreSQL's timezone-aware timestamps
