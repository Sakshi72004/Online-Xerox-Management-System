USE online_xerox_system;

-- Option 1: Create a default admin account.
-- Login with:
-- Email: admin@printease.com
-- Password: admin123
INSERT INTO users(full_name, email, phone, address, password, role)
SELECT 'PrintEase Admin', 'admin@printease.com', '9999999999', 'PrintEase Shop', 'admin123', 'ADMIN'
WHERE NOT EXISTS (
    SELECT 1 FROM users WHERE email = 'admin@printease.com'
);

-- Option 2: Promote your existing account to admin.
-- Change the email below to your registered email and run only this line if needed.
-- UPDATE users SET role = 'ADMIN' WHERE email = 'your-email@example.com';
