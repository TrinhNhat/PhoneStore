//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace PhoneStore.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class DIENTHOAI
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DIENTHOAI()
        {
            this.CHITIETDONHANGs = new HashSet<CHITIETDONHANG>();
        }
    
        public string MaDT { get; set; }
        public string TenDT { get; set; }
        public string MotaNgan { get; set; }
        public string MotaDai { get; set; }
        public Nullable<System.DateTime> NgayNhap { get; set; }
        public Nullable<int> DonGia { get; set; }
        public Nullable<int> SLTon { get; set; }
        public Nullable<int> SLBan { get; set; }
        public Nullable<int> SLXem { get; set; }
        public Nullable<int> MaNSX { get; set; }
        public Nullable<int> MaHang { get; set; }
    
        public virtual NHASANXUAT NHASANXUAT { get; set; }
        public virtual HANGDIENTHOAI HANGDIENTHOAI { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CHITIETDONHANG> CHITIETDONHANGs { get; set; }
    }
}
