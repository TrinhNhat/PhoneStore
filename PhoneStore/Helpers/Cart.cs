using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PhoneStore.Helpers
{
    public class Cart
    {
        public List<CartItem> Items { get; set; }

        public Cart()
        {
            Items = new List<CartItem>();
        }

        public void Add(CartItem item)
        {
            CartItem esItem = Items.Where(i => i.ProID == item.ProID).FirstOrDefault();

            if (esItem != null)
            {
                esItem.Quantity += item.Quantity;
            }
            else
            {
                Items.Add(item);
            }
        }

        public int GetNumberOfItem()
        {
            return Items.Sum(i => i.Quantity);
        }

        public void RemoveItem(string proid)
        {
            CartItem esItem = Items.Where(i => i.ProID == proid).FirstOrDefault();

            if (esItem != null)
            {
                Items.Remove(esItem);
            }
        }

        public void UpdateItem(string proid, int quantity)
        {
            CartItem esItem = Items.Where(i => i.ProID == proid).FirstOrDefault();

            if (esItem != null)
            {
                esItem.Quantity = quantity;
            }
        }
    }

    public class CartItem
    {
        public string ProID { get; set; }

        public int Quantity { get; set; }
    }
}
