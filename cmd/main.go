/*
 * .-'_.---._'-.
 * ||####|(__)||   Protect your secrets, protect your business.
 *   \\()|##//       Secure your sensitive data with Aegis.
 *    \\ |#//                  <aegis.z2h.dev>
 *     .\_/.
 */

package main

import (
	"fmt"
	"github.com/akamensky/argparse"
	"os"
)

func main() {
	parser := argparse.NewParser(
		"aegis",
		"Assigns secrets to workloads.",
	)

	list := parser.Flag(
		"l", "list",
		&argparse.Options{
			Required: false,
			Help:     "lists all registered workloads.",
		},
	)

	workload := parser.String(
		"w", "workload",
		&argparse.Options{
			Required: true,
			Help:     "name of the workload (i.e. the '$name' segment of its ClusterSPIFFEID ('spiffe://trustDomain/workload/$name/…'))",
		},
	)

	secret := parser.String(
		"s", "secret",
		&argparse.Options{
			Required: true,
			Help:     "the secret to store for the workload",
		},
	)

	err := parser.Parse(os.Args)
	if err != nil {
		fmt.Print(parser.Usage(err))
	}

	if list != nil && *list == true {
		get()
		return
	}

	if workload == nil || *workload == "" {
		fmt.Println("Please provide a workload name.")
		fmt.Println("")
		fmt.Println("type `aegis -h` (without backticks) and press return for help.")
		fmt.Println("")
		return
	}

	if secret == nil || *secret == "" {
		fmt.Println("Please provide a secret.")
		fmt.Println("")
		fmt.Println("type `aegis -h` (without backticks) and press return for help.")
		fmt.Println("")
		return
	}

	post(*workload, *secret)
}
