# Web Auction - Online Auction Platform

A full-stack online auction platform built with React.js, Express.js, and Supabase.

## Tech Stack

- **Frontend**: React.js
- **Backend**: Express.js
- **Database**: Supabase (PostgreSQL)

## Project Structure

```
web-auction/
├── frontend/          # React.js application
├── backend/           # Express.js API server
├── supabase/          # Database schemas and migrations
├── devlog/            # Development logs and requirements
└── README.md
```

## Getting Started

### Prerequisites

- Node.js (v18 or higher)
- npm or yarn
- Supabase CLI

### Installation

1. Clone the repository:
```bash
git clone https://github.com/khuongduy354/web-auction.git
cd web-auction
```

2. Install backend dependencies:
```bash
cd backend
npm install
```

3. Install frontend dependencies:
```bash
cd ../frontend
npm install
```

4. Set up Supabase:
```bash
cd ..
supabase init
supabase start
```

5. Configure environment variables:
- Copy `.env.example` to `.env` in both frontend and backend directories
- Update the variables with your configuration

### Running the Application

1. Start the backend server:
```bash
cd backend
npm run dev
```

2. Start the frontend development server:
```bash
cd frontend
npm start
```

## Features

See [devlog/requiremnt.md](devlog/requiremnt.md) for detailed feature requirements.

## License

MIT
