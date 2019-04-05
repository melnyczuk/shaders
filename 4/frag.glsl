precision mediump float;

uniform float u_time;
uniform vec2 u_res;

void main() {
  vec2 st = gl_FragCoord.xy/u_res;

  float x = ((st.y * 10.0 * abs(sin(u_time * 34.00))) / st.y);
  float y = ((st.x * 10.0 * abs(cos(u_time * 34.88))) / st.x);
  float z = ((st.x * 10.0 * abs(cos(u_time * 34.38))) / st.x);

  gl_FragColor = vec4(vec3(smoothstep(0.1, 0.8, 1.0-x), smoothstep(0.1, 0.8, 1.0-y), smoothstep(0.1, 0.8, 1.0-z)), 1.0);
}

