package main

import (
	"net/http"
	"github.com/labstack/echo/v4"
)

// HTTP/2 server for the website

// main function of the server
func main() {
	// instantiate the new server
    e := echo.New()

	// create a route for static content
    e.Static("/", "static")

	// serve up the start page for root
	e.GET("/", startPage)

	e.Logger.Fatal(e.StartTLS(":1323", "cert.pem", "key.pem"))
}

// startPage serves up the site's start page
func startPage(c echo.Context) error {
	pusher, ok := c.Response().Writer.(http.Pusher)
	if ok {
		if err = pusher.Push("/app.css", nil); err != nil {
			return err
		}
		if err = pusher.Push("/app.js", nil); err != nil {
			return err
		}
		if err = pusher.Push("/echo.png", nil); err != nil {
			return err
		}
	}
	// serve up the compiled start page
	return c.File("index.html")
	})
}
