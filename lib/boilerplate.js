/**
 * Require methods
 */

var add = require('./add.js');

/**
 * Expose Boilerplate
 */

module.exports = boilerplate;

/**
 * Shims
 */

var slice = [].slice;

/**
 * Boilerplate component.
 *
 * Example:
 *
 *      boilerplate('add', 4, 5, 6);
 *      // => 15
 *
 * @param  {String}     command
 * @param  {...Number}  numbers
 * @return {Number}
 */

function boilerplate(command) {
    // skip first
    var numbers = slice.call(arguments, 1);

    if (command == 'add')
        return add(numbers);

    throw new Error(command + ' not supported.');
}
