import std.stdio;
import glfw3d.Main;
import glfw3d.Monitor;

void main() {
	glfw3dInit();

	Monitor[] m = getMonitors();
	writefln("%d monitor(s) found", m.length);
	writeln("=====================");
	for(size_t i = 0; i < m.length; i++) {
		writefln("Name: %s", m[i].getName());
		MonitorSize msize = m[i].getSize();
		writefln("Size: %d x %d", msize.widthMM, msize.heightMM);
		MonitorPosition mpos = m[i].getPosition();
		writefln("Position:\n\tX: %d\n\tY: %d", mpos.x, mpos.y);

		VideoMode vm = m[i].getVideoMode();
		writefln("Current video mode:\n" ~
			"\tSize: %d x %d\n" ~
			"\tBit depth:\tR: %d G: %d B: %d\n" ~
			"\tRefresh rate: %d Hz",
				vm.width,
				vm.height,
				vm.redBits,
				vm.greenBits,
				vm.blueBits,
				vm.refreshRate);
		VideoMode[] vms = m[i].getAllVideoModes();
		writefln("%d more video modes found:", vms.length);
		writeln("-----");
		for(size_t k = 0; k < vms.length; k++) {
			writefln("#%d\n" ~
			"\tSize: %d x %d\n" ~
			"\tBit depth:\tR: %d G: %d B: %d\n" ~
			"\tRefresh rate: %d Hz",
				k,
				vms[k].width,
				vms[k].height,
				vms[k].redBits,
				vms[k].greenBits,
				vms[k].blueBits,
				vms[k].refreshRate);
			writeln("-----");
		}
		writeln("=====================");
	}

	glfw3dTerminate();
}

