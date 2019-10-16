create or replace function AVG_ANNUAL_INCOME_AGE(arg_age integer) returns integer as '
declare
	avg_income integer;
begin

	SELECT avg(annual_income) from bb1410.mall_score WHERE age=arg_age into avg_income;
	RETURN avg_income;
end;
' LANGUAGE plpgsql;


create or replace function AVG_ANNUAL_INCOME(start_age integer,end_age integer) returns integer as '
declare
    sum_income_year integer := 0;
    years integer;
    current_year_avg integer;
begin
	IF end_age <= start_age THEN
		RAISE EXCEPTION ''The second value must be greater then the first'';
	END IF;
	
	FOR a in start_age .. end_age LOOP
		SELECT AVG_ANNUAL_INCOME_AGE(a) into current_year_avg;
        sum_income_year = sum_income_year + current_year_avg;
    end loop;
    years = end_age - start_age;
    sum_income_year = sum_income_year / years;
    RETURN sum_income_year;
end;
' LANGUAGE plpgsql;


SELECT AVG_ANNUAL_INCOME(19,24)