﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using TemperatureWebsite.Models;

namespace TemperatureWebsite.Controllers
{
    public class TemperatureController : Controller
    {
        public HttpClient Client { get; set; }

        // dependency injection
        public TemperatureController(HttpClient client)
        {
            Client = client;
        }

        // GET: Temperature
        public async Task<ActionResult> Index()
        {
            // send "GET api/Temperature" to service, get headers of response
            HttpResponseMessage response = await Client.GetAsync("https://localhost:44373/api/temperature");

            // (if status code is not 200-299 (for success))
            if (!response.IsSuccessStatusCode)
            {
                return RedirectToAction("Error", "Home");
            }

            // get the whole response body
            var responseBody = await response.Content.ReadAsStringAsync();

            // this is a string, so it must be deserialized into a C# object.
            // we could use DataContractSerializer, .NET built-in, but it's more awkward
            // than the third-party JSON.NET aka Newtonsoft JSON.
            List<TemperatureRecord> temperatures = JsonConvert.DeserializeObject<List<TemperatureRecord>>(responseBody);



            return View(temperatures);
        }

        // GET: Temperature/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Temperature/Create
        public ActionResult Create()
        {
            return View(new TemperatureRecord { Time = DateTime.Now });
        }

        public static HttpContent ToContent<T>(T obj)
        {
            string json = JsonConvert.SerializeObject(obj);
            // declare the encoding (unicode)
            // and the "media type" (JSON) of the thing to send in the request body
            HttpContent content = new StringContent(json, Encoding.UTF8, "application/json");
            return content;
        }

        // POST: Temperature/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create(TemperatureRecord newRecord)
        {
            try
            {
                // set unit to 1 (Celsius)
                newRecord.Unit = 1;
                // use POST method, not GET, based on the route the service has defined
                HttpResponseMessage response = await Client.PostAsync("https://localhost:44373/api/temperature", ToContent(newRecord));

                if (response.IsSuccessStatusCode)
                {
                    return RedirectToAction(nameof(Index));
                }
                return View(newRecord);
            }
            catch
            {
                return View();
            }
        }

        // GET: Temperature/Edit/5
        public ActionResult Edit(int id)
        {
            /*
            var json = await Client.GetStringAsync($"https://localhost:44373/api/temperature/{id}");
            return View(JsonConvert.DeserializeObject<TemperatureRecord>(json));
            */
            return View();
        }

        // POST: Temperature/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit(int id, TemperatureRecord newRecord)
        {
            try
            {
                newRecord.Unit = 1;
                var url = $"https://localhost:44373/api/temperature/{id}";
                var response = await Client.PutAsJsonAsync(url, newRecord);

                if (response.IsSuccessStatusCode)
                {
                    return RedirectToAction(nameof(Index));
                }
                return View(newRecord);
            }
            catch
            {
                return View(newRecord);
            }
        }

        // GET: Temperature/Delete/5
        public async Task<ActionResult> Delete(int id)
        {
            var json = await Client.GetStringAsync($"https://localhost:44373/api/temperature/{id}");
            return View(JsonConvert.DeserializeObject<TemperatureRecord>(json));
        }

        // POST: Temperature/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Delete(int id, IFormCollection collection)
        {
            try
            {
                var response = await Client.DeleteAsync($"https://localhost:44373/api/temperature/{id}");

                if (response.IsSuccessStatusCode)
                {
                    return RedirectToAction(nameof(Index));
                }
                return RedirectToAction(nameof(Delete), new { id });
            }
            catch
            {
                return RedirectToAction(nameof(Delete), new { id });
            }
        }
    }
}