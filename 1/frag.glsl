precision mediump float;

uniform float u_time;
uniform vec2 u_res;

void main() {
  vec2 st = gl_FragCoord.xy/u_res;
  gl_FragColor = vec4(sin(abs(u_time)), st.x, st.y, 1.0);
}
