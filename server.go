package main

import (
	"net/http"
	"github.com/labstack/echo/v4"
)

// custom context struct
type CustomContext struct {
    echo.Context
}

// main function of the server
func main() {
    e := echo.New()
	e.GET("/", startPage)
	e.Logger.Fatal(e.Start(":8000"))
}

// For now serve up individual files until we need to implement
// client-side routing as well

// startPage handler
func startPage(c echo.Context) error {

    return c.String(http.StatusOK, "Hello World")
    //e.File("/", "frontend/index.html")
}
