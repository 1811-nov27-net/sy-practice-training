using System;
using System.Collections.Generic;
using System.Text;

namespace MVCDemo.DataAccess
{
    // 
    public class MovieCastMemberJunction
    {
        public int Id { get; set; }

        public virtual Movie Movie { get; set; }
        public virtual CastMember CastMember { get; set; }
    }
}
