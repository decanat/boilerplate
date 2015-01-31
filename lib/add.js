/**
 * Require dependencies
 */

var each = require('yiwn-each');

/**
 * Expose `add`
 */

module.exports = add;

/**
 * Add and return given numbers.
 *
 * @param {Array}   numbers
 * @return {Number} summary
 */

function add(numbers) {
    var sum = 0;

    each(numbers, function(num) {
        sum += num;
    });

    return sum;
}
