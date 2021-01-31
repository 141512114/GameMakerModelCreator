attribute vec3 in_Position;                 // (x,y,z)
attribute vec3 in_Normal;					// (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                   // (r,g,b,a)
attribute vec2 in_TextureCoord;             // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying vec3 v_vWorldNormal;
varying vec3 v_vWorldViewProjPos;

void main()
{
    vec4 object_space_pos = vec4(in_Position.xyz, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	v_vWorldViewProjPos = gl_Position.xyz;
	
	v_vWorldNormal = normalize(gm_Matrices[MATRIX_WORLD] * vec4(in_Normal.xyz, 0.0)).xyz;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
