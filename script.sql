USE [master]
GO
/****** Object:  Database [QLPhoneStore]    Script Date: 4/27/2018 2:06:28 PM ******/
CREATE DATABASE [QLPhoneStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLPhoneStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QLPhoneStore.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QLPhoneStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QLPhoneStore_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QLPhoneStore] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLPhoneStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLPhoneStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLPhoneStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLPhoneStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLPhoneStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLPhoneStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLPhoneStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLPhoneStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLPhoneStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLPhoneStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLPhoneStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLPhoneStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLPhoneStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLPhoneStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLPhoneStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLPhoneStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLPhoneStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLPhoneStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLPhoneStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLPhoneStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLPhoneStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLPhoneStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLPhoneStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLPhoneStore] SET RECOVERY FULL 
GO
ALTER DATABASE [QLPhoneStore] SET  MULTI_USER 
GO
ALTER DATABASE [QLPhoneStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLPhoneStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLPhoneStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLPhoneStore] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QLPhoneStore] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLPhoneStore', N'ON'
GO
USE [QLPhoneStore]
GO
/****** Object:  Table [dbo].[CHITIETDONHANG]    Script Date: 4/27/2018 2:06:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHITIETDONHANG](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaDH] [int] NULL,
	[MaDT] [varchar](5) NULL,
	[SoLuong] [int] NULL,
	[DonGia] [int] NULL,
	[ThanhTien] [int] NULL,
 CONSTRAINT [PK_CHITIETDONHANG] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DIENTHOAI]    Script Date: 4/27/2018 2:06:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DIENTHOAI](
	[MaDT] [varchar](5) NOT NULL,
	[TenDT] [nvarchar](50) NULL,
	[MotaNgan] [nvarchar](100) NULL,
	[MotaDai] [ntext] NULL,
	[NgayNhap] [date] NULL,
	[DonGia] [int] NULL,
	[SLTon] [int] NULL,
	[SLBan] [int] NULL,
	[SLXem] [int] NULL,
	[MaNSX] [int] NULL,
	[MaHang] [int] NULL,
 CONSTRAINT [PK_DIENTHOAI] PRIMARY KEY CLUSTERED 
(
	[MaDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DONHANG]    Script Date: 4/27/2018 2:06:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DONHANG](
	[MaDH] [int] IDENTITY(1,1) NOT NULL,
	[MaTK] [int] NULL,
	[NgayDatHang] [date] NULL,
	[NguoiDat] [nvarchar](50) NULL,
	[TongCong] [decimal](18, 0) NULL,
	[TinhTrang] [nvarchar](55) NULL,
 CONSTRAINT [PK_DONHANG] PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HANGDIENTHOAI]    Script Date: 4/27/2018 2:06:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HANGDIENTHOAI](
	[MaHang] [int] NOT NULL,
	[TenHang] [varchar](20) NULL,
 CONSTRAINT [PK_HANGDIENTHOAI] PRIMARY KEY CLUSTERED 
(
	[MaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NHASANXUAT]    Script Date: 4/27/2018 2:06:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NHASANXUAT](
	[MaNSX] [int] NOT NULL,
	[TenNSX] [varchar](40) NULL,
	[QuocGia] [nvarchar](50) NULL,
 CONSTRAINT [PK_NHASANXUAT] PRIMARY KEY CLUSTERED 
(
	[MaNSX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TAIKHOAN]    Script Date: 4/27/2018 2:06:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TAIKHOAN](
	[MaTK] [int] IDENTITY(1,1) NOT NULL,
	[TenDN] [varchar](20) NOT NULL,
	[MatKhau] [varchar](100) NOT NULL,
	[Email] [varchar](40) NOT NULL,
	[LoaiTK] [varchar](3) NOT NULL,
	[TenKH] [nvarchar](40) NULL,
	[NgaySinh] [date] NULL,
 CONSTRAINT [PK_TAIKHOAN] PRIMARY KEY CLUSTERED 
(
	[MaTK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[CHITIETDONHANG] ON 

INSERT [dbo].[CHITIETDONHANG] ([ID], [MaDH], [MaDT], [SoLuong], [DonGia], [ThanhTien]) VALUES (1, 1, N'DT002', 1, 24990000, 24990000)
INSERT [dbo].[CHITIETDONHANG] ([ID], [MaDH], [MaDT], [SoLuong], [DonGia], [ThanhTien]) VALUES (2, 1, N'DT013', 2, 15990000, 31980000)
INSERT [dbo].[CHITIETDONHANG] ([ID], [MaDH], [MaDT], [SoLuong], [DonGia], [ThanhTien]) VALUES (3, 1, N'DT006', 1, 16990000, 16990000)
INSERT [dbo].[CHITIETDONHANG] ([ID], [MaDH], [MaDT], [SoLuong], [DonGia], [ThanhTien]) VALUES (4, 2, N'DT004', 2, 28790000, 57580000)
INSERT [dbo].[CHITIETDONHANG] ([ID], [MaDH], [MaDT], [SoLuong], [DonGia], [ThanhTien]) VALUES (5, 2, N'DT001', 2, 34790000, 69580000)
INSERT [dbo].[CHITIETDONHANG] ([ID], [MaDH], [MaDT], [SoLuong], [DonGia], [ThanhTien]) VALUES (6, 2, N'DT005', 1, 22990000, 22990000)
INSERT [dbo].[CHITIETDONHANG] ([ID], [MaDH], [MaDT], [SoLuong], [DonGia], [ThanhTien]) VALUES (7, 3, N'DT002', 2, 24990000, 49980000)
INSERT [dbo].[CHITIETDONHANG] ([ID], [MaDH], [MaDT], [SoLuong], [DonGia], [ThanhTien]) VALUES (1007, 1003, N'DT014', 1, 5490000, 5490000)
SET IDENTITY_INSERT [dbo].[CHITIETDONHANG] OFF
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT001', N'Điện thoại iPhone X 256GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-10-04' AS Date), 34790000, 8, 7, 82, 1, 1)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT002', N'Điện thoại Samsung Galaxy S9+ 128GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2017-02-05' AS Date), 24990000, 5, 7, 11, 2, 2)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT003', N'Điện thoại iPhone X 64GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2017-07-08' AS Date), 29990000, 100, 12, 11, 2, 1)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT004', N'Điện thoại iPhone 8 Plus 256GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-12-04' AS Date), 28790000, 454, 125, 10, 3, 1)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT005', N'Điện thoại iPhone 7 Plus 128GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-10-04' AS Date), 22990000, 77, 5, 4, 4, 1)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT006', N'Điện thoại iPhone 6s 128GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2017-05-04' AS Date), 16990000, 99, 3, 4, 5, 1)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT007', N'Điện thoại iPhone 7 32GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2017-10-07' AS Date), 15990000, 100, 1, 2, 5, 1)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT008', N'Điện thoại iPhone 6s Plus 32GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2017-01-02' AS Date), 13990000, 100, 1, 3, 5, 1)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT009', N'Điện thoại iPhone 6 32GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-04-12' AS Date), 7990000, 100, 1, 13, 1, 1)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT010', N'Điện thoại iPhone 6s 32GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-04-12' AS Date), 12490000, 200, 1, 6, 3, 1)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT011', N'Điện thoại Samsung Galaxy S9+ 64GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-04-12' AS Date), 23490000, 100, 1, 9, 2, 2)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT012', N'Điện thoại Samsung Galaxy Note 8', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-04-12' AS Date), 22490000, 400, 5, 21, 3, 2)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT013', N'Điện thoại Samsung Galaxy S8', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-03-12' AS Date), 15990000, 198, 14, 12, 4, 2)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT014', N'Điện thoại ASUS Zenfone Plus M1', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-02-12' AS Date), 5490000, 99, 2, 8, 1, 4)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT015', N'Điện thoại Asus Zenfone 4 Max Pro', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-10-02' AS Date), 4690000, 100, 1, 5, 5, 4)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT016', N'Điện thoại Asus Zenfone 4 Max ', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2017-04-05' AS Date), 3490000, 100, 1, 6, 4, 4)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT017', N'Điện thoại OPPO F5 6GB', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-04-12' AS Date), 8990000, 100, 1, 6, 5, 3)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT018', N'Điện thoại OPPO F3 Plus', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2017-04-05' AS Date), 7490000, 500, 1, 6, 3, 3)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT019', N'Điện thoại OPPO F5 Youth', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2017-09-08' AS Date), 6990000, 400, 1, 12, 2, 3)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT020', N'Điện thoại OPPO A83', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-04-12' AS Date), 4990000, 800, 1, 16, 1, 3)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT021', N'Điện thoại Samsung Galaxy J7+', N'Sang trọng và đẳng cấp', N'<span style="color: red; font-weight: bold"> Thông số kỹ thuật: </span>
<br></br>
<table border="0" cellpadding="0" cellspacing="2">
    <tbody>
        <tr><td class="nen_xam_dam" width="35%">Màn hình:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam">Công nghệ màn hình</span> OLED</td></tr>
        <tr><td class="nen_xam_default" width="35%">&nbsp;</td><td class="nen_xam_default" width="65%"> <span class="xamdam">Độ phân giải</span> <span class="maudo_khongchieucao">1125 x 2436 Pixels</span> </td></tr>
        <tr>
            <td class="nen_xam_default" width="35%">&nbsp;</td>
            <td class="nen_xam_nhat" width="65%">
                <span class="xamdam">Màn hình rộng</span> <span class="maudo_khongchieucao">5.8"</span>
            </td>
        </tr>       
		<tr><td class="nen_xam_dam" width="35%">Hệ điều hành:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>iOS 11</td></tr>      
        <tr><td class="nen_xam_dam" width="35%">Camera sau:</td><td class="nen_xam_nhat" width="65%"><span class="xamdam"></span>2 camera 12 MP</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Camera trước:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>7 MP</td></tr>
		<tr><td class="nen_xam_dam" width="35%">CPU:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>Apple A11 Bionic 6 nhân</td></tr>
	    <tr><td class="nen_xam_dam" width="35%">Ram:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>3 GB</td></tr>
		<tr><td class="nen_xam_dam" width="35%">Bộ nhớ trong:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>256 GB</td></tr>
        <tr><td class="nen_xam_dam" width="35%">Thẻ SIM:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>1 Nano SIM, Hỗ trợ 4G</td></tr>     
        <tr><td class="nen_xam_dam" width="35%">Dung lượng pin:</td><td class="nen_xam_default" width="65%"><span class="xamdam"></span>2716 mAh, có sạc nhanh</td></tr>
      
    </tbody>
</table>

', CAST(N'2018-06-05' AS Date), 7290000, 600, 1, 9, 2, 2)
INSERT [dbo].[DIENTHOAI] ([MaDT], [TenDT], [MotaNgan], [MotaDai], [NgayNhap], [DonGia], [SLTon], [SLBan], [SLXem], [MaNSX], [MaHang]) VALUES (N'DT022', N'nhat', N'Không có mô tả', N'&lt;p&gt;Kh&amp;ocirc;ng c&amp;oacute; m&amp;ocirc; tả&lt;/p&gt;', CAST(N'2018-04-24' AS Date), 1997, 3, 0, 6, 1, 2)
SET IDENTITY_INSERT [dbo].[DONHANG] ON 

INSERT [dbo].[DONHANG] ([MaDH], [MaTK], [NgayDatHang], [NguoiDat], [TongCong], [TinhTrang]) VALUES (1, 1003, CAST(N'2018-04-18' AS Date), N'asdas', CAST(73960000 AS Decimal(18, 0)), N'Đã giao hàng')
INSERT [dbo].[DONHANG] ([MaDH], [MaTK], [NgayDatHang], [NguoiDat], [TongCong], [TinhTrang]) VALUES (2, 1003, CAST(N'2018-04-19' AS Date), N'asdas', CAST(150150000 AS Decimal(18, 0)), N'Chưa giao hàng')
INSERT [dbo].[DONHANG] ([MaDH], [MaTK], [NgayDatHang], [NguoiDat], [TongCong], [TinhTrang]) VALUES (3, 1, CAST(N'2018-04-22' AS Date), N'Admin', CAST(49980000 AS Decimal(18, 0)), N'Đã giao hàng')
INSERT [dbo].[DONHANG] ([MaDH], [MaTK], [NgayDatHang], [NguoiDat], [TongCong], [TinhTrang]) VALUES (1003, 1003, CAST(N'2018-04-27' AS Date), N'nhat', CAST(5490000 AS Decimal(18, 0)), N'Chưa giao hàng')
SET IDENTITY_INSERT [dbo].[DONHANG] OFF
INSERT [dbo].[HANGDIENTHOAI] ([MaHang], [TenHang]) VALUES (1, N'iPhone (Apple)')
INSERT [dbo].[HANGDIENTHOAI] ([MaHang], [TenHang]) VALUES (2, N'SamSung')
INSERT [dbo].[HANGDIENTHOAI] ([MaHang], [TenHang]) VALUES (3, N'OPPO')
INSERT [dbo].[HANGDIENTHOAI] ([MaHang], [TenHang]) VALUES (4, N'Asus (Zenfone)')
INSERT [dbo].[NHASANXUAT] ([MaNSX], [TenNSX], [QuocGia]) VALUES (1, N'VIETNAM', N'Việt Nam')
INSERT [dbo].[NHASANXUAT] ([MaNSX], [TenNSX], [QuocGia]) VALUES (2, N'AMERICA', N'Mỹ')
INSERT [dbo].[NHASANXUAT] ([MaNSX], [TenNSX], [QuocGia]) VALUES (3, N'FRANCE', N'Pháp')
INSERT [dbo].[NHASANXUAT] ([MaNSX], [TenNSX], [QuocGia]) VALUES (4, N'CANADA', N'Canada')
INSERT [dbo].[NHASANXUAT] ([MaNSX], [TenNSX], [QuocGia]) VALUES (5, N'GERMANY', N'Đức')
SET IDENTITY_INSERT [dbo].[TAIKHOAN] ON 

INSERT [dbo].[TAIKHOAN] ([MaTK], [TenDN], [MatKhau], [Email], [LoaiTK], [TenKH], [NgaySinh]) VALUES (1, N'admin', N'E10ADC3949BA59ABBE56E057F20F883E', N'nhat@gmail.com', N'AAD', N'Admin', CAST(N'1997-03-23' AS Date))
INSERT [dbo].[TAIKHOAN] ([MaTK], [TenDN], [MatKhau], [Email], [LoaiTK], [TenKH], [NgaySinh]) VALUES (1003, N'a', N'E10ADC3949BA59ABBE56E057F20F883E', N'trinhminhnhat@gmail.com', N'AKH', N'nhat', CAST(N'2000-04-21' AS Date))
SET IDENTITY_INSERT [dbo].[TAIKHOAN] OFF
USE [master]
GO
ALTER DATABASE [QLPhoneStore] SET  READ_WRITE 
GO
