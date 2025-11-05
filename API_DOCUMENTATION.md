# Web Auction API Documentation

## Base URL
```
Development: http://localhost:3001/api
```

## Authentication

Most endpoints require authentication using JWT tokens. Include the token in the Authorization header:
```
Authorization: Bearer <token>
```

## API Endpoints

### Authentication

#### Register User
```http
POST /api/auth/register
```
**Body:**
```json
{
  "email": "user@example.com",
  "password": "password123",
  "full_name": "John Doe",
  "address": "123 Street, City"
}
```

#### Login
```http
POST /api/auth/login
```
**Body:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```
**Response:**
```json
{
  "token": "jwt_token_here",
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "full_name": "John Doe",
    "role": "bidder"
  }
}
```

#### Verify Email
```http
POST /api/auth/verify-email
```
**Body:**
```json
{
  "user_id": "uuid",
  "code": "123456"
}
```

#### Forgot Password
```http
POST /api/auth/forgot-password
```
**Body:**
```json
{
  "email": "user@example.com"
}
```

#### Reset Password
```http
POST /api/auth/reset-password
```
**Body:**
```json
{
  "user_id": "uuid",
  "code": "123456",
  "new_password": "newpassword123"
}
```

### Users

#### Get Profile
```http
GET /api/users/profile
```
**Headers:** `Authorization: Bearer <token>`

#### Update Profile
```http
PUT /api/users/profile
```
**Headers:** `Authorization: Bearer <token>`
**Body:**
```json
{
  "full_name": "John Updated",
  "address": "New Address",
  "date_of_birth": "1990-01-01"
}
```

#### Change Password
```http
PUT /api/users/password
```
**Headers:** `Authorization: Bearer <token>`
**Body:**
```json
{
  "current_password": "oldpassword",
  "new_password": "newpassword"
}
```

#### Get User Ratings
```http
GET /api/users/:id/ratings
```

### Categories

#### List Categories
```http
GET /api/categories
```
**Query Parameters:**
- `parent_id` (optional) - Filter by parent category

#### Create Category (Admin Only)
```http
POST /api/categories
```
**Headers:** `Authorization: Bearer <token>`
**Body:**
```json
{
  "name": "Category Name",
  "parent_id": "uuid" // optional
}
```

### Products

#### List Products
```http
GET /api/products
```
**Query Parameters:**
- `category_id` - Filter by category
- `status` - Filter by status (active, ended, sold)
- `search` - Search by name/description
- `sort` - Sort by (price_asc, price_desc, ending_soon, most_bids)
- `page` - Page number (default: 1)
- `limit` - Items per page (default: 20)

#### Get Product Details
```http
GET /api/products/:id
```

#### Create Product (Seller Only)
```http
POST /api/products
```
**Headers:** `Authorization: Bearer <token>`
**Body:**
```json
{
  "name": "Product Name",
  "description": "Product description",
  "category_id": "uuid",
  "starting_price": 100.00,
  "price_step": 10.00,
  "buy_now_price": 500.00,
  "end_time": "2024-12-31T23:59:59Z",
  "auto_extend": true,
  "allow_unrated_bidders": true,
  "images": ["url1", "url2", "url3"]
}
```

#### Update Product (Seller Only)
```http
PUT /api/products/:id
```
**Headers:** `Authorization: Bearer <token>`

#### Get Product Bids
```http
GET /api/products/:id/bids
```

#### Get Product Questions
```http
GET /api/products/:id/questions
```

### Bids

#### Place Bid
```http
POST /api/bids
```
**Headers:** `Authorization: Bearer <token>`
**Body:**
```json
{
  "product_id": "uuid",
  "bid_amount": 150.00,
  "max_bid_amount": 200.00  // optional, for auto-bidding
}
```

#### Get My Bids
```http
GET /api/bids/my-bids
```
**Headers:** `Authorization: Bearer <token>`
**Query Parameters:**
- `status` - Filter by status (active, won, lost)

### Watchlist

#### Get Watchlist
```http
GET /api/watchlist
```
**Headers:** `Authorization: Bearer <token>`

#### Add to Watchlist
```http
POST /api/watchlist
```
**Headers:** `Authorization: Bearer <token>`
**Body:**
```json
{
  "product_id": "uuid"
}
```

#### Remove from Watchlist
```http
DELETE /api/watchlist/:id
```
**Headers:** `Authorization: Bearer <token>`

### Questions

#### Ask Question
```http
POST /api/questions
```
**Headers:** `Authorization: Bearer <token>`
**Body:**
```json
{
  "product_id": "uuid",
  "question": "What is the condition?"
}
```

#### Answer Question (Seller Only)
```http
PUT /api/questions/:id/answer
```
**Headers:** `Authorization: Bearer <token>`
**Body:**
```json
{
  "answer": "The product is in excellent condition"
}
```

### Ratings

#### Rate User
```http
POST /api/ratings
```
**Headers:** `Authorization: Bearer <token>`
**Body:**
```json
{
  "rated_user_id": "uuid",
  "product_id": "uuid",
  "rating": 1,  // +1 or -1
  "comment": "Great transaction!"
}
```

### Orders

#### Get Order Details
```http
GET /api/orders/:id
```
**Headers:** `Authorization: Bearer <token>`

#### Submit Payment
```http
PUT /api/orders/:id/payment
```
**Headers:** `Authorization: Bearer <token>`
**Body:**
```json
{
  "payment_proof_url": "url_to_proof",
  "shipping_address": "Full shipping address"
}
```

#### Confirm Shipment (Seller)
```http
PUT /api/orders/:id/ship
```
**Headers:** `Authorization: Bearer <token>`
**Body:**
```json
{
  "shipping_tracking_number": "TRACK123"
}
```

#### Confirm Receipt (Buyer)
```http
PUT /api/orders/:id/confirm
```
**Headers:** `Authorization: Bearer <token>`

#### Cancel Order
```http
PUT /api/orders/:id/cancel
```
**Headers:** `Authorization: Bearer <token>`

### Admin

#### List Users
```http
GET /api/admin/users
```
**Headers:** `Authorization: Bearer <token>` (Admin only)

#### List Upgrade Requests
```http
GET /api/admin/upgrade-requests
```
**Headers:** `Authorization: Bearer <token>` (Admin only)

#### Approve/Reject Upgrade Request
```http
PUT /api/admin/upgrade-requests/:id
```
**Headers:** `Authorization: Bearer <token>` (Admin only)
**Body:**
```json
{
  "status": "approved",  // or "rejected"
  "notes": "Reason for decision"
}
```

#### Remove Product
```http
DELETE /api/admin/products/:id
```
**Headers:** `Authorization: Bearer <token>` (Admin only)

## Error Responses

All errors follow this format:
```json
{
  "error": "Error type",
  "message": "Detailed error message"
}
```

Common HTTP status codes:
- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `500` - Internal Server Error
