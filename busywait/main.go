/*
 * .-'_.---._'-.
 * ||####|(__)||   Protect your secrets, protect your business.
 *   \\()|##//       Secure your sensitive data with Aegis.
 *    \\ |#//                  <aegis.z2h.dev>
 *     .\_/.
 */

package main

import "time"

func main() {
	// Keep me alive for ~200 years.
	time.Sleep(time.Duration(1<<63 - 1))

	// Or alternatively, this:
	// s := make(chan os.Signal, 1)
	// signal.Notify(s, syscall.SIGINT, syscall.SIGTERM)
	// select {}
}
