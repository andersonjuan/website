package main

import (
    "fmt"
    "path/filepath"
	"net/http"
    "io/ioutil"
	"github.com/labstack/echo/v4"
)
// HTTP/2 server for the website

const (
    blogType string = "blog"
)

// jsonFile holds markdown text from a blog or anything else
type jsonFile {
    text string
}

// main function of the server
func main() {
	// instantiate the new server
    e := echo.New()

	// create a route for static content
    e.Static("/", "static")

	// serve up the start page for root
	e.GET("/", startPage)

    // serves up blog pages
    e.GET("/blog/:post", blog)

	e.Logger.Fatal(e.StartTLS(":1323", "cert.pem", "key.pem"))
}

// startPage serves up the site's start page
func startPage(c echo.Context) error {
	pusher, ok := c.Response().Writer.(http.Pusher)
	if ok {
		if err = pusher.Push("/app.js", nil); err != nil {
			return err
		}
	}
	// serve up the compiled start page
	return c.File("index.html")
}

// Blog requests for serving up pages
func blog(c echo.Context) error {
    blogPost := c.Param("post")

    // search for the post
    file, err := search(blogPost, blogType)
    if err != nil {
        return err
    }

    // read in all
    bytes, err := ioutil.ReadFile(file)
    if err != nil {
        return fmt.Errorf("data corruption on file read ::  %v", err)
    }

    // wrap the file in a JSON
    json := &jsonFile {
        text: string(bytes)
    }

    // serve up the file
    return c.JSON(http.StatusOK, json)
}


// searches the server for the given file
// and returns the filepath to it if it exists
func search(filename string, type string) (string, error) {
    switch string {
    case blogType:
        path := filepath.Join("assets", "blog", filename)
        _, err := os.Stat(path)
        return path, err
    default:
        return "", fmt.Errorf("404: page not found")
    }
}
