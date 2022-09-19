
delete from dongcode where 삭제일자 is not null;

select distinct 시군구명 from dongcode 
	where 시도명='서울특별시' and 시군구명 is not null 
	order by 시군구명;
	
select 읍면동명 from dongcode 
	where 시군구명 = '서구' and 시도명 = '인천광역시' and 읍면동명 is not null 
	ORDER BY   읍면동명;
	
