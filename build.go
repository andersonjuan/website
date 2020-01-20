// mage
package build

import (
    "fmt"

    "github.com/magefile/mage/mg"
    "github.com/magefile/mage/sh"
)

const (
    buildDir string = ".prod"
)

// define a global build struct for the build file
var build buildEnv

// initializes the environment
func init() {
    build = newBuildEnv()
}

//
func Build() error {

}

//
func Deploy() error {

}

//
func Release() error {

}

// struct for holding the build information
type buildEnv struct {

}

// populate the build environment
func newBuildEnv() buildEnv {

}
