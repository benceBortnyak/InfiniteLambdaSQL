select ROUND(sum(age_group_income.average_income))
from (
    select
        avg(annual_income) over (partition by age)
            as average_income
    from mall_score
    where age between 25 and 30
) as age_group_income
