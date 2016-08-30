module glfw3d.Input;

import glfw3d.glfw3;
import glfw3d.Main;
import std.string : fromStringz;

string glfw3dGetKeyName(int key, int scancode) {
	return glfwGetKeyName(key, scancode).fromStringz.idup;
}

class Joystick {
	private int joy;

	this(int j) {
		this.joy = j;
	}

	bool isPresent() {
		if(glfwJoystickPresent(this.joy) == GLFW_TRUE) {
			return true;
		} else {
			return false;
		}
	}

	float[] getAxes() {
		int count;
		const(float)* o = glfwGetJoystickAxes(this.joy, &count);
		if(!o || count == 0)
			throw new glfw3dException("Cannot get joystick axes");
		float[] output;
		for(size_t i = 0; i < count; i++)
			output ~= o[i];
		return output;
	}

	ubyte[] getButtons() {
		int count;
		const(ubyte)* o = glfwGetJoystickButtons(this.joy, &count);
		if(!o || count == 0)
			throw new glfw3dException("Cannot get joystick buttons");
		ubyte[] output;
		for(size_t i = 0; i < count; i++)
			output ~= o[i];
		return output;
	}

	string getName() {
		return glfwGetJoystickName(this.joy).fromStringz.idup;
	}

	GLFWjoystickfun setCallback(GLFWjoystickfun cb) {
		return glfwSetJoystickCallback(cb);
	}
}

