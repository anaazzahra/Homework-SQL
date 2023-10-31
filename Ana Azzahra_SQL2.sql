#homework_2

use sqlhw1;

-- No.1
select 
	nama,
	email,
	bulan_lahir,
	tanggal_registrasi 
from 
	rakamin_customer
where 
	(email like '%@yahoo%' or email like '%@roketmail%')
	and 
		tanggal_registrasi between '1/1/2012' and '3/31/2012'
	and 
		bulan_lahir in('Januari', 'Februari', 'Maret')
order by 3 asc;

-- No.2
select 
	id_order,
	id_pelanggan,
	harga,
	(harga * PPN) + harga as harga_setelah_PPN,
	case when (harga * PPN) + harga <= 20000 then 'LOW'
		 when (harga * PPN) + harga > 20000  and (harga * PPN) + harga <= 50000 then 'MEDIUM'
		 else 'HIGH'
	end as spending_bucket
from
	rakamin_order
group by 1
order by 4 desc;

-- No.3
select 
	id_merchant,
	count(id_merchant) as jumlah_order_merchant,
	sum(harga) as total_pendapatan_sblm_PPN
from 
	rakamin_order
group by 1
order by 3 desc;

-- No.4
select distinct
	metode_bayar,
	count(metode_bayar) as frekuensi_penggunaan
from 
	rakamin_order
group by 1
having count(2) > 10
order by 2 desc;

-- No.5
select * from rakamin_customer_address;
select 
	kota,
	count(kota) as jumlah_pelanggan_kota
from 
	rakamin_customer_address
group by 1
order by 2 asc;
-- yang menggunakan subquery	
select 	
	min(jumlah_pelanggan_kota) as jumlah_terkecil,
	max(jumlah_pelanggan_kota) as jumlah_terbesar
from (
		select 
			kota,
			count(kota) as jumlah_pelanggan_kota
			from 
			rakamin_customer_address
			group by 1
) as jumlah_pelanggan;

-- menampilkan kota
-- 5.1
(select
	'populasi tertinggi' as kategori,
	kota,
	count(id_pelanggan) total
from 
	rakamin_customer_address
group by 1,2
order by 3 desc
limit 1)
union 
(select
	'populasi terendah' as kategori,
	kota,
	count(id_pelanggan) total
from 
	rakamin_customer_address
group by 1,2
order by 3 asc
limit 1);

-- No.6
select
	nama_merchant,
	metode_bayar,
	count(metode_bayar) as frekuensi_penggunaan
from
	rakamin_order ro 
left join rakamin_merchant rm on rm.id_merchant = ro.id_merchant 
group by 1, 2
order by 1 asc;

-- No.7
select * from rakamin_customer;
with jumlah_kuantitas as(
	select 
	id_pelanggan, 
	sum(kuantitas) as sum_qty
	from rakamin_order
	group by 1
	having sum(kuantitas) > 5
)
select 
	nama,
	email,
	sum_qty
from jumlah_kuantitas jk
left join rakamin_customer rc on rc.id_pelanggan = jk.id_pelanggan
order by 1 asc;


