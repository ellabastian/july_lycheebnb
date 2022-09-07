TRUNCATE TABLE users, spaces, requests RESTART IDENTITY;

INSERT INTO users (name, email, password) VALUES
('test1', 'test1@email.com', 'password111'),
('test2', 'test2@email.com', 'password222'),
('test3', 'test3@email.com', 'password333');

INSERT INTO spaces (name, description, price_per_night, available_from, available_to, requested, confirmed, user_id) VALUES
('first', 'Amazing space', 20, '2022-09-05', '2022-09-10', false, false, 1),
('second', 'Wonderful space', 40, '2022-09-12', '2022-09-15', false, false, 2),
('third', 'Relaxing space', 20, '2022-09-17', '2022-09-25', false, false ,3);

INSERT INTO requests (requested_by_name, space_name, date_requested, user_id) VALUES
('test1', 'second', '2022-09-13', 1),
('test3', 'second', '2022-09-12', 3);