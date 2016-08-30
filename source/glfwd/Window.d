module glfwd.Window;

import glfwd.glfw3;
import glfwd.Main;
import glfwd.Monitor;

struct WindowPosition {
	int x, y;
}

struct WindowSize {
	int width, height;
}

struct FrameSize {
	int left, top, right, bottom;
}

class Window {
	private {
		GLFWwindow* window;
	}

	GLFWwindow* ptr() {
		return this.window;
	}

	~this() {
		this.destroy();
	}

	this(int width,
		int height,
		string title) {
			this(width,
				height,
				title,
				cast(GLFWmonitor*) null,
				cast(GLFWwindow*) null);
	}

	this(int width,
		int height,
		string title,
		glfwd.Monitor.Monitor mon) {
			this(width, height, title, mon.ptr, null);
	}

	this(int width,
		int height,
		string title,
		glfwd.Window.Window share) {
			this(width, height, title, null, share.ptr);
	}

	this(int width,
		int height,
		string title,
		glfwd.Monitor.Monitor mon,
		glfwd.Window.Window share) {
			this(width, height, title, mon.ptr, share.ptr);
	}

	this(int width,
		int height,
		string title, 
		GLFWmonitor* mon,
		GLFWwindow* share) {
			this.window = glfwCreateWindow(width,
				height,
				cast(const(char)*) title,
				mon,
				share);
			if(!this.window)
				throw new glfwdException("Window or OpenGL context creation failed");
	}

	void defaultHints() {
		glfwDefaultWindowHints();
	}

	void hint(int hint, int value) {
		glfwWindowHint(hint, value);
	}

	void destroy() {
		glfwDestroyWindow(this.window);
	}

	int shouldClose() {
		return glfwWindowShouldClose(this.window);
	}

	void setShouldClose(int v) {
		glfwSetWindowShouldClose(this.window, v);
	}

	void setTitle(string t) {
		glfwSetWindowTitle(this.window, cast(const(char)*) t);
	}

	void setIcon(int count, const(GLFWimage)* img) {
		glfwSetWindowIcon(this.window, count, img);
	}

	WindowPosition getPosition() {
		int x, y;
		glfwGetWindowPos(this.window, &x, &y);
		return WindowPosition(x, y);
	}

	void setPosition(WindowPosition w) {
		this.setPosition(w.x, w.y);
	}

	void setPosition(int x, int y) {
		glfwSetWindowPos(this.window, x, y);
	}

	WindowSize getSize() {
		int w, h;
		glfwGetWindowSize(this.window, &w, &h);
		return WindowSize(w, h);
	}

	void setSize(WindowSize w) {
		this.setSize(w.width, w.height);
	}

	void setSize(int width, int height) {
		glfwSetWindowSize(this.window, width, height);
	}

	void setSizeLimits(int minWidth,
		int minHeight,
		int maxWidth,
		int maxHeight) {
			glfwSetWindowSizeLimits(
				this.window,
				minWidth,
				minHeight,
				maxWidth,
				maxHeight
			);
	}

	void setAspectRation(int number, int denom) {
		glfwSetWindowAspectRatio(this.window, number, denom);
	}

	WindowSize getFramebufferSize() {
		int w, h;
		glfwGetFramebufferSize(this.window, &w, &h);
		return WindowSize(w, h);
	}

	FrameSize getFrameSize() {
		int l, t, r, b;
		glfwGetWindowFrameSize(this.window, &l, &t, &r, &b);
		return FrameSize(l, t, r, b);
	}

	void iconify() {
		glfwIconifyWindow(this.window);
	}

	void restore() {
		glfwRestoreWindow(this.window);
	}

	void maximize() {
		glfwMaximizeWindow(this.window);
	}

	void show() {
		glfwShowWindow(this.window);
	}

	void hide() {
		glfwHideWindow(this.window);
	}

	void focus() {
		glfwFocusWindow(this.window);
	}

	glfwd.Monitor.Monitor getMonitor() {
		return new glfwd.Monitor.Monitor(
			glfwGetWindowMonitor(this.window)
		);
	}

	void setMonitor(glfwd.Monitor.Monitor m,
		WindowPosition pos,
		WindowSize size,
		int refreshRate) {
			glfwSetWindowMonitor(
				this.window,
				m.ptr,
				pos.x,
				pos.y,
				size.width,
				size.height,
				refreshRate
			);
	}

	int getAttrib(int a) {
		return glfwGetWindowAttrib(this.window, a);
	}

	void setUserPointer(void* pointer) {
		glfwSetWindowUserPointer(this.window, pointer);
	}

	void* getUserPointer() {
		return glfwGetWindowUserPointer(this.window);
	}

	void swapBuffers() {
		glfwSwapBuffers(this.window);
	}

	GLFWwindowposfun setPositionCallback(GLFWwindowposfun cb) {
		return glfwSetWindowPosCallback(this.window, cb);
	}

	GLFWwindowsizefun setSizeCallback(GLFWwindowsizefun cb) {
		return glfwSetWindowSizeCallback(this.window, cb);
	}

	GLFWwindowclosefun setCloseCallback(GLFWwindowclosefun cb) {
		return glfwSetWindowCloseCallback(this.window, cb);
	}

	GLFWwindowrefreshfun setRefreshCallback(GLFWwindowrefreshfun cb) {
		return glfwSetWindowRefreshCallback(this.window, cb);
	}

	GLFWwindowfocusfun setFocusCallback(GLFWwindowfocusfun cb) {
		return glfwSetWindowFocusCallback(this.window, cb);
	}

	GLFWwindowiconifyfun setIconifyCallback(GLFWwindowiconifyfun cb) {
		return glfwSetWindowIconifyCallback(this.window, cb);
	}

	GLFWframebuffersizefun setFramebufferSizeCallback(
		GLFWframebuffersizefun cb
	) {
		return glfwSetFramebufferSizeCallback(this.window, cb);
	}
}

