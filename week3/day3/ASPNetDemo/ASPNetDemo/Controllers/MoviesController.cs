using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ASPNetDemo.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ASPNetDemo.Controllers
{
    public class MoviesController : Controller
    {
        // we get a new Controller constructed for every request

            // making this static is the quickest way for demo
            // to get data persisted across requests
        public static MovieRepo Repo { get; set; } = new MovieRepo();

        // GET: Movies
        // show a table of all the movies
        public ActionResult Index()
        {
            // "View()" is a method on the base Controller class
            // which looks for a view with the same name as the current method
            // and constructs it with the given parameter if any
            return View(Repo.GetAll());
        }

        // GET: Movies/Details/5
        // action methods get their parameters from
        //   route parameters, query string, request body
        public ActionResult Details(int id)
        {
            var movie = Repo.GetById(id);
            return View(movie);
        }

        // GET: Movies/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Movies/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: Movies/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Movies/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: Movies/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Movies/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}