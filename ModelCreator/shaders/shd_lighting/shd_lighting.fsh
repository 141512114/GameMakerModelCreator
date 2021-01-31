varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying vec3 v_vWorldNormal;
varying vec3 v_vWorldViewProjPos;

// Light uniforms
uniform vec3 u_vLightDir;
uniform vec4 u_vLightColor;

void main()
{
    vec4 startingColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	// Calculate lighting
	vec4 lightAmbient = vec4(0.25, 0.25, 0.25, 1.0);
	vec3 lightDir = normalize(-u_vLightDir);
	
	float lightDot = max(dot(v_vWorldNormal, lightDir), 0.0);
	
	// Set advanced color
	gl_FragColor = startingColor * vec4(min(lightAmbient + u_vLightColor * lightDot, vec4(1.0)).rgb, startingColor.a);
}
