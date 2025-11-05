# Web Auction Backend API

Express.js backend API server for the Web Auction platform.

## Project Structure

```
backend/
├── src/
│   ├── config/         # Configuration files (database, etc.)
│   ├── controllers/    # Request handlers
│   ├── middleware/     # Custom middleware
│   ├── routes/         # API routes
│   ├── utils/          # Utility functions
│   └── index.js        # Entry point
├── .env.example        # Environment variables template
└── package.json
```

## Setup

1. Install dependencies:
```bash
npm install
```

2. Configure environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

3. Start the development server:
```bash
npm run dev
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `POST /api/auth/verify-email` - Verify email with OTP
- `POST /api/auth/forgot-password` - Request password reset
- `POST /api/auth/reset-password` - Reset password with OTP

### Users
- `GET /api/users/profile` - Get user profile
- `PUT /api/users/profile` - Update user profile
- `PUT /api/users/password` - Change password
- `GET /api/users/:id/ratings` - Get user ratings

### Products
- `GET /api/products` - List products (with filters)
- `GET /api/products/:id` - Get product details
- `POST /api/products` - Create new product (seller only)
- `PUT /api/products/:id` - Update product (seller only)
- `GET /api/products/:id/bids` - Get product bid history

### Bids
- `POST /api/bids` - Place a bid
- `GET /api/bids/my-bids` - Get user's bids

### Categories
- `GET /api/categories` - List all categories
- `POST /api/categories` - Create category (admin only)

### Watchlist
- `GET /api/watchlist` - Get user's watchlist
- `POST /api/watchlist` - Add to watchlist
- `DELETE /api/watchlist/:id` - Remove from watchlist

### Admin
- `GET /api/admin/users` - List all users
- `GET /api/admin/upgrade-requests` - List upgrade requests
- `PUT /api/admin/upgrade-requests/:id` - Approve/reject upgrade

## Technologies

- **Express.js** - Web framework
- **Supabase** - Database (PostgreSQL)
- **bcrypt** - Password hashing
- **jsonwebtoken** - JWT authentication
- **nodemailer** - Email service
- **express-validator** - Input validation
