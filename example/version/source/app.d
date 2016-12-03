import std.stdio;
import glfw3d;

void main() {
	writefln("Compiled against GLFW %d.%d.%d",
		GLFW_VERSION_MAJOR,
		GLFW_VERSION_MINOR,
		GLFW_VERSION_REVISION);
	writefln("Running against GLFW %(%d.%)", glfw3dVersion());
	writefln("Version string: %s", glfw3dVersionString());
}
