SELECT * FROM Movie;
SELECT * FROM CastMember;
SELECT * FROM MovieCastMemberJunction;

INSERT INTO Movie VALUES
	('Star Wars Episode IV', '1983'),
	('Star Wars Episode V', '1984'),
	('Star Wars Episode VI', '1985'),
	('John Wick', '2014');

INSERT INTO CastMember VALUES
	('Harrison Ford'),
	('Keanu Reeves');

INSERT INTO MovieCastMemberJunction VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 2);