CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  email text,
  password text
);

CREATE TABLE spaces (
  id SERIAL PRIMARY KEY,
  name text,
  description text,
  price_per_night int,
  available_from date,
  available_to date,
  requested boolean,
  confirmed boolean,
  user_id int,
  constraint fk_user foreign key(user_id) references users(id) on delete cascade
);


CREATE TABLE requests (
  id SERIAL PRIMARY KEY,
  requested_by_name text,
  space_name text,
  date_requested date,
  user_id int,
  constraint fk_user foreign key(user_id) references users(id) on delete cascade
);