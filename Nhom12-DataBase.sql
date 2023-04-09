
--tao user ph1
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER ph1 identified by 123;
grant CREATE session to ph1;
GRANT ALL PRIVILEGES TO ph1;
grant select any dictionary to ph1;
conn ph1/123;

--Tao bang:
WHENEVER SQLERROR CONTINUE NONE
DROP TABLE  HSBA_DV cascade constraints;
create table HSBA_DV
(
MA_DV                char(6),
NGAY_DV              date,
MA_NV                number(5),
MA_HSBA              number(9),
KETQUA               varchar2(50),
constraint PK_HSBA_DV primary key (MA_DV, NGAY_DV, MA_HSBA)  
);

WHENEVER SQLERROR CONTINUE NONE
DROP TABLE  HSBA cascade constraints;
create table HSBA
(
MA_HSBA              number(9),
MA_KHOA              char(6),
MA_BN                number(5),
MA_NV                number(5),
NGAY                 date,
CHUANDOAN            varchar2(50),
KETLUAN              varchar2(50) null,
MA_CSYT              char(10),
constraint PK_HSBA primary key (MA_HSBA)
);

WHENEVER SQLERROR CONTINUE NONE
DROP TABLE  BENHNHAN cascade constraints;
create table BENHNHAN
(
MA_BN                number(5),
MA_CSYT              number(5),
TEN_BN               varchar2(50),
CMND                 char(10),
NGAYSINH             date,
SONHA                char(20),
TENDUONG             varchar2(30),
QUANHUYEN            varchar2(30),
TINHTP               varchar2(30),
TIENSUBENH           varchar2(30),
TIENSUBENHGD         varchar2(30),
DIUNGTHUOC           varchar2(30),
constraint PK_BENHNHAN primary key (MA_BN)
);


WHENEVER SQLERROR CONTINUE NONE
DROP TABLE  CSYT_KHOA cascade constraints;
create table CSYT_KHOA
(
MA_KHOA              char(6),
MA_CSYT              number(5),
TEN_KHOA             varchar2(50),
SDT_KHOA             char(10),
constraint PK_CSYT_KHOA primary key (MA_KHOA)
);

WHENEVER SQLERROR CONTINUE NONE
DROP TABLE  CSYT cascade constraints;
create table CSYT
(
MA_CSYT              number(5),
TEN_CSYT             varchar2(30),
DC_CSYT              varchar2(100),
SDT_CSYT             char(10),
constraint PK_CSYT primary key (MA_CSYT)
);

WHENEVER SQLERROR CONTINUE NONE
DROP TABLE  NHANVIEN cascade constraints;
create table NHANVIEN
(
MA_NV                number(5),
MA_CSYT              number(5),
HOTEN                varchar2(50),
PHAI                 int null,
NGAYSINH             date,
CMND                 char(10),
QUEQUAN              varchar2(50),
SDT                  char(10),
VAITRO               varchar2(20),
CHUYENKHOA           varchar2(20) null,
constraint PK_NHANVIEN primary key (MA_NV)
);

WHENEVER SQLERROR CONTINUE NONE
DROP TABLE  DICHVU cascade constraints;
create table DICHVU
(
MA_DV               char(6),
TEN_DV              varchar2(30),
constraint PK_DICHVU primary key (MA_DV)
);

--FK:
alter table BENHNHAN
   add constraint FK_BENHNHAN_DANGKYKHA_CSYT foreign key (MA_CSYT)
      references CSYT (MA_CSYT) ON DELETE CASCADE ENABLE;

alter table CSYT_KHOA
   add constraint FK_CSYT_KHO_CSYT_KHOA_CSYT foreign key (MA_CSYT)
      references CSYT (MA_CSYT) ON DELETE CASCADE ENABLE;

alter table HSBA
   add constraint FK_HSBA_BENHNHAN_BENHNHAN foreign key (MA_BN)
      references BENHNHAN (MA_BN) ON DELETE CASCADE ENABLE;

alter table HSBA
   add constraint FK_HSBA_KHAMCHUAB_NHANVIEN foreign key (MA_NV)
      references NHANVIEN (MA_NV) ON DELETE CASCADE ENABLE;

alter table HSBA
   add constraint FK_HSBA_KHAMTAIKH_CSYT_KHO foreign key (MA_KHOA)
      references CSYT_KHOA (MA_KHOA) ON DELETE CASCADE ENABLE;

alter table HSBA_DV
   add constraint FK_HSBA_DV_SUDUNGDIC_HSBA foreign key (MA_HSBA)
      references HSBA (MA_HSBA) ON DELETE CASCADE ENABLE;
      
alter table HSBA_DV
   add constraint FK_HSBA_DV foreign key (MA_DV)
      references DICHVU (MA_DV) ON DELETE CASCADE ENABLE;      

alter table HSBA_DV
   add constraint FK_HSBA_DV_THUCHIEND_NHANVIEN foreign key (MA_NV)
      references NHANVIEN (MA_NV) ON DELETE CASCADE ENABLE;

alter table NHANVIEN
   add constraint FK_NHANVIEN_NHANVIENC_CSYT foreign key (MA_CSYT)
      references CSYT (MA_CSYT) ON DELETE CASCADE ENABLE;

--Viet script Nhap du lieu mau cho Luoc do csdl.
--CSYT:
insert into CSYT(MA_CSYT, TEN_CSYT, DC_CSYT, SDT_CSYT) values(00000,'Benh Vien Nhi Dong 1', '341 Su Van Hanh, Phuong 10, Quan 10, Thanh pho Ho Chi Minh', '0932737371');
insert into CSYT(MA_CSYT, TEN_CSYT, DC_CSYT, SDT_CSYT) values(00001,'Benh Vien Nhi Dong 2', '14 Ly Tu Trong, Ben Nghe, Quan 1, Thanh pho Ho Chi Minh', '0932767674');
insert into CSYT(MA_CSYT, TEN_CSYT, DC_CSYT, SDT_CSYT) values(00002,'Benh Vien Tai Mui Hong Sai Gon', '1-3 Trinh Van Can, Phuong Cau Ong Lanh, Quan 1, Thanh pho Ho Chi Minh', '0918919190');
insert into CSYT(MA_CSYT, TEN_CSYT, DC_CSYT, SDT_CSYT) values(00003,'Benh vien Le Van Thinh', '130 Duong Le Van Thinh, Phuong Binh Trung Tay, Thanh Pho Thu Duc, Thanh pho Ho Chi Minh', '0972777000');
insert into CSYT(MA_CSYT, TEN_CSYT, DC_CSYT, SDT_CSYT) values(00004,'Benh vien Nhan dan 115', '520 Nguyen Tri Phuong, Quan 10, Thanh pho Ho Chi Minh', '0915115000');

--CSYT_KHOA
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('TMH00', 00000, 'Khoa Tai Mui Hong', '0932737372');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('CT00', 00000, 'Khoa Chan Thuong Chinh Hinh', '0932737373');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('TMH01', 00001, 'Khoa Tai Mui Hong', '0932767675');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('CT01', 00001, 'Khoa Chan Thuong Chinh Hinh', '0932767676');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('CC01', 00001, 'Khoa Cap Cuu', '0932767677');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('CC02', 00002, 'Khoa Cap Cuu', '0918919191');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('PS02', 00002, 'Khoa Phu San', '0918919192');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('ND02', 00002, 'Khoa Nhi Dong', '0918919193');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('HS02', 00002, 'Khoa Hoi Suc Tich Cuc', '0918919194');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('NG03', 00003, 'Khoa Ngoai', '0972777555');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('NO03', 00003, 'Khoa Noi', '0972777666');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('TN03', 00003, 'Khoa Truyen Nhiem', '0972777777');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('NG04', 00004, 'Khoa Ngoai', '0915115001');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('NO04', 00004, 'Khoa Noi', '0915115002');
insert into CSYT_KHOA(MA_KHOA, MA_CSYT, TEN_KHOA, SDT_KHOA) values('CC04', 00004, 'Khoa Cap Cuu', '0915115003');

--BENHNHAN:
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00000, 00000, 'Dinh Thi Ngoc Hoa', '3170321022', to_date('21/02/2001', 'dd/mm/yyyy'), '35/2', 'Le Van Thinh', 'Quan 2', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Khang sinh Penicillin');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00001, 00000, 'Duong Thi Thanh Truc', '184434490', to_date('04/05/2003', 'dd/mm/yyyy'), '5/2', 'Nguyen Duy Trinh', 'Quan 2', 'Thanh pho Ho Chi Minh', 'Khong co', 'Benh Tim', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00002, 00001, 'Nguyen Thu Thuy', '201884647', to_date('24/05/2004', 'dd/mm/yyyy'), '3/2', 'Nguyen Duy Trinh', 'Quan 2', 'Thanh pho Ho Chi Minh', 'Khong co', 'Benh Tim', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00003, 00002, 'Nguyen Thanh Anh Khoa', '231342927', to_date('23/07/2000', 'dd/mm/yyyy'), '35/3/19', 'Le Van Thinh', 'Quan 2', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Khang sinh Streptomycin');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00004, 00003, 'Le Thi Hang', '184430016', to_date('16/06/1998', 'dd/mm/yyyy'), '435/2', 'An Duong Vuong', 'Quan 5', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00005, 00004, 'Vo Quang Thang', '206326933', to_date('07/03/1972', 'dd/mm/yyyy'), '232', 'Nguyen Van Cu', 'Quan 10', 'Thanh pho Ho Chi Minh', 'Benh Tim', 'Benh Tim', 'Khang sinh Streptomycin');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00006, 00004, 'Dang Cao Chi', '206477842', to_date('27/05/1988', 'dd/mm/yyyy'), '1234', 'Le Lai', 'Quan 1', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00007, 00003, 'Le Huu Hung', '206322084', to_date('16/09/1978', 'dd/mm/yyyy'), '989', '3/2', 'Quan 10', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00008, 00002, 'Nguyen Cong Quyet', '201883108', to_date('16/07/1999', 'dd/mm/yyyy'), '2', 'Le Van Thinh', 'Quan 2', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00009, 00001, 'Pham Nguyen Nhu Quyen', '3230121036', to_date('04/07/1999', 'dd/mm/yyyy'), '22', 'Nguyen Thi Dinh', 'Quan 2', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Khang sinh Penicillin');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00010, 00001, 'Nguyen Thi Thuy Hien', '3170221040', to_date('02/09/1987', 'dd/mm/yyyy'), '19', 'An Duong Vuong', 'Quan 10', 'Thanh pho Ho Chi Minh', 'Hen suyen', 'Hen suyen', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00011, 00002, 'Nguyen Huu Hoang', '3190421057', to_date('02/09/1956', 'dd/mm/yyyy'), '989', 'Nguyen Van Cu', 'Quan 10', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00012, 00003, 'Do Nhat Tien', '3120221297', to_date('02/08/1998', 'dd/mm/yyyy'), '31/31', 'Nguyen Dinh Chieu', 'Quan 5', 'Thanh pho Ho Chi Minh', 'Khong co', 'Hen suyen', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00013, 00004, 'Tuong The Lieu', '3120221209', to_date('23/01/1997', 'dd/mm/yyyy'), '35/2/2/2', 'Nguyen Dinh Chieu', 'Quan 3', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Kháng sinh Amoxicillin');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00014, 00002, 'Le Thi Thu Thuong', '3170421024', to_date('22/06/1999', 'dd/mm/yyyy'), '35/2/12/2', 'Le Loi', 'Quan 1', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00015, 00001, 'Dinh Thi Mo', '3120221060', to_date('16/07/1994', 'dd/mm/yyyy'), '12/21', 'Nguyen Tuyen', 'Quan 2', 'Thanh pho Ho Chi Minh', 'Khong co', 'Hen suyen', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00016, 00001, 'Truong Cong Khoa', '3170321025', to_date('06/10/1997', 'dd/mm/yyyy'), '2', 'Nguyen Xi', 'Quan 9', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00017, 00002, 'Nguyen Thi Thu Thao', '3140321053', to_date('19/01/2003', 'dd/mm/yyyy'), '5', 'Vanh Dai', 'Quan 9', 'Thanh pho Ho Chi Minh', 'Benh Tim', 'Benh Tim', 'Khong co');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00018, 00004, 'Pham Xuan Binh', '3170321015', to_date('30/05/2002', 'dd/mm/yyyy'), '6', 'Nguyen Huu Canh', 'Quan 1', 'Thanh pho Ho Chi Minh', 'Khong co', 'Khong co', 'Kháng sinh amoxicillin');
insert into BENHNHAN(MA_BN, MA_CSYT, TEN_BN, CMND, NGAYSINH, SONHA, TENDUONG, QUANHUYEN, TINHTP, TIENSUBENH, TIENSUBENHGD, DIUNGTHUOC) values(00019, 00003, 'Le Thi Ly Na', '3170321029', to_date('16/02/2003', 'dd/mm/yyyy'), '3', 'Ho Hao Hon', 'Quan 1', 'Thanh pho Ho Chi Minh', 'Khong co', 'Hen suyen', 'Khong co');

--NHANVIEN:
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO) values(00000, 00000, 'Tran Thanh Luong', 1, to_date('23/01/1972', 'dd/mm/yyyy'), '3220121091', 'Kien Giang', '0913111222', 'Thanh Tra');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO) values(00001, 00000, 'Tran Quang Van', 1, to_date('12/04/1983', 'dd/mm/yyyy'), '3230121032', 'DakLak', '0913451222', 'Thanh Tra');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO) values(00002, 00001, 'Nguyen Thi Minh Trieu', 0, to_date('01/01/1973', 'dd/mm/yyyy'), '3120221014', 'Thanh pho Ho Chi Minh', '0914445222', 'Thanh Tra');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO) values(00003, 00003, 'Nguuyen Ni Kha', 1, to_date('17/05/1963', 'dd/mm/yyyy'), '3160621017', 'Can Tho', '0913114856', 'Thanh Tra');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO) values(00004, 00004, 'Huynh Bao Ngoc', 0, to_date('01/01/1993', 'dd/mm/yyyy'), '3160621020', 'Kien Giang', '0913234242', 'Co so y te');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO) values(00005, 00002, 'Pham Hoang Minh', 0, to_date('17/03/1984', 'dd/mm/yyyy'), '3160621019', 'Da Nang', '0913113456', 'Co so y te');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO) values(00006, 00000, 'Ngo Thi Lan', 0, to_date('12/01/1995', 'dd/mm/yyyy'), '3160421038', 'Ha Noi', '0913111222', 'Co so y te');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO, CHUYENKHOA) values(00007, 00000, 'Phan Thanh Thuy', 1, to_date('23/10/1983', 'dd/mm/yyyy'), '3230121033', 'Da Nang', '0913111222', 'Nghien cuu', 'Khoa Ngoai');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO, CHUYENKHOA) values(00008, 00004, 'Nguyen Thi Tu Trinh', 1, to_date('17/09/1978', 'dd/mm/yyyy'), '3230121034', 'Ben Tre', '0913101222', 'Y si/Bac si', 'Khoa Noi');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO, CHUYENKHOA) values(00009, 00000, 'Huynh Ha Ngoc Phuong', 1, to_date('20/06/1983', 'dd/mm/yyyy'), '3230121035', 'HaNoi', '0901211222', 'Y si/Bac si', 'Tai Mui Hong');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO, CHUYENKHOA) values(00010, 00000, 'Tran Thi Nu', 1, to_date('20/12/1986', 'dd/mm/yyyy'), '3230121031', 'Can Tho', '0913111222', 'Y si/Bac si', 'Khoa Ngoai');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO, CHUYENKHOA) values(00011, 00001, 'Nguyen Chau Nhu Ngoc', 1, to_date('03/10/1985', 'dd/mm/yyyy'), '3160621021', 'Kien Giang', '0913106210', 'Y si/Bac si', 'Khoa Noi');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO, CHUYENKHOA) values(00012, 00001, 'Le Van Thanh', 0, to_date('15/01/1993', 'dd/mm/yyyy'), '3160621012', 'Hoa Binh', '0910621022', 'Y si/Bac si', 'Khoa Ngoai');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO, CHUYENKHOA) values(00013, 00002, 'Le Truong Khuyen Bao', 1, to_date('26/02/1992', 'dd/mm/yyyy'), '3160621018', 'Kien Giang', '0913111621', 'Y si/Bac si', 'Tai Mui Hong');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO, CHUYENKHOA) values(00014, 00003, 'Ly Tung Long', 0, to_date('04/05/1989', 'dd/mm/yyyy'), '3160621014', 'Thanh pho Ho Chi Minh', '0916211222', 'Y si/Bac si', 'Than Kinh');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO, CHUYENKHOA) values(00015, 00002, 'Tran Thi Ha', 1, to_date('25/02/1976', 'dd/mm/yyyy'), '3170221059', 'Phu Quoc', '0913121014', 'Y si/Bac si', 'Tai Mui Hong');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO, CHUYENKHOA) values(00016, 00003, 'Phan Thi Lien', 1, to_date('25/02/1985', 'dd/mm/yyyy'), '3120221134', 'Can Tho', '0912101422', 'Y si/Bac si', 'Khoa Noi');
insert into NHANVIEN(MA_NV, MA_CSYT, HOTEN, PHAI, NGAYSINH, CMND, QUEQUAN, SDT, VAITRO, CHUYENKHOA) values(00017, 00004, 'Huynh Ho Ba Len', 0, to_date('14/01/1992', 'dd/mm/yyyy'), '3160621016', 'Nha Trang', '0913111101', 'Y si/Bac si', 'Khoa Ngoai');

--HSBA:
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000000, 'TMH00',00000, 00007, to_date('01/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00000);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000001, 'CT00', 000012, 00007, to_date('01/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00000);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000002, 'TMH00',00002, 00007, to_date('01/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00000);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000003, 'CT01', 00019, 00011, to_date('01/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000004, 'TMH01', 00009, 00011, to_date('01/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000005, 'CC01', 00008, 00012, to_date('02/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000006, 'CT00', 00005, 00009, to_date('02/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00000);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000007, 'CC02', 00004, 00013, to_date('02/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00002);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000008, 'CT01', 00003, 00011, to_date('03/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000009, 'PS02', 00019, 00015, to_date('03/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00002);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000010, 'TMH00',00018, 00010, to_date('04/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00000);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000011, 'HS02', 00013, 00013, to_date('04/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00002);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000012, 'CT01', 00012, 00012, to_date('04/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000013, 'TMH01',00011, 00011, to_date('05/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000014, 'NG03', 000010, 00014, to_date('05/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00003);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000015, 'TMH00', 00009, 00007, to_date('05/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00000);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000016, 'HS02', 00008, 00015, to_date('05/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00002);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000017, 'CC01', 00007, 00012, to_date('06/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000018, 'PS02', 00005, 00013, to_date('06/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00002);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000019, 'CT00', 00001, 00009, to_date('07/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00000);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000020, 'CT00', 00015, 00009, to_date('07/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00000);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000021, 'ND02', 00014, 00015, to_date('08/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00002);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000022, 'TN03', 00013, 00016, to_date('08/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00003);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000023, 'TMH01', 00010, 00012, to_date('08/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000024, 'CT01', 00012, 00011, to_date('09/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000025, 'TMH00', 00011, 00010, to_date('09/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00000);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000026, 'CC02', 00006, 00013, to_date('09/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00002);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000027, 'NO04', 00010, 00017, to_date('10/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00004);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000028, 'TMH01', 00009, 00011, to_date('10/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000029, 'CC04', 00008, 00008, to_date('11/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00004);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000030, 'PS02', 00007, 00015, to_date('11/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00002);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000031, 'CT01', 00001, 00012, to_date('12/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000032, 'CC04', 00017, 00008, to_date('14/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00004);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000033, 'TMH01', 00018, 00011, to_date('13/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000034, 'TN03', 00019, 00014, to_date('14/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00003);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000035, 'NG03', 00005, 00016, to_date('12/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00003);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000036, 'CT00', 00004, 00009, to_date('12/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00000);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000037, 'CC02', 00003, 00013, to_date('15/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00002);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000038, 'TMH01', 00002, 00012, to_date('15/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000039, 'CT01', 00001, 00012, to_date('15/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00001);
insert into HSBA(MA_HSBA, MA_KHOA, MA_BN, MA_NV, NGAY, CHUANDOAN, KETLUAN, MA_CSYT) values(000000040, 'CT00', 00000, 00010, to_date('16/03/2023', 'dd/mm/yyyy'), 'ABC', 'CDE', 00000);

--DICHVU:
insert into DICHVU(MA_DV, TEN_DV) values('TN', 'Tiem Ngua');
insert into DICHVU(MA_DV, TEN_DV) values('TK', 'Tai Kham');
insert into DICHVU(MA_DV, TEN_DV) values('KB', 'Kham Benh');
insert into DICHVU(MA_DV, TEN_DV) values('TV', 'Tu Van Suc Khoe');

--HSBA_DV:
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000000, 00007, to_date('01/03/2023', 'dd/mm/yyyy'), 'TN', 00000);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000001, 00007, to_date('01/03/2023', 'dd/mm/yyyy'), 'KB', 00000);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000002, 00007, to_date('01/03/2023', 'dd/mm/yyyy'), 'TN', 00000);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000003, 00011, to_date('01/03/2023', 'dd/mm/yyyy'), 'KB', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000004, 00011, to_date('01/03/2023', 'dd/mm/yyyy'), 'KB', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000005, 00012, to_date('02/03/2023', 'dd/mm/yyyy'), 'TV', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000006, 00009, to_date('02/03/2023', 'dd/mm/yyyy'), 'KB', 00000);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000007, 00013, to_date('02/03/2023', 'dd/mm/yyyy'), 'TN', 00002);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000008, 00011, to_date('03/03/2023', 'dd/mm/yyyy'), 'TN', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000009, 00015, to_date('03/03/2023', 'dd/mm/yyyy'), 'TV', 00002);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000010, 00010, to_date('04/03/2023', 'dd/mm/yyyy'), 'TK', 00000);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000011, 00013, to_date('04/03/2023', 'dd/mm/yyyy'), 'TV', 00002);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000012, 00012, to_date('04/03/2023', 'dd/mm/yyyy'), 'TV', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000013, 00011, to_date('05/03/2023', 'dd/mm/yyyy'), 'TK', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000014, 00014, to_date('05/03/2023', 'dd/mm/yyyy'), 'TV', 00003);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000015, 00007, to_date('05/03/2023', 'dd/mm/yyyy'), 'KB', 00000);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000016, 00015, to_date('05/03/2023', 'dd/mm/yyyy'), 'KB', 00002);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000017, 00012, to_date('06/03/2023', 'dd/mm/yyyy'), 'KB', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000018, 00013, to_date('06/03/2023', 'dd/mm/yyyy'), 'TK', 00002);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000019, 00009, to_date('07/03/2023', 'dd/mm/yyyy'), 'KB', 00000);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000020, 00009, to_date('07/03/2023', 'dd/mm/yyyy'), 'KB', 00000);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000021, 00015, to_date('08/03/2023', 'dd/mm/yyyy'), 'KB', 00002);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000022, 00016, to_date('08/03/2023', 'dd/mm/yyyy'), 'TN', 00003);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000023, 00012, to_date('08/03/2023', 'dd/mm/yyyy'), 'KB', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000024, 00011, to_date('09/03/2023', 'dd/mm/yyyy'), 'TN', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000025, 00010, to_date('09/03/2023', 'dd/mm/yyyy'), 'TV', 00000);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000026, 00013, to_date('09/03/2023', 'dd/mm/yyyy'), 'KB', 00002);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000027, 00017, to_date('10/03/2023', 'dd/mm/yyyy'), 'TV', 00004);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000028, 00011, to_date('10/03/2023', 'dd/mm/yyyy'), 'KB', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000029, 00008, to_date('11/03/2023', 'dd/mm/yyyy'), 'TN', 00004);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000030, 00015, to_date('11/03/2023', 'dd/mm/yyyy'), 'TV', 00002);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000031, 00012, to_date('12/03/2023', 'dd/mm/yyyy'), 'TK', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000032, 00008, to_date('14/03/2023', 'dd/mm/yyyy'), 'KB', 00004);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000033, 00011, to_date('13/03/2023', 'dd/mm/yyyy'), 'KB', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000034, 00014, to_date('14/03/2023', 'dd/mm/yyyy'), 'TN', 00003);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000035, 00016, to_date('12/03/2023', 'dd/mm/yyyy'), 'KB', 00003);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000036, 00009, to_date('12/03/2023', 'dd/mm/yyyy'), 'KB', 00000);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000037, 00013, to_date('15/03/2023', 'dd/mm/yyyy'), 'TN', 00002);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000038, 00012, to_date('15/03/2023', 'dd/mm/yyyy'), 'TV', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000039, 00012, to_date('15/03/2023', 'dd/mm/yyyy'), 'KB', 00001);
insert into HSBA_DV(MA_HSBA, MA_NV, NGAY_DV, MA_DV, KETQUA) values(000000040, 00010, to_date('16/03/2023', 'dd/mm/yyyy'), 'KB', 00000);

commit;
