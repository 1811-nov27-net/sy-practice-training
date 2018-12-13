using System;
using System.Collections.Generic;
using System.Text;

using Data = MVCDemo.DataAccess;

namespace MVCDemo.DataAccess
{
    public static class Mapper
    {
        public static Data.Movie Map(Movie movie) => new Data.Movie
        {
            Id = movie.Id,
            Title = movie.Title,
            ReleaseDate = movie.ReleaseDate
            //CastMembers = Map(movie.CastMembers)
        };

        /*
        public static Movie Map(Data.Movie movie) => new Movie
        {
            Id = movie.Id,
            Title = movie.Title,
            ReleaseDate = movie.ReleaseDate
        };
        */


    }
}
