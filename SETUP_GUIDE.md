# Web Auction - Setup Guide

Complete guide to set up the Web Auction platform on your local machine.

## Prerequisites

- **Node.js** v18.x or higher
- **npm** v9.x or higher
- **Supabase CLI** (for local development)
- **Git** (for version control)

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/khuongduy354/web-auction.git
cd web-auction
```

### 2. Backend Setup

#### 2.1 Install Dependencies
```bash
cd backend
npm install
```

#### 2.2 Configure Environment Variables
```bash
cp .env.example .env
```

Edit `.env` with your configuration:
```env
PORT=3001
NODE_ENV=development

# Supabase Configuration (from step 3)
SUPABASE_URL=http://localhost:54321
SUPABASE_ANON_KEY=your_anon_key_here
SUPABASE_SERVICE_KEY=your_service_key_here

# JWT Configuration
JWT_SECRET=your_random_secret_here_min_32_chars
JWT_EXPIRES_IN=7d

# Email Configuration (Gmail example)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your_email@gmail.com
SMTP_PASSWORD=your_app_password_here
EMAIL_FROM=noreply@webauction.com

# Frontend URL
FRONTEND_URL=http://localhost:3000

# Auto-extend Configuration
AUTO_EXTEND_ENABLED=true
AUTO_EXTEND_THRESHOLD_MINUTES=5
AUTO_EXTEND_DURATION_MINUTES=10
```

**Note:** For Gmail SMTP, you need to:
1. Enable 2-factor authentication on your Google account
2. Generate an "App Password" from your Google account settings
3. Use the app password in the `SMTP_PASSWORD` field

### 3. Database Setup (Supabase Local)

#### 3.1 Install Supabase CLI
```bash
npm install -g supabase
```

#### 3.2 Start Supabase
```bash
cd ..  # Go back to project root
supabase start
```

This will start local Supabase services. Make note of the output:
```
API URL: http://localhost:54321
Anon key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Service Role key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
Database URL: postgresql://postgres:postgres@localhost:54322/postgres
```

#### 3.3 Run Database Migrations

Option A - Using Supabase CLI:
```bash
supabase db reset
```

Option B - Manual execution:
```bash
# Using psql
psql -h localhost -p 54322 -U postgres -d postgres -f supabase/schemas/001_initial_schema.sql
psql -h localhost -p 54322 -U postgres -d postgres -f supabase/schemas/002_seed_data.sql
```

#### 3.4 Update Backend .env
Update the backend `.env` file with the Supabase credentials from step 3.2:
```env
SUPABASE_URL=http://localhost:54321
SUPABASE_ANON_KEY=<anon_key_from_step_3.2>
SUPABASE_SERVICE_KEY=<service_role_key_from_step_3.2>
```

### 4. Frontend Setup

#### 4.1 Install Dependencies
```bash
cd frontend
npm install
```

#### 4.2 Configure Environment Variables
```bash
cp .env.example .env
```

Edit `.env`:
```env
REACT_APP_API_URL=http://localhost:3001/api
REACT_APP_SUPABASE_URL=http://localhost:54321
REACT_APP_SUPABASE_ANON_KEY=<anon_key_from_step_3.2>
```

### 5. Running the Application

#### 5.1 Start Backend Server
```bash
cd backend
npm run dev
```
Backend will run on: http://localhost:3001

#### 5.2 Start Frontend Development Server
Open a new terminal:
```bash
cd frontend
npm start
```
Frontend will run on: http://localhost:3000

### 6. Verify Setup

1. Open http://localhost:3000 in your browser
2. You should see the Web Auction homepage
3. Try accessing the API health check: http://localhost:3001/health

### 7. Test Accounts

The seed data includes the following test accounts (password for all: `Password123!`):

**Admin:**
- Email: admin@webauction.com
- Role: admin

**Sellers:**
- seller1@example.com
- seller2@example.com
- seller3@example.com

**Bidders:**
- bidder1@example.com
- bidder2@example.com
- bidder3@example.com
- bidder4@example.com
- bidder5@example.com

## Development Workflow

### Running Tests
```bash
# Backend tests
cd backend
npm test

# Frontend tests
cd frontend
npm test
```

### Building for Production

#### Backend
```bash
cd backend
npm start
```

#### Frontend
```bash
cd frontend
npm run build
```
The build output will be in the `frontend/build/` directory.

### Database Management

#### View Database
Access Supabase Studio at: http://localhost:54323

#### Reset Database
```bash
supabase db reset
```

#### Stop Supabase
```bash
supabase stop
```

## Troubleshooting

### Port Already in Use
If you get "port already in use" errors:

For backend (port 3001):
```bash
lsof -ti:3001 | xargs kill -9
```

For frontend (port 3000):
```bash
lsof -ti:3000 | xargs kill -9
```

### Supabase Connection Issues
1. Ensure Supabase is running: `supabase status`
2. Check the connection URL in `.env` files
3. Try restarting Supabase: `supabase stop && supabase start`

### Database Migration Issues
If migrations fail:
1. Stop Supabase: `supabase stop`
2. Remove Supabase volumes: `supabase stop --no-backup`
3. Start fresh: `supabase start`
4. Run migrations again

### Email Not Working
For development, you can use a test email service like:
- [Mailtrap](https://mailtrap.io/) - Email testing service
- [Ethereal Email](https://ethereal.email/) - Fake SMTP service

Update the SMTP settings in `.env` accordingly.

## Project Structure

```
web-auction/
├── backend/              # Express.js API server
│   ├── src/
│   │   ├── config/       # Configuration files
│   │   ├── controllers/  # Request handlers
│   │   ├── middleware/   # Custom middleware
│   │   ├── routes/       # API routes
│   │   ├── utils/        # Utility functions
│   │   └── index.js      # Entry point
│   ├── .env              # Environment variables
│   └── package.json
│
├── frontend/             # React.js application
│   ├── public/           # Static files
│   ├── src/
│   │   ├── components/   # Reusable components
│   │   ├── pages/        # Page components
│   │   ├── services/     # API services
│   │   ├── context/      # React context
│   │   ├── utils/        # Utility functions
│   │   ├── App.js        # Main app component
│   │   └── index.js      # Entry point
│   ├── .env              # Environment variables
│   └── package.json
│
├── supabase/             # Database schemas
│   ├── schemas/
│   │   ├── 001_initial_schema.sql
│   │   └── 002_seed_data.sql
│   ├── schema.dbml       # DBML schema definition
│   └── README.md
│
├── devlog/               # Development documentation
│   ├── requiremnt.md     # Requirements (Vietnamese)
│   └── plan/
│       └── initial_setup.md
│
├── .gitignore
├── README.md
├── SETUP_GUIDE.md
└── API_DOCUMENTATION.md
```

## Next Steps

After setup, you can:
1. Review the requirements in `devlog/requiremnt.md`
2. Check the API documentation in `API_DOCUMENTATION.md`
3. Explore the database schema in `supabase/schema.dbml`
4. Start implementing features!

## Additional Resources

- [Express.js Documentation](https://expressjs.com/)
- [React Documentation](https://react.dev/)
- [Supabase Documentation](https://supabase.com/docs)
- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)

## Support

If you encounter any issues during setup, please:
1. Check the troubleshooting section above
2. Review the logs for error messages
3. Open an issue on GitHub with details about the problem
