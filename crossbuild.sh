#!/bin/bash -ex

git clone https://github.com/cosmos/cosmos-sdk -b ${VERSION}
cd cosmos-sdk

# Append crossbuild-cli target to Makefile
cat << "EOF" >> Makefile

crossbuild-cli: go.sum
	env GOOS=windows GOARCH=amd64 go build -mod=readonly $(BUILD_FLAGS) -o build/gaiacli-win.exe ./cmd/gaia/cmd/gaiacli
	env GOOS=linux GOARCH=amd64 go build -mod=readonly $(BUILD_FLAGS) -o build/gaiacli-linux ./cmd/gaia/cmd/gaiacli
	env GOOS=darwin GOARCH=amd64 go build -mod=readonly $(BUILD_FLAGS) -o build/gaiacli-darwin ./cmd/gaia/cmd/gaiacli
EOF

echo "*** Start of modified Makefile ***"
cat Makefile
echo "*** End of modified Makefile ***"

make crossbuild-cli