package main

import (
	"crypto/sha1"
	"fmt"
	"io"
	"strings"
)

func main() {
	for i := 0; i < 1000000000; i++ {
		h := sha1.New()
		io.WriteString(h, fmt.Sprintf("example+%d@example.com", i))
		if strings.HasPrefix(fmt.Sprintf("%x", h.Sum(nil)), "c0ffee") {
			fmt.Printf("example+%d@example.com\n", i)
			break
		}
	}
}
