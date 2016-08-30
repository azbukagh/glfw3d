module glfw3d.Main;

import std.experimental.logger;
import glfw3d.glfw3;
__gshared Logger glfw3dLog;

/**
*	Terminates glfw3d
*/
alias glfw3dTerminate = glfwTerminate;

shared static this() {
	glfw3dLog = sharedLog;
}

/**
*	glfw3d throws this exception on errors
*/
class glfw3dException : Exception {
	pure nothrow @nogc @safe this(string msg,
		string file = __FILE__,
		size_t line = __LINE__,
		Throwable next = null) {
			super(msg, file, line, next);
	}
}

/**
*	Returns GLFW version
*	Returns: [Major, Minor, Rev]
*/
int[3] glfw3dVersion() {
	int major, minor, rev;
	glfwGetVersion(&major, &minor, &rev);
	return [major, minor, rev];
}

/**
*	Returns: GLFW version
*/
string glfw3dVersionString() {
	import std.string : fromStringz;
	return cast(string) glfwGetVersionString().fromStringz;
}

private template Error(string e) {
	const char[] Error = 
	"case GLFW_" ~ e ~ ":"
	~" try {glfw3dLog.log(\"GLFW error: \", desc);} catch {} break;";
}

extern(C) nothrow void glfw3dErrorCallback(int error, const(char)* desc) {
	switch(error) {
		mixin(Error!("VERSION_UNAVAILABLE"));
		mixin(Error!("NO_CURRENT_CONTEXT"));
		mixin(Error!("FORMAT_UNAVAILABLE"));
//		mixin(Error!("NO_WINDOW_CONTEXT"));
		mixin(Error!("NOT_INITIALIZED"));
		mixin(Error!("API_UNAVAILABLE"));
		mixin(Error!("PLATFORM_ERROR"));
		mixin(Error!("INVALID_VALUE"));
		mixin(Error!("OUT_OF_MEMORY"));
		mixin(Error!("INVALID_ENUM"));
		
		default:
			try {glfw3dLog.log("GLFW error: unknown");} catch {}
			break;
	}
}

/**
*	Initializes glfw3d
*	Throws: glfw3dException on error
*	Params:
*		l = logger for glfw3d
*/
void glfw3dInit(Logger l) {
	glfw3dLog = l;
	glfw3dInit();
}
/// ditto
void glfw3dInit() {
	if(!glfwInit()) {
		glfw3dTerminate();
		throw new glfw3dException("GLFW initialization failed");
	} else {
		glfwSetErrorCallback(&glfw3dErrorCallback);
	}
}

