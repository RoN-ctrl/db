DROP TABLE IF EXISTS public.student_address;
DROP TRIGGER IF EXISTS trigger_immutable_address ON public.student_address;
DROP FUNCTION IF EXISTS public.function_immutable_address();

CREATE TABLE public.student_address
(
    student_id int NOT null REFERENCES public.students (student_id),
    address varchar(255) NOT null
);

CREATE FUNCTION public.function_immutable_address()
    RETURNS TRIGGER AS $trigger_immutable_address$

BEGIN
	IF
	NEW.student_id IS DISTINCT FROM OLD.student_id
	THEN NEW.student_id = OLD.student_id;
	END IF;

	IF
	NEW.address IS DISTINCT FROM OLD.address
	THEN NEW.address = OLD.address;
	END IF;

	RETURN NEW;
END;
$trigger_immutable_address$
language 'plpgsql';

CREATE TRIGGER trigger_immutable_address
    BEFORE UPDATE 
	ON student_address 
	FOR EACH ROW 
	EXECUTE FUNCTION function_immutable_address();

INSERT INTO student_address(student_id, address) VALUES ('1', 'address1');
INSERT INTO student_address(student_id, address) VALUES ('2', 'address2');

UPDATE student_address SET address = 'updated_address' WHERE student_id = 1;

SELECT * FROM public.student_address;