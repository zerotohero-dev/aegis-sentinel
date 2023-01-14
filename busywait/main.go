/*
 * .-'_.---._'-.
 * ||####|(__)||   Protect your secrets, protect your business.
 *   \\()|##//       Secure your sensitive data with Aegis.
 *    \\ |#//                  <aegis.z2h.dev>
 *     .\_/.
 */

package main

import (
	"os"
	"os/signal"
	"syscall"
)

func main() {
	// Block the process from exiting, but also be graceful and honor the
	// termination signals that may come from the orchestrator.
	s := make(chan os.Signal, 1)
	signal.Notify(s, syscall.SIGINT, syscall.SIGTERM)
	select {}
}
