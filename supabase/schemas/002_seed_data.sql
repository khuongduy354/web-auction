-- Seed data for Web Auction application
-- Password for all test users: Password123! (bcrypt hash)

-- Insert admin user
INSERT INTO users (email, password_hash, full_name, role, email_verified) VALUES
  ('admin@webauction.com', '$2b$10$rQZ8J9qZ4JGxZ8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8', 'Admin User', 'admin', true);

-- Insert seller users
INSERT INTO users (email, password_hash, full_name, address, role, email_verified) VALUES
  ('seller1@example.com', '$2b$10$rQZ8J9qZ4JGxZ8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8', 'John Seller', '123 Seller St, Ho Chi Minh City', 'seller', true),
  ('seller2@example.com', '$2b$10$rQZ8J9qZ4JGxZ8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8', 'Jane Merchant', '456 Commerce Ave, Hanoi', 'seller', true),
  ('seller3@example.com', '$2b$10$rQZ8J9qZ4JGxZ8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8', 'Mike Trader', '789 Trade Rd, Da Nang', 'seller', true);

-- Insert bidder users
INSERT INTO users (email, password_hash, full_name, address, role, email_verified) VALUES
  ('bidder1@example.com', '$2b$10$rQZ8J9qZ4JGxZ8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8', 'Alice Buyer', '321 Buyer Blvd, Ho Chi Minh City', 'bidder', true),
  ('bidder2@example.com', '$2b$10$rQZ8J9qZ4JGxZ8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8', 'Bob Customer', '654 Customer Ln, Hanoi', 'bidder', true),
  ('bidder3@example.com', '$2b$10$rQZ8J9qZ4JGxZ8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8', 'Carol Shopper', '987 Shopping Dr, Can Tho', 'bidder', true),
  ('bidder4@example.com', '$2b$10$rQZ8J9qZ4JGxZ8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8', 'David Purchaser', '147 Purchase Pkwy, Hue', 'bidder', true),
  ('bidder5@example.com', '$2b$10$rQZ8J9qZ4JGxZ8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8Z8', 'Eva Auction', '258 Auction Way, Nha Trang', 'bidder', true);

-- Insert parent categories
INSERT INTO categories (id, name, parent_id) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Điện tử', NULL),
  ('22222222-2222-2222-2222-222222222222', 'Thời trang', NULL),
  ('33333333-3333-3333-3333-333333333333', 'Đồ gia dụng', NULL),
  ('44444444-4444-4444-4444-444444444444', 'Thể thao', NULL);

-- Insert child categories
INSERT INTO categories (name, parent_id) VALUES
  -- Electronics
  ('Điện thoại di động', '11111111-1111-1111-1111-111111111111'),
  ('Máy tính xách tay', '11111111-1111-1111-1111-111111111111'),
  ('Máy tính bảng', '11111111-1111-1111-1111-111111111111'),
  ('Tai nghe', '11111111-1111-1111-1111-111111111111'),
  
  -- Fashion
  ('Giày', '22222222-2222-2222-2222-222222222222'),
  ('Đồng hồ', '22222222-2222-2222-2222-222222222222'),
  ('Túi xách', '22222222-2222-2222-2222-222222222222'),
  ('Quần áo', '22222222-2222-2222-2222-222222222222'),
  
  -- Home appliances
  ('Nồi cơm điện', '33333333-3333-3333-3333-333333333333'),
  ('Máy lọc không khí', '33333333-3333-3333-3333-333333333333'),
  ('Bàn ghế', '33333333-3333-3333-3333-333333333333'),
  
  -- Sports
  ('Giày thể thao', '44444444-4444-4444-4444-444444444444'),
  ('Dụng cụ tập gym', '44444444-4444-4444-4444-444444444444');

-- Note: Products, bids, and other transactional data should be added through the application
-- This seed file only contains the basic structure and user accounts for testing
