module glfwd.Main;

import std.experimental.logger;
import glfwd.glfw3;
__gshared Logger glfwdLog;

alias glfwdTerminate = glfwTerminate;

shared static this() {
	glfwdLog = sharedLog;
}

class glfwdException : Exception {
	pure nothrow @nogc @safe this(string msg,
		string file = __FILE__,
		size_t line = __LINE__,
		Throwable next = null) {
			super(msg, file, line, next);
	}
}

int[3] glfwVersion() {
	int major, minor, rev;
	glfwGetVersion(&major, &minor, &rev);
	return [major, minor, rev];
}

string glfwVersionString() {
	import std.string : fromStringz;
	return cast(string) glfwGetVersionString().fromStringz;
}

private template Error(string e) {
	const char[] Error = 
	"case GLFW_" ~ e ~ ":"
	~" try {glfwdLog.log(\"GLFW error: \", desc);} catch {} break;";
}

extern(C) nothrow void glfwdErrorCallback(int error, const(char)* desc) {
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
			try {log("GLFW error: unknown");} catch {}
			break;
	}
}

void glfwdInit(Logger l) {
	glfwdLog = l;
	glfwdInit();
}

void glfwdInit() {
	if(!glfwInit()) {
		glfwdTerminate();
		throw new glfwdException("GLFW initialization failed");
	} else {
		glfwSetErrorCallback(&glfwdErrorCallback);
	}
}

