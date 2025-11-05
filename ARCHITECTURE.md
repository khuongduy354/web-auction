# Web Auction - System Architecture

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         Frontend                             │
│                      (React.js SPA)                          │
│  ┌─────────────┬──────────────┬────────────┬──────────────┐ │
│  │   Pages     │  Components  │  Services  │   Context    │ │
│  │  (Routes)   │  (Reusable)  │ (API Calls)│   (State)    │ │
│  └─────────────┴──────────────┴────────────┴──────────────┘ │
└────────────────────────┬────────────────────────────────────┘
                         │ HTTP/HTTPS (REST API)
                         │
┌────────────────────────▼────────────────────────────────────┐
│                      Backend API                             │
│                     (Express.js)                             │
│  ┌─────────────┬──────────────┬────────────┬──────────────┐ │
│  │   Routes    │ Controllers  │ Middleware │   Services   │ │
│  │ (Endpoints) │  (Business)  │  (Auth)    │   (Utils)    │ │
│  └─────────────┴──────────────┴────────────┴──────────────┘ │
└────────────────────────┬────────────────────────────────────┘
                         │ Supabase Client
                         │
┌────────────────────────▼────────────────────────────────────┐
│                      Database                                │
│                   (Supabase/PostgreSQL)                      │
│  ┌──────────┬──────────┬───────────┬──────────┬──────────┐  │
│  │  Users   │ Products │   Bids    │ Orders   │ Ratings  │  │
│  │Categories│  Images  │ Watchlist │Questions │   ...    │  │
│  └──────────┴──────────┴───────────┴──────────┴──────────┘  │
└──────────────────────────────────────────────────────────────┘
```

## Technology Stack

### Frontend Layer
- **Framework**: React.js v18
- **Routing**: React Router v6
- **HTTP Client**: Axios
- **State Management**: React Context API (+ possible Redux later)
- **UI Components**: Custom components (+ possible Material-UI/Ant Design)
- **Build Tool**: Create React App (Webpack)

### Backend Layer
- **Framework**: Express.js v5
- **Language**: JavaScript (ES Modules)
- **Authentication**: JWT + bcrypt
- **Validation**: express-validator
- **Email**: Nodemailer
- **CORS**: cors middleware
- **Environment**: dotenv

### Database Layer
- **Database**: PostgreSQL (via Supabase)
- **ORM/Client**: Supabase JavaScript Client
- **Migrations**: SQL scripts
- **Schema Design**: DBML + SQL

### External Services
- **Email Service**: SMTP (Gmail/SendGrid/etc.)
- **File Storage**: To be determined (Supabase Storage/Cloudinary/S3)
- **Image Processing**: To be determined

## Data Flow

### User Authentication Flow
```
1. User submits credentials
   Frontend → POST /api/auth/login → Backend
   
2. Backend validates credentials
   Backend → Check password hash → Database
   
3. Generate JWT token
   Backend → Create token → Return to Frontend
   
4. Store token
   Frontend → Save in localStorage/sessionStorage
   
5. Subsequent requests
   Frontend → Send token in Authorization header → Backend
   Backend → Verify token → Process request
```

### Bidding Flow
```
1. User places bid
   Frontend → POST /api/bids → Backend
   
2. Backend validates
   - User authentication (JWT)
   - User rating check (80%+)
   - Bid amount validation
   - Product still active
   - User not blocked
   
3. Process bid
   Backend → Insert bid → Database
   Backend → Update product current price → Database
   
4. Automatic bidding logic (if enabled)
   Backend → Check other max bids
   Backend → Calculate new current price
   Backend → Update product
   
5. Send notifications
   Backend → Email to seller
   Backend → Email to previous high bidder
   Backend → Email to new bidder
   
6. Return success
   Backend → Response → Frontend
   Frontend → Update UI
```

### Product Listing Flow
```
1. User browses/searches
   Frontend → GET /api/products?filters → Backend
   
2. Backend queries database
   Backend → Execute query with filters → Database
   Database → Return paginated results → Backend
   
3. Backend enriches data
   - Calculate time remaining
   - Format prices
   - Include bidder counts
   
4. Return to frontend
   Backend → JSON response → Frontend
   Frontend → Render product cards
```

## Security Architecture

### Authentication & Authorization
```
┌─────────────────────────────────────────────────────────────┐
│  Request Flow with Security Layers                          │
└─────────────────────────────────────────────────────────────┘

Client Request
    │
    ├─► 1. CORS Middleware (verify origin)
    │
    ├─► 2. Body Parser (parse JSON)
    │
    ├─► 3. Auth Middleware (verify JWT)
    │       │
    │       ├─► Extract token from header
    │       ├─► Verify token signature
    │       ├─► Check expiration
    │       └─► Attach user to request
    │
    ├─► 4. Role Middleware (check permissions)
    │       │
    │       └─► Verify user role for endpoint
    │
    ├─► 5. Input Validation (express-validator)
    │       │
    │       ├─► Validate request params
    │       ├─► Sanitize inputs
    │       └─► Check business rules
    │
    └─► 6. Controller (business logic)
            │
            └─► Database query with parameterized inputs
```

### Data Security
- **Passwords**: Hashed with bcrypt (10+ rounds)
- **JWT Tokens**: Signed with secret, 7-day expiration
- **Database**: Row-Level Security (RLS) in Supabase
- **Input Sanitization**: All user inputs validated
- **SQL Injection**: Prevented by parameterized queries
- **XSS**: To be implemented with content sanitization
- **CSRF**: To be implemented with tokens

## Database Schema Overview

### Core Entities

```
┌──────────┐        ┌──────────┐        ┌──────────┐
│  Users   │───────▶│ Products │◀───────│Categories│
└──────────┘   1:N  └──────────┘   N:1  └──────────┘
     │                    │                    │
     │ 1:N                │ 1:N                │ 1:N (parent)
     ▼                    ▼                    ▼
┌──────────┐        ┌──────────┐        ┌──────────┐
│   Bids   │        │  Images  │        │Categories│
└──────────┘        └──────────┘        │ (child)  │
                                        └──────────┘
```

### Relationships
- Users → Products (1:N) - Seller relationship
- Users → Bids (1:N) - Bidder relationship
- Users → Ratings (N:N) - Rating relationships
- Products → Bids (1:N) - Bid history
- Products → Images (1:N) - Product images
- Products → Orders (1:1) - Post-auction order
- Categories → Categories (1:N) - Parent-child hierarchy

## API Architecture

### RESTful Design Principles
- **Resource-based URLs**: `/api/products`, `/api/users`
- **HTTP Methods**: GET, POST, PUT, DELETE
- **Status Codes**: 200, 201, 400, 401, 403, 404, 500
- **JSON Format**: All responses in JSON
- **Pagination**: Query params `page` and `limit`
- **Filtering**: Query params for filters
- **Sorting**: Query param `sort`

### API Versioning
- Current: v1 (implicit)
- Future: `/api/v2/...` when breaking changes needed

### Error Handling
```json
{
  "error": "ErrorType",
  "message": "Human-readable error message",
  "code": "ERROR_CODE",
  "details": {}
}
```

## Deployment Architecture (Future)

```
┌─────────────────────────────────────────────────────────────┐
│                      Load Balancer                           │
│                      (nginx/CloudFlare)                      │
└──────────────────┬──────────────────────────────────────────┘
                   │
        ┌──────────┴──────────┐
        │                     │
┌───────▼────────┐   ┌────────▼───────┐
│  Frontend      │   │    Backend     │
│  (Static Site) │   │  (Node Server) │
│  Netlify/Vercel│   │  Heroku/Railway│
└────────────────┘   └────────┬───────┘
                              │
                     ┌────────▼───────┐
                     │   Database     │
                     │   (Supabase)   │
                     └────────────────┘
```

## Scalability Considerations

### Current Design (MVP)
- Single backend server
- Single database instance
- Synchronous processing

### Future Enhancements
1. **Caching Layer**
   - Redis for session storage
   - Cache frequently accessed products
   - Cache category tree

2. **Async Processing**
   - Queue system (Bull/RabbitMQ)
   - Background jobs for emails
   - Scheduled auction end processing

3. **Real-time Features**
   - WebSocket for live bidding
   - Socket.io for notifications
   - Server-Sent Events for updates

4. **Microservices**
   - Separate auth service
   - Separate notification service
   - Separate bid processing service

5. **Database Optimization**
   - Read replicas
   - Database sharding
   - Connection pooling

## Monitoring & Logging

### To Be Implemented
- **Application Logging**: Winston/Bunyan
- **Error Tracking**: Sentry
- **Performance Monitoring**: New Relic/DataDog
- **Uptime Monitoring**: Pingdom/UptimeRobot
- **Analytics**: Google Analytics

## Development Workflow

```
Developer
    │
    ├─► 1. Clone repo
    ├─► 2. Install dependencies (npm install)
    ├─► 3. Set up environment (.env files)
    ├─► 4. Start Supabase (supabase start)
    ├─► 5. Run migrations (supabase db reset)
    ├─► 6. Start backend (npm run dev)
    ├─► 7. Start frontend (npm start)
    │
    ├─► 8. Make changes
    ├─► 9. Test locally
    ├─► 10. Commit to git
    │
    └─► 11. Push to GitHub
            │
            ├─► CI/CD Pipeline (Future)
            │   ├─► Run tests
            │   ├─► Run linting
            │   ├─► Build
            │   └─► Deploy (if main branch)
            │
            └─► Pull Request Review
```

## File Organization

```
web-auction/
├── backend/
│   ├── src/
│   │   ├── config/        # Configuration (DB, email, etc.)
│   │   ├── controllers/   # Business logic
│   │   ├── middleware/    # Auth, validation, error handling
│   │   ├── routes/        # API route definitions
│   │   ├── utils/         # Helper functions
│   │   └── index.js       # App entry point
│   └── package.json
│
├── frontend/
│   ├── src/
│   │   ├── components/    # Reusable UI components
│   │   ├── pages/         # Page-level components
│   │   ├── services/      # API service functions
│   │   ├── context/       # React context providers
│   │   ├── utils/         # Helper functions
│   │   ├── App.js         # Root component
│   │   └── index.js       # Entry point
│   └── package.json
│
├── supabase/
│   ├── schemas/           # SQL migration files
│   └── schema.dbml        # DBML schema definition
│
└── docs/                  # Documentation
    ├── README.md
    ├── SETUP_GUIDE.md
    ├── API_DOCUMENTATION.md
    ├── ARCHITECTURE.md
    └── IMPLEMENTATION_STATUS.md
```

---

**Document Version**: 1.0  
**Last Updated**: 2025-11-05  
**Author**: Development Team
