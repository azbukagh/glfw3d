import std.stdio;
import glfw3d;
import derelict.opengl3.gl3;
import std.math;
import std.string;

struct Vector3f {
	float x, y, z;
}

void main() {
	// Loading basic OpenGL
	DerelictGL3.load();
	glfw3dInit();

	// Use OpenGL 3.3
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);

	Window w = new Window(640, 480, "glfw3d example");

	w.makeContextCurrent();
	DerelictGL3.reload(); // Now OpenGL 3.3 functions can be called;

	GLuint VBO; // Vertex Buffer Object

	Vector3f[3] Vertices = [
		Vector3f(-1.0f, -1.0f, 0.0f),
		Vector3f(1.0f, -1.0f, 0.0f),
		Vector3f(0.0f, 1.0f, 0.0f)
	];

	glGenBuffers(1, &VBO);
	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER,
		Vertices.length * Vector3f.sizeof,	// Length of Vertices in bytes
		Vertices.ptr,	// Pointer to first element
		GL_STATIC_DRAW);

	// import("file") imports file at compile-time from views/ direcotry
	char[] vertexShaderSource = cast(char[]) import("simple.vert");
	GLint vertexShaderLength = cast(GLint) vertexShaderSource.length;
	const GLchar* vertexShaderSrc = vertexShaderSource.ptr;

	char[] fragmentShaderSource = cast(char[]) import("simple.frag");
	GLint fragmentShaderLength = cast(GLint) fragmentShaderSource.length;
	const GLchar* fragmentShaderSrc = fragmentShaderSource.ptr;

	GLuint program = glCreateProgram();
	GLint success;

	// Compiling Vertex shader
	GLuint vertexShaderObj = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vertexShaderObj, 1, &vertexShaderSrc, &vertexShaderLength);
	glCompileShader(vertexShaderObj);

	// Check for errors
	glGetShaderiv(vertexShaderObj, GL_COMPILE_STATUS, &success);
	if(!success) {
		GLchar[1024] InfoLog;
		glGetShaderInfoLog(vertexShaderObj, InfoLog.length, null, InfoLog.ptr);
		writeln("Compiling shader ", InfoLog.ptr.fromStringz);
	}
	glAttachShader(program, vertexShaderObj); // Attach shader to program

	// Same to Fragment shader
	GLuint fragmentShaderObj = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fragmentShaderObj, 1, &fragmentShaderSrc, &fragmentShaderLength);
	glCompileShader(fragmentShaderObj);

	glGetShaderiv(fragmentShaderObj, GL_COMPILE_STATUS, &success);
	if(!success) {
		GLchar[1024] InfoLog;
		glGetShaderInfoLog(fragmentShaderObj, InfoLog.length, null, InfoLog.ptr);
		writeln("Compiling shader ", InfoLog.ptr.fromStringz);
	}
	glAttachShader(program, fragmentShaderObj);

	// Link program
	glLinkProgram(program);
	// Check for any errors
	glGetProgramiv(program, GL_LINK_STATUS, &success);
	if(!success) {
		GLchar[1024] ErrorLog;
		glGetProgramInfoLog(program, ErrorLog.length, null, ErrorLog.ptr);
		writeln("Linking shader program ", ErrorLog.ptr.fromStringz);
	}

	// Use program
	glUseProgram(program);

	// Find location of gWorld variable in shader
	GLuint gWorld = glGetUniformLocation(program, "gWorld");

	// Vertex Array Object
	GLuint VAO = 0;
	glGenVertexArrays(1, &VAO);
	glBindVertexArray(VAO);

	float Scale = 0.0f;
	while(!w.shouldClose()) {
		glfwPollEvents(); // We dont have to wait for events

		glClear(GL_COLOR_BUFFER_BIT);

		Scale += 0.01f; // Smaller number -> Slower rotation of triangle

		float[4][4] Matrix = [
			[cos(Scale),	-sin(Scale),	0.0f,	0.0f],
			[sin(Scale),	cos(Scale),	0.0f,	0.0f],
			[0.0f,	0.0f,	1.0f,	0.0f],
			[0.0f,	0.0f,	0.0f,	1.0f]
		];

		glUniformMatrix4fv(gWorld, 1, GL_TRUE, &Matrix[0][0]);

		glEnableVertexAttribArray(0);
		glBindBuffer(GL_ARRAY_BUFFER, VBO);
		glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, null);

		glDrawArrays(GL_TRIANGLES, 0, 3);

		glDisableVertexAttribArray(0);

		w.swapBuffers();
	}

	glfw3dTerminate();
}
