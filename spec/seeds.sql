TRUNCATE TABLE users, spaces, requests RESTART IDENTITY;

INSERT INTO users (name, email, password) VALUES
('Jake', 'Jake@email.com', 'Password11'),
('David', 'David@email.com', 'Password11'),
('Mike', 'Mike@email.com', 'Password11'),
('Joe', 'Joe@email.com', 'Password11');

INSERT INTO spaces (name, description, price_per_night, available_from, available_to, requested, confirmed, user_id) VALUES
('White House', 'A small nest perched in the trees, out of sight at 4 meters from the ground.', 20, '2022-09-05', '2022-09-10', false, false, 1),
('Buckingham Palace', 'Discover the magical world of the Palace, unique in England.', 40, '2022-09-12', '2022-09-15', false, false, 2),
('Manhattan', 'Enjoy the lovely setting of this romantic spot in nature.', 20, '2022-09-17', '2022-09-25', false, false ,3),
('Montreal', 'A bridge house perched between a neighbourhood park and a bustling intersection.', 20, '2022-09-26', '2022-09-28', false, false ,4),
('Victoria', 'The luxurious spacious suite is furnished with a cozy seating area.', 20, '2022-10-05', '2022-10-10', false, false,1);

INSERT INTO requests (requested_by_name, space_name, date_requested, user_id) VALUES
('Jake', 'Buckingham Palace', '2022-09-09', 1),
('Mike', 'Buckingham Palace', '2022-09-12', 3),
('Joe', 'White House', '2022-09-26', 4),
('David', 'Victoria', '2022-10-06', 2);