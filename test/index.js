/**
 * Require dependencies
 */

// Standard assertion library
var assert = require('assert');

/**
 * Main script
 */

var boilerplate = require('..');


describe('(\'add\')', function() {
    it('should calculate correct sum', function(){
        assert.equal(boilerplate('add', 4, 5, 6), 15);
    });

    it('should do type conversion and skip not-numbers', function() {
        assert.equal(boilerplate('add', 4, '5', '6'), 15);
        assert.equal(boilerplate('add', 4, 5, 'vec'), 9);
        assert.equal(boilerplate('add', 'hing', 'vec'), 0);
    });
});

describe('(else)', function(){
    it('should throw an exception', function() {
        // calls `boilerplate` with 'hello' as first argument
        var hello = boilerplate.bind(null, 'hello', 'region');

        assert.throws(hello, Error);
    });
});
