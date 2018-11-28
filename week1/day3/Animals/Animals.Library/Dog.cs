using System;

namespace Animals.Library
{
    public class Dog
    {
        // not fields - properties
        public string Name {get; set;}

        // auto-property
        public string Breed {get; set;}

        // property (with explicit backing field)
        private int _age;
        public int Age
        {
            get
            {
                return _age;
            }
            set
            {
                _age = value;
                // keyword "value" in a setter takes in the assigned value
            }
        }

        private int Weight;

        // classic getters and setters
        public int GetWeight(){
            return Weight;
        }

        public void SetWeight(int weight){
            Weight = weight;
        }

        public void Bark()
        {
            Console.WriteLine("Woof");
        }

        // snippets: prop, propfull
    }
}
