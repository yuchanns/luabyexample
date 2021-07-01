package main

import (
	"fmt"
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
		fmt.Fprintf(w, "from service %s", serviceName)
	})
	fmt.Printf("service %s start on %s\n", serviceName, host)
	if err := http.ListenAndServe(host, nil); err != nil {
		panic(err)
	}
}
