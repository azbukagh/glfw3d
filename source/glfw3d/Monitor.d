/**
*	Monitors.
*/
module glfw3d.Monitor;

import glfw3d.glfw3;
import glfw3d.Main;
import std.string : fromStringz;

/**
*	Utility structs.
*/
struct MonitorPosition {
	int x, y;
}
/// ditto
struct MonitorSize {
	int widthMM, heightMM;
}
/// ditto
struct VideoMode {
	int width;
	int height;
	int redBits;
	int greenBits;
	int blueBits;
	int refreshRate;
}
/// ditto
struct GammaRamp {
	ushort* red;
	ushort* green;
	ushort* blue;
	uint size;
}

/**
*	Returns: All aviable monitors.
*/
Monitor[] glfw3dGetMonitors() {
	int k;
	GLFWmonitor** output = glfwGetMonitors(&k);
	if(!output || k == 0)
		throw new glfw3dException("No monitors found");
	Monitor[] o;
	for(int i; i < k; i++)
		o ~= new Monitor(output[i]);
	return o;
}

/**
*	Represents GLFWmonitor struct.
*/
class Monitor {
	private {
		GLFWmonitor* monitor;
	}

	/**
	*	It can be used to direct access to glfw3 functions.
	*	Returns: pointer to GLFWmonitor
	*/
	GLFWmonitor* ptr() {
		return this.monitor;
	}

	/**
	*	Primary monitor
	*/
	this() {
		this(glfwGetPrimaryMonitor());
	}

	this(GLFWmonitor* m) {
		this.monitor = m;
	}

	/**
	*	Returns: position of the monitor
	*/
	MonitorPosition getPosition() {
		int x, y;
		glfwGetMonitorPos(this.monitor, &x, &y);
		return MonitorPosition(x, y);
	}

	/**
	*	Returns: physical size of the monitor
	*/
	MonitorSize getSize() {
		int w, h;
		glfwGetMonitorPhysicalSize(this.monitor, &w, &h);
		return MonitorSize(w, h);
	}

	/**
	*	Returns: name of the monitor
	*/
	string getName() {
		return glfwGetMonitorName(this.monitor).fromStringz.idup;
	}

	/**
	*	Returns: current videomode of the monitor
	*/
	VideoMode getVideoMode() {
		return cast(VideoMode) glfwGetVideoMode(this.monitor)[0];
	}

	/**
	*	Returns: all aviable videomodes for monitor
	*/
	VideoMode[] getAllVideoModes() {
		int k;
		const(GLFWvidmode)* output = glfwGetVideoModes(this.monitor, &k);
		if(!output || k == 0)
			throw new glfw3dException("Cannot read video modes");
		VideoMode[] o;
		for(int i; i < k; i++)
			o ~= cast(VideoMode) output[i];
		return o;
	}
}

