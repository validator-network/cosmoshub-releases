#!/bin/bash -ex

git clone https://github.com/cosmos/cosmos-sdk -b ${VERSION}
cd cosmos-sdk

# Append crossbuild-cli target to Makefile
cat << "EOF" >> Makefile

crossbuild-cli: vendor-deps
	env GOOS=windows GOARCH=amd64 go build  $(BUILD_FLAGS) -o build/windows/amd64/gaiacli.exe ./cmd/gaia/cmd/gaiacli
	env GOOS=linux GOARCH=amd64 go build  $(BUILD_FLAGS) -o build/linux/amd64/gaiacli ./cmd/gaia/cmd/gaiacli
	env GOOS=darwin GOARCH=amd64 go build  $(BUILD_FLAGS) -o build/darwin/amd64/gaiacli ./cmd/gaia/cmd/gaiacli
EOF

echo *** Start of modified Makefile ***
cat Makefile
echo *** End of modified Makefile ***

make crossbuild-cli