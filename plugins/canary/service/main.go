package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
)

func main() {
	serviceName := os.Getenv("SERVICE_NAME")
	host := os.Getenv("HOST")

	if serviceName == "" || host == "" {
	    panic("SERVICE_NAME and HOST cannot be empty")
	}

	http.HandleFunc("/", func(w http.ResponseWriter, req *http.Request) {
		body, _ := io.ReadAll(req.Body)
		fmt.Fprintf(w, "from service %s and the request host is %s and param is %s and body is %s", serviceName, req.Host, req.URL.Query(), string(body))
	})
	fmt.Printf("service %s start on %s\n", serviceName, host)
	if err := http.ListenAndServe(host, nil); err != nil {
		panic(err)
	}
}
