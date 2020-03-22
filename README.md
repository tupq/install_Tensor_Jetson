# installTensorFlowTX2
March 20, 2019
Inferrenced from JetsonHacks

Install TensorFlow v1.13.1 on NVIDIA Jetson TX2 Development Kit

Jetson TX2 is flashed with JetPack 4.3 which installs:
* L4T an Ubuntu 18.04 64-bit variant (aarch64)
* CUDA 10.0
* cuDNN 7.6.3

### Pre-built installation

### Preparation
Before installing TensorFlow, a swap file should be created (minimum of 8GB recommended). The Jetson TX2 does not have enough physical memory to compile TensorFlow. The swap file may be located on the internal eMMC, and may be removed after the build.

There is a convenience script for building a swap file. To build a 8GB swapfile on the eMMC in the home directory:

$ ./createSwapfile.sh -d ~/ -s 8

After TensorFlow has finished building, the swap file is no longer needed and may be removed.

TensorFlow should be built in the following order:


## For Python 3.7

#### installPrerequisitesPy3.sh
Installs Java and other dependencies needed. Also builds Bazel version 0.19.2.

#### cloneTensorFlow.sh
Git clones v1.13.1 from the TensorFlow repository 

#### setTensorFlowEVPy3.sh
Sets up the TensorFlow environment variables. This script will ask for the default python library path. There are many settings to chose from, the script picks the usual suspects. Uses python 3.5.

## Build TensorFlow
Once the prerequisites have been installed and the environment configured, it is time to build TensorFlow itself.

# fix tensor issue for AARCH64 architecture

- In ./third_party/gpus/crosstool/BUILD.tpl, changed

	<code>
	   cc_toolchain_suite(
			name = "toolchain",
			toolchains = {
				...
			},)
	</code>
	
to: 

    <code>
	   name = "toolchain",
			toolchains = {
				...
				"aarch64": ":cc-compiler-local",
			},
	</code>
	
- In ./third_party/aws/BUILD.bazel, changed

    <code>
		cc_library(
			name = "aws",
			srcs = select({
				...
				"//conditions:default": [],
	</code>
	
to:

    <code>
		cc_library(
			name = "aws",
			srcs = select({
				...
				"//conditions:default": glob([
					"aws-cpp-sdk-core/source/platform/linux-shared/*.cpp",
				]),
	</code>

- In ./third_party/nccl/build_defs.bzl.tpl, changed

	<code>
		maxrregcount = "-maxrregcount=96"
	</code>
	
to:

	<code>
		maxrregcount = "-maxrregcount=80"
	</code>

#### buildTensorFlow.sh
Builds TensorFlow.

#### packageTensorFlow.sh
Once TensorFlow has finished building, this script may be used to create a 'wheel' file, a package for installing with Python. The wheel file will be in the $HOME directory.

#### Install wheel file

For Python 3.X

$ pip3 install $HOME/<em>wheel file</em> 


### Notes
This TensorFlow installation procedure was derived from these discussion threads: 

<ul>
<li>https://github.com/tensorflow/tensorflow/issues/851</li>
<li>http://stackoverflow.com/questions/39783919/tensorflow-on-nvidia-tx1/</li>
<li>https://devtalk.nvidia.com/default/topic/1000717/tensorflow-on-jetson-tx2/</li>
<li>https://github.com/tensorflow/tensorflow/issues/9697</li>
</ul>



#### Remove swap file

swapoff ~/swapfile

swapoff -a

rm ~/swapfile


