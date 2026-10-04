shader_type canvas_item;

uniform float speed = .1;
uniform bool paused = false;

void vertex() {
	 if (!paused) {
        UV.x += TIME * speed;
        UV.y += TIME * speed;
    }
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
