"use strict";

function addNumbers(a, b, callback) {
    let result = a + b;

    return callback(result);
}

addNumbers(3,4, console.log); // prints 7

// callbacks are important because we
// do a lot of listening to/waiting for events
// in JS, and also asynchronous stuff

// often use arrow functions
addNumbers(3, 4, result => console.log("calculation done"));

function newCounter() {
    let x = 0;
    return function () {
        return ++x;
    };
}

let counter = newCounter();
// normally at this point, "x" would disappear from the stack
// because it has passed out of scope

console.log(counter()); // prints 1
console.log(counter()); // prints 2
console.log(counter()); // prints 3

let counter2 = newCounter();

console.log(counter2()); // prints 1
console.log(counter2()); // prints 2

// in JavaScript, variables that are referenced by functions
// that are still in scope, themselves remain in scope

// in JavaScript, functions "close over" any variables they
// reference

// this behavior is called "closure"
// sometimes we call the functions themselves "colsures"

// before ES6, we wanted "namespaces", we wanted to
// encapsulate private details and expose only
// needed functionality
// closure allows us to do this

// IIFE (Immediately Invoked Function Expression)
let library = (function() {
    let privateData = 0;
    return {
        libraryMethod() {
            return privateData;
        },

    };
})();
