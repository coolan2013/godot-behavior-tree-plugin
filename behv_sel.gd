extends Node
################
# The MIT License (MIT)
#
# Copyright (c) 2016 Jeffery Olson <olson.jeffery@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

const BEHV_SUCESS = 0;
const BEHV_FAILURE = 1;
const BEHV_RUNNING = 2;

var last_result = BH_FAILURE
var last_child_index = 0

func _ready():
	pass

func tick(ctx):
	var early_bail = false
	var found_success = false
	for idx in range(last_child_index, get_child_count()):
		var child = get_child(idx)
		last_child_index = idx
		last_result = child.tick(ctx)
		if last_result == BEHV_SUCESS:
			early_bail = false
			break
		if last_result == BEHV_RUNNING:
			early_bail = true
			break
	if not early_bail or last_child_index == get_child_count() - 1:
		last_child_index = 0
	return last_result