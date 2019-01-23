DROP TABLE IF EXISTS homes;

CREATE TABLE homes (
  id SERIAL4 PRIMARY KEY,
  value VARCHAR(225),
  no_of_bedrooms VARCHAR(225),
  status VARCHAR(225),
  build VARCHAR(225)
)
