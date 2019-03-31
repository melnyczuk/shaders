async function draw(vert, frag, uniforms) {
  const canvas = document.querySelector("#glCanvas");
  const gl = canvas.getContext("webgl");

  if (gl === null) {
    alert("Unable to initialize WebGL. Your browser or machine may not support it.");
    return;
  }

  const shaderProgram = initShaderProgram(gl, `${vert}`, `${frag}`);
  clear(gl);
  initCam(gl, shaderProgram);
  invokeUniforms(gl, shaderProgram, uniforms);

  {
    const offset = 0;
    const vertexCount = 4;
    gl.drawArrays(gl.TRIANGLE_STRIP, offset, vertexCount);
  }

  if (gl.getError()) console.log('error code', gl.getError());
};

function initShaderProgram(gl, vsSource, fsSource) {
  const vertexShader = loadShader(gl, gl.VERTEX_SHADER, vsSource);
  const fragmentShader = loadShader(gl, gl.FRAGMENT_SHADER, fsSource);
  const shaderProgram = gl.createProgram();

  gl.attachShader(shaderProgram, vertexShader);
  gl.attachShader(shaderProgram, fragmentShader);
  gl.linkProgram(shaderProgram);

  if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS)) {
    console.log('Unable to initialize the shader program: ' + gl.getProgramInfoLog(shaderProgram));
    return null;
  }

  return shaderProgram;
}

function loadShader(gl, type, source) {
  const shader = gl.createShader(type);
  gl.shaderSource(shader, source);
  gl.compileShader(shader);

  if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
    console.log('An error occurred compiling the shaders: ' + gl.getShaderInfoLog(shader));
    gl.deleteShader(shader);
    return null;
  }

  return shader;
}

function initCam(gl, shaderProgram) {
  const fov = 45 * Math.PI / 180;   // in radians
  const aspect = gl.canvas.clientWidth / gl.canvas.clientHeight;
  const projectionMatrix = mat4.create();
  mat4.perspective(projectionMatrix, fov, aspect, 0.1, 100.0);

  const modelViewMatrix = mat4.create();
  const zoom = -1.0
  mat4.translate(modelViewMatrix, modelViewMatrix, [-0.0, 0.0, zoom]);

  const positionBuffer = gl.createBuffer();
  gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);

  const positions = [-1.0, 1.0, 1.0, 1.0, -1.0, -1.0, 1.0, -1.0];
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(positions), gl.STATIC_DRAW);

  const vertexPosition = gl.getAttribLocation(shaderProgram, 'aVertexPosition');

  {
    gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
    gl.vertexAttribPointer(vertexPosition, 2, gl.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(vertexPosition);
  }

  gl.useProgram(shaderProgram);

  gl.uniformMatrix4fv(
    gl.getUniformLocation(shaderProgram, 'uProjectionMatrix'),
    false,
    projectionMatrix
  );

  gl.uniformMatrix4fv(
    gl.getUniformLocation(shaderProgram, 'uModelViewMatrix'),
    false,
    modelViewMatrix
  );
}

function invokeUniforms(gl, shaderProgram, uniforms) {
  uniforms.forEach(({ type, name, value }) => {
    gl[`uniform${type}`](gl.getUniformLocation(shaderProgram, name), value);
  });
}

function clear(gl) {
  gl.clearColor(0.0, 0.0, 0.0, 1.0);  // Clear to black, fully opaque
  gl.clearDepth(1.0);                 // Clear everything
  gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
}
