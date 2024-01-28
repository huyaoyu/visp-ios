# visp-iso #
Pre-build VISP for iOS.

# Build the xcframework locally #

This is done on a M3 computer with macOS 14 with Xcode 15. The architechture of the iOS and
simulator will both be `arm64`.

## Get the source code ##

Make a root folder

```bash
mkdir visp-local
cd visp-local
```

Get the source code and checkout to the specific version. v3.6.0 is used at the moment.

```bash
git clone https://github.com/lagadic/visp.git
cd visp
git checkout v3.6.0
```

## Build for iOS ##

```bash
cd ..
mkdir build_ios
cd build_ios
python3 ../visp/platforms/ios/build_framework.py \
. \
--iphoneos_archs=arm64 \
--iphoneos_deployment_target=17 \
--disable-bitcode \
--build_only_specified_archs
```

The above command will generate a folder under `build_ios` with the name `visp3.framework`. 

## Build for simulator ##

```bash
cd ..
mkdir build_simulator
cd build_simulator
python3 ../visp/platforms/ios/build_framework.py \
. \
--iphonesimulator_archs=arm64 \
--iphoneos_deployment_target=17 \
--disable-bitcode \
--build_only_specified_archs
```

Similarly, the above command generates a `visp3.framework` folder under the `build_simulator`
folder.

## Create the xcframework ##

```bash
cd ..
xcodebuild -create-xcframework \
-framework build_ios/visp3.framework/ \
-framework build_simulator/visp3.framework \
-output "visp3.xcframework"
```

The above command generates the `visp3.xcframework` file. Use macOS to create a `.zip` file.

# Create GitHub Release #

Currently use manual releases.

First, do all the updates, including Package.swift file. Specify the URL in Pakcage.swfit without
creating the actual release. Copy the `visp3.xcframework.zip` file to the repo folder. Use the
following command to calculate the checksum.

```bash
shasum -a 256 visp3.xcframework.zip
```

Past the checksum to Package.swfit.

Edit the README if needed. Then make a commit and push to the `main` branch.

Then do the following

```bash
gh release create v3.6.0 --notes "Pre-build of VISP 3.6.0." visp3.xcframework.zip
```

The above command creates a new release and add a `v3.6.0` tag to the GitHub repo.
