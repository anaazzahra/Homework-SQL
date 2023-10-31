use sqlhw1; #penamaan database dari saya

-- Jawaban No.1
select distinct(alamat) 
from 
	rakamin_customer_address;

-- Jawaban No.2
select * from rakamin_order
order by tanggal_pembelian desc
limit 10;

-- Jawaban No.3
select * from rakamin_customer rc 
where penipu = 1;

-- Jawaban No.4
select * from rakamin_order
where 
	metode_bayar = 'shopeepay'
order by kuantitas desc;

-- Jawaban No.5
create table if not exists 
	rakamin_customer_address_tangerang as(
		select*from rakamin_customer_address
		where kota = 'Tangerang'
	);

-- Jawaban No.6
update 
	rakamin_customer_address_tangerang
set 
	alamat = "Karawaci", provinsi = "Banten"
where 
	kota = "Tangerang";


-- Jawaban No.7
insert into 
	rakamin_customer_address_tangerang(id_alamat, id_pelanggan, alamat, kota, provinsi)
values
	(101, 70, "Ciledug", "Tangerang", "Banten");

-- Jawaban No.8
delete from 
	rakamin_customer_address_tangerang
where 
	id_alamat = 54;
#select * from rakamin_customer_address_tangerang;


#EXAM_SQL

-- NO.8
select 
	nama,
	umur
from 
	rakamin_customer
where umur > 20 and nama like 'f%';

-- no.9
select count(kota)
from rakamin_customer_address rca 
where kota in('Jakarta Selatan', 'Tangerang')
group by kota;

-- no.10
select * from rakamin_order;
select 
	id_pelanggan, 
	avg(harga)
from 
	rakamin_order
group by 1
order by 2 desc;

-- no.11
select * from rakamin_customer;
select count(telepon)
from 
	rakamin_customer rc
join 
	rakamin_customer_address rca on rca.id_pelanggan = rc.id_pelanggan
where 
	telepon like '62896%' and kota = 'Jakarta Selatan';

-- no.12
with
tmp as (
		select id_pelanggan,
		avg(harga) as avg_harga
		from
			rakamin_order as ro
		group by 1
)
select 
	avg_harga
from
	tmp
order by 1 asc;

-- no.15
select 
	case when tanggal_pembelian < '2018-01-01' and metode_bayar = 'ovo' then 1
		else 0
	end as flag_ovo_bef2018
from 
	rakamin_order as ro;
	
-- no.16
select max(harga) from rakamin_order;