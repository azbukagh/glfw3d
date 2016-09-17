/**
*	Joysticks, keyboard and mouse.
*/
module glfw3d.Input;

import glfw3d.glfw3;
import glfw3d.Main;
import std.string : fromStringz;

/**
*	Params:
*		key = GLFW_KEY_*
*		scancode = platform-specific scancode
*	Returns: localized name of the specified printable key
*/
string glfw3dGetKeyName(int key, int scancode) {
	return glfwGetKeyName(key, scancode).fromStringz.idup;
}

/**
*	Main joystick class
*/
class Joystick {
	private int joy;

	/**
	*	Params:
	*		j = GLFW_JOYSTICK_*
	*/
	this(int j) {
		this.joy = j;
	}

	/**
	*	Returns: true if current joystick is present
	*/
	bool isPresent() {
		if(glfwJoystickPresent(this.joy) == GLFW_TRUE) {
			return true;
		} else {
			return false;
		}
	}

	/**
	*	Returns: axes of current joystick
	*/
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

	/**
	*	Returns: buttons of current joystick
	*/
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

	/**
	*	Returns: name of curent joystick
	*/
	string getName() {
		return glfwGetJoystickName(this.joy).fromStringz.idup;
	}
}

