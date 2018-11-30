using LINQandTesting.Library;
using System;
using Xunit;

namespace LINQandTesting.Tests
{
    // typically one test class to test each real class
    public class MyCollectionTest
    {
        // in XUnit, each unit test, to test one thing, should be
        // a method with the "Fact" attribute

        [Fact] // this kind of thing is called an "attribute" -
               //    special kind of class that adds extra behavior to a class,
               //    method, property, etc.
        public void EmptyCollectionShouldHaveZeroLength()
        {
            // arrange (set up the situation to be tested)
            // sometimes people use acronym "SUT" for "subject under test"
            var sut = new MyCollection();
            // it's already empty

            // act (run the method/behavior that we're specifically testing)
            var result = sut.Length;

            // assert (define what the correct result is and check that we got it.)
            Assert.Equal(0, result);
        }
    }
}
