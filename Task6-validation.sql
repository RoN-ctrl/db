ALTER TABLE students ADD CONSTRAINT name_check CHECK (name not similar to  '%(@|#|$)%');

INSERT INTO students (name, surname, date_of_birth, phone_number, primary_skill)
VALUES ('@name', '#surname', '2000-01-02', 1717711, 'skill')