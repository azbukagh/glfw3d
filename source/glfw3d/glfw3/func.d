/**
*	GLFW3 functions.
*	See_Also:
*		$(LINK http://www.glfw.org/docs/latest/modules.html)
*/
module glfw3d.glfw3.func;

import glfw3d.glfw3.type;

version (Have_erupted) {
	import erupted : VkResult, VkInstance, VkPhysicalDevice, VkAllocationCallbacks, VkSurfaceKHR;

	version = GLFW3D_VULKAN;
}
else version (Have_derelict_vulkan) {
	import derelict.vulkan : VkResult, VkInstance, VkPhysicalDevice, VkAllocationCallbacks, VkSurfaceKHR;

	version = GLFW3D_VULKAN;
}
else version (Have_d_vulkan) {
	import dvulkan : VkResult, VkInstance, VkPhysicalDevice, VkAllocationCallbacks, VkSurfaceKHR;

	version = GLFW3D_VULKAN;
}

extern(C) nothrow {
	int glfwInit();
	void glfwTerminate();
	void glfwGetVersion(int* major, int* minor, int* rev);
	const(char)* glfwGetVersionString();
	GLFWerrorfun glfwSetErrorCallback(GLFWerrorfun cbfun);
	GLFWmonitor** glfwGetMonitors(int* count);
	GLFWmonitor* glfwGetPrimaryMonitor();
	void glfwGetMonitorPos(GLFWmonitor* monitor, int* xpos, int* ypos);
	void glfwGetMonitorPhysicalSize(GLFWmonitor* monitor,
		int* widthMM,
		int* heightMM);
	const(char)* glfwGetMonitorName(GLFWmonitor* monitor);
	GLFWmonitorfun glfwSetMonitorCallback(GLFWmonitorfun cbfun);
	const(GLFWvidmode)* glfwGetVideoModes(GLFWmonitor* monitor, int* count);
	const(GLFWvidmode)* glfwGetVideoMode(GLFWmonitor* monitor);
	void glfwSetGamma(GLFWmonitor* monitor, float gamma);
	const(GLFWgammaramp)* glfwGetGammaRamp(GLFWmonitor* monitor);
	void glfwSetGammaRamp(GLFWmonitor* monitor, const(GLFWgammaramp)* ramp);
	void glfwDefaultWindowHints();
	void glfwWindowHint(int hint, int value);
	GLFWwindow* glfwCreateWindow(int width,
		int height,
		const(char)* title,
		GLFWmonitor* monitor,
		GLFWwindow* share);
	void glfwDestroyWindow(GLFWwindow* window);
	int glfwWindowShouldClose(GLFWwindow* window);
	void glfwSetWindowShouldClose(GLFWwindow* window, int value);
	void glfwSetWindowTitle(GLFWwindow* window, const(char)* title);
	void glfwSetWindowIcon(GLFWwindow* window,
		int count,
		const(GLFWimage)* images);
	void glfwGetWindowPos(GLFWwindow* window, int* xpos, int* ypos);
	void glfwSetWindowPos(GLFWwindow* window, int xpos, int ypos);
	void glfwGetWindowSize(GLFWwindow* window, int* width, int* height);
	void glfwSetWindowSizeLimits(GLFWwindow* window,
		int minwidth,
		int minheight,
		int maxwidth,
		int maxheight);
	void glfwSetWindowAspectRatio(GLFWwindow* window, int numer, int denom);
	void glfwSetWindowSize(GLFWwindow* window, int width, int height);
	void glfwGetFramebufferSize(GLFWwindow* window,
		int* width,
		int* height);
	void glfwGetWindowFrameSize(GLFWwindow* window,
		int* left,
		int* top,
		int* right,
		int* bottom);
	void glfwIconifyWindow(GLFWwindow* window);
	void glfwRestoreWindow(GLFWwindow* window);
	void glfwMaximizeWindow(GLFWwindow* window);
	void glfwShowWindow(GLFWwindow* window);
	void glfwHideWindow(GLFWwindow* window);
	void glfwFocusWindow(GLFWwindow* window);
	GLFWmonitor* glfwGetWindowMonitor(GLFWwindow* window);
	void glfwSetWindowMonitor(GLFWwindow* window,
		GLFWmonitor* monitor,
		int xpos,
		int ypos,
		int width,
		int height,
		int refreshRate);
	int glfwGetWindowAttrib(GLFWwindow* window, int attrib);
	void glfwSetWindowUserPointer(GLFWwindow* window, void* pointer);
	void* glfwGetWindowUserPointer(GLFWwindow* window);
	GLFWwindowposfun glfwSetWindowPosCallback(GLFWwindow* window,
		GLFWwindowposfun cbfun);
	GLFWwindowsizefun glfwSetWindowSizeCallback(GLFWwindow* window,
		GLFWwindowsizefun cbfun);
	GLFWwindowclosefun glfwSetWindowCloseCallback(GLFWwindow* window,
		GLFWwindowclosefun cbfun);
	GLFWwindowrefreshfun glfwSetWindowRefreshCallback(GLFWwindow* window,
		GLFWwindowrefreshfun cbfun);
	GLFWwindowfocusfun glfwSetWindowFocusCallback(GLFWwindow* window,
		GLFWwindowfocusfun cbfun);
	GLFWwindowiconifyfun glfwSetWindowIconifyCallback(GLFWwindow* window,
		GLFWwindowiconifyfun cbfun);
	GLFWframebuffersizefun glfwSetFramebufferSizeCallback(GLFWwindow* window,
		GLFWframebuffersizefun cbfun);
	void glfwPollEvents();
	void glfwWaitEvents();
	void glfwWaitEventsTimeout(double timeout);
	void glfwPostEmptyEvent();
	int glfwGetInputMode(GLFWwindow* window, int mode);
	void glfwSetInputMode(GLFWwindow* window, int mode, int value);
	const(char)* glfwGetKeyName(int key, int scancode);
	int glfwGetKey(GLFWwindow* window, int key);
	int glfwGetMouseButton(GLFWwindow* window, int button);
	void glfwGetCursorPos(GLFWwindow* window, double* xpos, double* ypos);
	void glfwSetCursorPos(GLFWwindow* window, double xpos, double ypos);
	GLFWcursor* glfwCreateCursor(const(GLFWimage)* image,
		int xhot,
		int yhot);
	GLFWcursor* glfwCreateStandardCursor(int shape);
	void glfwDestroyCursor(GLFWcursor* cursor);
	void glfwSetCursor(GLFWwindow* window, GLFWcursor* cursor);
	GLFWkeyfun glfwSetKeyCallback(GLFWwindow* window, GLFWkeyfun cbfun);
	GLFWcharfun glfwSetCharCallback(GLFWwindow* window, GLFWcharfun cbfun);
	GLFWcharmodsfun glfwSetCharModsCallback(GLFWwindow* window,
		GLFWcharmodsfun cbfun);
	GLFWmousebuttonfun glfwSetMouseButtonCallback(GLFWwindow* window,
		GLFWmousebuttonfun cbfun);
	GLFWcursorposfun glfwSetCursorPosCallback(GLFWwindow* window,
		GLFWcursorposfun cbfun);
	GLFWcursorenterfun glfwSetCursorEnterCallback(GLFWwindow* window,
		GLFWcursorenterfun cbfun);
	GLFWscrollfun glfwSetScrollCallback(GLFWwindow* window,
		GLFWscrollfun cbfun);
	GLFWdropfun glfwSetDropCallback(GLFWwindow* window, GLFWdropfun cbfun);
	int glfwJoystickPresent(int joy);
	const(float)* glfwGetJoystickAxes(int joy, int* count);
	const(ubyte)* glfwGetJoystickButtons(int joy, int* count);
	const(char)* glfwGetJoystickName(int joy);
	GLFWjoystickfun glfwSetJoystickCallback(GLFWjoystickfun cbfun);
	void glfwSetClipboardString(GLFWwindow* window, const(char)* str);
	const(char)* glfwGetClipboardString(GLFWwindow* window);
	double glfwGetTime();
	void glfwSetTime(double time);
	long glfwGetTimerValue();
	long glfwGetTimerFrequency();
	void glfwMakeContextCurrent(GLFWwindow* window);
	GLFWwindow* glfwGetCurrentContext();
	void glfwSwapBuffers(GLFWwindow* window);
	void glfwSwapInterval(int interval);
	int glfwExtensionSupported(const(char)* extension);
	GLFWglproc glfwGetProcAddress(const(char)* procname);
	int glfwVulkanSupported();
	const(char*)* glfwGetRequiredInstanceExtensions(uint* count);
	version(GLFW3D_VULKAN) {
		GLFWvkproc glfwGetInstanceProcAddress(VkInstance instance,
			const(char)* procname);
		int glfwGetPhysicalDevicePresentationSupport(VkInstance instance,
			VkPhysicalDevice device,
			uint queuefamily);
		VkResult glfwCreateWindowSurface(VkInstance instance,
			GLFWwindow* window,
			const(VkAllocationCallbacks)* allocator,
			VkSurfaceKHR* surface);
	}
}

