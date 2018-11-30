using System;

namespace Delegates
{
    class Program
    {
        static void Main(string[] args)
        {
            // object initialization syntax
            // if no params after MoviePlayer, zero-arg constructor "()" is assumed.
            var player = new MoviePlayer
            {
                CurrentMovie = "Lord of the Rings: The Fellowship of the Ring Extended Edition"
            };

            // the function must have a compatible signature
            // with the delegate of the event.
            MoviePlayer.MovieFinishedStringHandler handler = EjectDisc;

            // subscribe to events with +=
            player.MovieFinished += handler;
            // unsubscribe with -=
            //player.MovieFinished -= handler;
            // it's like you're appending to a list of functions.

            // when C# got generics, they added Func and Action generic classes.
            // and we can use these instead of delegate types.

            // Action is for void-return functions
            // Func is for non-void-return functions
            Action<string> handler2 = EjectDisc;

            //player.MovieFinished += handler2;

            // lambda expressions
            player.MovieFinished += s => Console.WriteLine("lambda subscribe");
            // this lambda takes in a string (inferred by compiler)
            // and returns nothing (because WriteLine returns nothing).
            // therefore it is compatible with that delegate type.
            // and we don't need to define a method like "EjectDisc".

            player.PlayMovie();

            // some func/action examples:

            // function taking int and string, returning bool:
            Func<int, string, bool> func = (num, str) => true;
            // the last type parameter is the return type,
            // and the ones before it are the arguments.

            // function taking zero arguments, returning bool:
            Func<bool> func2 = () => false;

            // function taking three arguments, returning void:
            Action<int, string, bool> func3 = (num, str, b) =>
            {
                if (b)
                {
                    Console.WriteLine(num);
                    Console.WriteLine(str);
                }
                // lambdas can have a block body like methods
            };

            // function taking bool, returning void:
            Action<bool> func4 = b => { return; };
        }

        static void EjectDisc()
        {
            Console.WriteLine("Ejecting disc.");
        }

        static void EjectDisc(string title)
        {
            Console.WriteLine($"Ejecting disc {title}.");
        }
        // having two methods with the same name but different arguments
        // is allowed, this is called method overloading.
        // it's not a problem because C# can always tell which one you mean by what arguments
        // you give it when you try to call it.

        // don't confuse this with method overriding (inheritance).
    }
}
