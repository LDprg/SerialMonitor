workspace "SerialMonitor"
	architecture "x64"
	startproject "SerialMonitor"

	configurations{
		"Debug",
		"Release"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "%{wks.location}/glfw/include"
IncludeDir["Glad"] = "%{wks.location}/Glad/include"
IncludeDir["ImGui"] = "%{wks.location}/imgui"
IncludeDir["ImPlot"] = "%{wks.location}/implot"

include "glfw"
include "Glad"
include "imgui"

project "SerialMonitor"
	location "SerialMonitor"

	language "C++"

	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	files{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.hpp",
		"%{prj.name}/src/**.cpp",
		"%{IncludeDir.ImPlot}/**.cpp"
	}

	includedirs{
		"%{prj.name}/src",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.ImPlot}",
		"%{IncludeDir.Glad}"
	}

	links{
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "on"
		systemversion "latest"

	filter "configurations:Debug"
		kind "ConsoleApp"
		defines "DEBUG"
		runtime "Debug"
		buildoptions "/MDd"
		symbols "on"

	filter "configurations:Release"
		kind "WindowedApp"
		defines "RELEASE"
		runtime "Release"
		buildoptions "/MD"
		optimize "on"