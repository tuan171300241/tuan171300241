# 1. Cấu trúc bảng
# Các bảng cần thiết trong CSDL:
#
# SinhVien: Thông tin sinh viên.
# LopHoc: Thông tin lớp học.
# MonHoc: Thông tin môn học.
# DiemThi: Điểm thi của sinh viên.
# 2. Tạo CSDL và bảng

-- Tạo cơ sở dữ liệu
CREATE DATABASE Nhom18_QLTT_ClustrixDB;
USE Nhom18_QLTT_ClustrixDB;

-- Bảng SinhVien
CREATE TABLE SinhVien (
                          MaSV INT AUTO_INCREMENT PRIMARY KEY,
                          HoTen VARCHAR(100) NOT NULL,
                          GioiTinh ENUM('Nam', 'Nu') NOT NULL,
                          NgaySinh DATE NOT NULL,
                          DiaChi VARCHAR(255),
                          Email VARCHAR(100) UNIQUE,
                          SoDienThoai VARCHAR(15) UNIQUE
);

-- Bảng LopHoc
CREATE TABLE LopHoc (
                        MaLop INT AUTO_INCREMENT PRIMARY KEY,
                        TenLop VARCHAR(100) NOT NULL,
                        KhoaHoc VARCHAR(50) NOT NULL
);

-- Bảng MonHoc
CREATE TABLE MonHoc (
                        MaMon INT AUTO_INCREMENT PRIMARY KEY,
                        TenMon VARCHAR(100) NOT NULL,
                        SoTinChi INT NOT NULL
);

-- Bảng DiemThi
CREATE TABLE DiemThi (
                         MaDiem INT AUTO_INCREMENT PRIMARY KEY,
                         MaSV INT NOT NULL,
                         MaMon INT NOT NULL,
                         Diem FLOAT NOT NULL,
                         LanThi INT NOT NULL,
                         FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV) ON DELETE CASCADE,
                         FOREIGN KEY (MaMon) REFERENCES MonHoc(MaMon) ON DELETE CASCADE
);
# 3. Chức năng quản lý
# a) Thêm sinh viên mới

INSERT INTO SinhVien (MaSV, HoTen, GioiTinh, NgaySinh, DiaChi, Email, SoDienThoai)
VALUES
    (1, 'Nguyen Van A', 'Nam', '2000-01-15', 'Ha Noi', 'vana@gmail.com', '0123456789'),
    (2, 'Le Thi B', 'Nu', '1999-03-22', 'Hai Phong', 'lethib@gmail.com', '0987654321'),
    (3, 'Tran Van C', 'Nam', '2001-07-19', 'Da Nang', 'tranvanc@gmail.com', '0912345678'),
    (4, 'Pham Thi D', 'Nu', '2000-05-10', 'Ho Chi Minh', 'phamthid@gmail.com', '0934567890'),
    (5, 'Hoang Van E', 'Nam', '1998-11-25', 'Hue', 'hoangvane@gmail.com', '0945678123');

# Thêm lớp học
INSERT INTO LopHoc (MaLop, TenLop, KhoaHoc)
VALUES
    (1, 'CNTT01', '2020-2024'),
    (2, 'CNTT02', '2021-2025'),
    (3, 'QTKD01', '2019-2023'),
    (4, 'CK01', '2020-2024'),
    (5, 'KT01', '2021-2025');
# Thêm môn học
INSERT INTO MonHoc (MaMon, TenMon, SoTinChi)
VALUES
    (1, 'Lap Trinh C', 3),
    (2, 'Toan Cao Cap', 4),
    (3, 'Cau Truc Du Lieu', 3),
    (4, 'Tri Tue Nhan Tao', 3),
    (5, 'Kinh Te Vi Mo', 2);

# Thêm điểm thi
INSERT INTO DiemThi (MaDiem, MaSV, MaMon, Diem, LanThi)
VALUES
    (1, 1, 1, 8.5, 1),
    (2, 1, 2, 7.0, 1),
    (3, 2, 3, 9.0, 1),
    (4, 3, 4, 6.5, 1),
    (5, 4, 5, 8.0, 1),
    (6, 5, 1, 7.5, 1),
    (7, 2, 2, 8.0, 2),
    (8, 3, 3, 9.5, 1);


# b) Cập nhật thông tin sinh viên
UPDATE SinhVien
SET DiaChi = 'Ho Chi Minh', SoDienThoai = '0987654322'
WHERE MaSV = 1;
# c) Xóa sinh viên
DELETE FROM SinhVien WHERE MaSV = 1;
# d) Xem danh sách sinh viên
SELECT * FROM SinhVien;
# e) Thêm điểm thi cho sinh viên
INSERT INTO DiemThi (MaSV, MaMon, Diem, LanThi)
VALUES (2, 1, 8.5, 1);
# f) Xem điểm thi của sinh viên
SELECT sv.HoTen, mh.TenMon, dt.Diem, dt.LanThi
FROM DiemThi dt
         JOIN SinhVien sv ON dt.MaSV = sv.MaSV
         JOIN MonHoc mh ON dt.MaMon = mh.MaMon
WHERE sv.MaSV = 2;
# g) Thống kê điểm trung bình mỗi sinh viên
SELECT sv.HoTen, AVG(dt.Diem) AS DiemTrungBinh
FROM DiemThi dt
         JOIN SinhVien sv ON dt.MaSV = sv.MaSV
GROUP BY sv.MaSV;
# 4. Index để tăng hiệu suất
CREATE INDEX idx_sinhvien_email ON SinhVien (Email);
CREATE INDEX idx_diemthi_masv ON DiemThi (MaSV);