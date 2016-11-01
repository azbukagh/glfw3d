import std.stdio;
import glfw3d.Main;
import glfw3d.glfw3.type;

void main() {
	writefln("Compiled against GLFW %d.%d.%d",
		GLFW_VERSION_MAJOR,
		GLFW_VERSION_MINOR,
		GLFW_VERSION_REVISION);
	writefln("Running against GLFW %(%d.%)", glfw3dVersion());
	writefln("Version string: %s", glfw3dVersionString());
}
