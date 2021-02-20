if (model != -1) {
	var model_buffer = buffer_create_from_vertex_buffer(model, buffer_fixed, 1);

	for (var i = 0; i < buffer_get_size(model_buffer); i += 36) {
		var xx = buffer_peek(model_buffer, i + 0, buffer_f32);
		var yy = buffer_peek(model_buffer, i + 4, buffer_f32);
		var zz = buffer_peek(model_buffer, i + 8, buffer_f32);
	
		buffer_poke(model_buffer, i + 0, buffer_f32, xx + random_range(-2, 2));
		buffer_poke(model_buffer, i + 4, buffer_f32, yy + random_range(-2, 2));
		buffer_poke(model_buffer, i + 8, buffer_f32, zz + random_range(-2, 2));
	}

	vertex_delete_buffer(model);
	model = vertex_create_buffer_from_buffer(model_buffer, o_softwareManager.vformat);
	buffer_delete(model_buffer);
}