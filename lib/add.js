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
    return numbers.reduce(function(sum, n){
            return sum + n;
        }, 0);
}
