module glfw3d.Monitor;

import glfw3d.glfw3;
import glfw3d.Main;
import std.string : fromStringz;

struct MonitorPosition {
	int x, y;
}

struct MonitorSize {
	int widthMM, heightMM;
}

struct VideoMode {
	int width;
	int height;
	int redBits;
	int greenBits;
	int blueBits;
	int refreshRate;
}

struct GammaRamp {
	ushort* red;
	ushort* green;
	ushort* blue;
	uint size;
}

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

class Monitor {
	private {
		GLFWmonitor* monitor;
	}

	GLFWmonitor* ptr() {
		return this.monitor;
	}

	this() {
		this(glfwGetPrimaryMonitor());
	}

	this(GLFWmonitor* m) {
		this.monitor = m;
	}

	MonitorPosition getPosition() {
		int x, y;
		glfwGetMonitorPos(this.monitor, &x, &y);
		return MonitorPosition(x, y);
	}

	MonitorSize getSize() {
		int w, h;
		glfwGetMonitorPhysicalSize(this.monitor, &w, &h);
		return MonitorSize(w, h);
	}

	string getName() {
		return glfwGetMonitorName(this.monitor).fromStringz.idup;
	}

	GLFWmonitorfun setCallback(GLFWmonitorfun cb) {
		return glfwSetMonitorCallback(cb);
	}

	VideoMode getVideoMode() {
		return cast(VideoMode) glfwGetVideoMode(this.monitor)[0];
	}

	VideoMode[] getAllVideoModes() {
		int k;
		const(GLFWvidmode)* output = glfwGetVideoModes(this.monitor, &k);
		if(!output || k == 0)
			throw new glfw3dException("Cannot read vide modes");
		VideoMode[] o;
		for(int i; i < k; i++)
			o ~= cast(VideoMode) output[i];
		return o;
	}

	
}

