-- Produk DQLab Mart
-- Mengacu pada table ms_produk, tampilkan daftar produk yang memiliki harga antara 50.000 and 150.000.
-- Nama kolom yang harus ditampilkan: no_urut, kode_produk, nama_produk, dan harga.
-- Semua table di atas sudah tersedia, Anda tinggal menulis query Anda dalam Code Editor.

select
	no_urut,
	kode_produk,
	nama_produk,
	harga
FROM ms_produk
WHERE harga<150000 AND harga > 50000;


-- Thumb drive di DQLab Mart
-- Tampilkan semua produk yang mengandung kata Flashdisk.
-- Nama kolom yang harus ditampilkan: no_urut, kode_produk, nama_produk, dan harga.
-- Semua table di atas sudah tersedia, Anda tinggal menulis query Anda dalam Code Editor.

SELECT 
	no_urut,
	kode_produk,
	nama_produk,
	harga
FROM ms_produk
WHERE nama_produk LIKE 'Flashdisk%';

-- Pelanggan Bergelar
-- Tampilkan hanya nama-nama pelanggan yang hanya memiliki gelar-gelar berikut: S.H, Ir. dan Drs.
-- Nama kolom yang harus ditampilkan: no_urut, kode_pelanggan, nama_pelanggan, dan alamat.
-- Semua table di atas sudah tersedia, Anda tinggal menulis query Anda dalam Code Editor.

SELECT 
 	no_urut,
 	kode_pelanggan,
 	nama_pelanggan,
	alamat
	FROM ms_pelanggan
WHERE nama_pelanggan LIKE '%S.H%' OR nama_pelanggan LIKE '%Ir.%' OR nama_pelanggan LIKE '%Drs.%';

-- Mengurutkan Nama Pelanggan
-- Tampilkan nama-nama pelanggan dan urutkan hasilnya berdasarkan kolom nama_pelanggan dari yang terkecil ke yang terbesar (A ke Z).
-- Nama kolom yang harus ditampilkan: nama_pelanggan.
-- Semua table di atas sudah tersedia, Anda tinggal menulis query Anda dalam Code Editor.

SELECT 
	nama_pelanggan
FROM ms_pelanggan
order BY nama_pelanggan

-- Mengurutkan Nama Pelanggan Tanpa Gelar
-- Tampilkan nama-nama pelanggan dan urutkan hasilnya berdasarkan kolom nama_pelanggan dari yang terkecil ke yang terbesar (A ke Z), namun gelar tidak boleh menjadi bagian dari urutan. Contoh: Ir. Agus Nugraha harus berada di atas Heidi Goh.
-- Nama kolom yang harus ditampilkan: nama_pelanggan.
-- Semua table di atas sudah tersedia, Anda tinggal menulis query Anda dalam Code Editor.

SELECT
	nama_pelanggan 
FROM ms_pelanggan 
order by replace (nama_pelanggan,'Ir. ','')
 
-- Nama Pelanggan yang Paling Panjang
-- Tampilkan nama pelanggan yang memiliki nama paling panjang. Jika ada lebih dari 1 orang yang memiliki panjang nama yang sama, tampilkan semuanya.
-- Nama kolom yang harus ditampilkan: nama_pelanggan.
-- Semua table di atas sudah tersedia, Anda tinggal menulis query Anda dalam Code Editor.

SELECT 
   	nama_pelanggan
FROM ms_pelanggan
WHERE LENGTH(nama_pelanggan) IN (SELECT MAX(LENGTH(nama_pelanggan)) FROM ms_pelanggan);
 
-- Nama Pelanggan yang Paling Panjang dengan Gelar
-- Tampilkan nama orang yang memiliki nama paling panjang (pada row atas), dan nama orang paling pendek (pada row setelahnya). Gelar menjadi bagian dari nama. Jika ada lebih dari satu nama yang paling panjang atau paling pendek, harus ditampilkan semuanya.
-- Nama kolom yang harus ditampilkan: nama_pelanggan.
-- Semua table di atas sudah tersedia, Anda tinggal menulis query Anda dalam Code Editor.

SELECT 
	nama_pelanggan
FROM ms_pelanggan
WHERE LENGTH(nama_pelanggan) IN (select MAX(LENGTH(nama_pelanggan))FROM ms_pelanggan)
or LENGTH(nama_pelanggan) IN (SELECT MIN(LENGTH(nama_pelanggan))FROM ms_pelanggan)
ORDER BY LENGTH(nama_pelanggan) DESC;

-- Kuantitas Produk yang Banyak Terjual
-- Tampilkan produk yang paling banyak terjual dari segi kuantitas. Jika ada lebih dari 1 produk dengan nilai yang sama, tampilkan semua produk tersebut.
-- Nama kolom yang harus ditampilkan: kode_produk, nama_produk,total_qty.
-- Semua table di atas sudah tersedia, Anda tinggal menulis query Anda dalam Code Editor.

SELECT
	tr_penjualan_detail.kode_produk,
	ms_produk.nama_produk,
	sum(qty) total_qty
from tr_penjualan_detail
inner join ms_produk using(kode_produk)
group by kode_produk, nama_produk
order by total_qty DESC
LIMIT 2;

-- Pelanggan Paling Tinggi Nilai Belanjanya
-- Siapa saja pelanggan yang paling banyak menghabiskan uangnya untuk belanja? Jika ada lebih dari 1 pelanggan dengan nilai yang sama, tampilkan semua pelanggan tersebut.
-- Nama kolom yang harus ditampilkan: kode_pelanggan, nama_pelanggan, total_harga.
-- Semua table di atas sudah tersedia, Anda tinggal menulis query Anda dalam Code Editor.

SELECT
	tr_penjualan.kode_pelanggan,
	ms_pelanggan.nama_pelanggan,
	sum(tr_penjualan_detail.qty*tr_penjualan_detail.harga_satuan) total_harga
from tr_penjualan_detail
inner join tr_penjualan using(kode_transaksi)
inner join ms_pelanggan using(kode_pelanggan)
group by kode_pelanggan,nama_pelanggan
order by total_harga DESC
limit 1

-- Pelanggan yang Belum Pernah Berbelanja
-- Tampilkan daftar pelanggan yang belum pernah melakukan transaksi.
-- Nama kolom yang harus ditampilkan: kode_pelanggan, nama_pelanggan, alamat.
-- Semua table di atas sudah tersedia, Anda tinggal menulis query Anda dalam Code Editor.

SELECT
	ms_pelanggan.kode_pelanggan,
	ms_pelanggan.nama_pelanggan,
	ms_pelanggan.alamat
from ms_pelanggan
where kode_pelanggan NOT IN (SELECT kode_pelanggan from tr_penjualan)
group by kode_pelanggan,nama_pelanggan, alamat

-- Transaksi Belanja dengan Daftar Belanja lebih dari 1
-- Tampilkan transaksi-transaksi yang memiliki jumlah item produk lebih dari 1 jenis produk. Dengan lain kalimat, tampilkan transaksi-transaksi yang memiliki jumlah baris data pada table tr_penjualan_detail lebih dari satu.
-- Nama kolom yang harus ditampilkan:  kode_transaksi, kode_pelanggan, nama_pelanggan, tanggal_transaksi, jumlah_detail
-- Semua table di atas sudah tersedia, Anda tinggal menulis query Anda dalam Code Editor.

SELECT
  a.kode_transaksi,
  a.kode_pelanggan,
  b.nama_pelanggan,
  a.tanggal_transaksi,
  count(c.kode_produk) as jumlah_detail
FROM
 	tr_penjualan a
JOIN ms_pelanggan b ON a.kode_pelanggan=b.kode_pelanggan 
JOIN tr_penjualan_detail c ON a.kode_transaksi=c.kode_transaksi
GROUP BY 
 	a.kode_transaksi,
 	a.kode_pelanggan,
 	b.nama_pelanggan,
 	a.tanggal_transaksi
HAVING count(c.kode_produk)>1