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
	"github.com/zerotohero/dev/aegis-sentinel/internal/safe"
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

	useKubernetes := parser.Flag(
		"k", "use-k8s",
		&argparse.Options{
			Required: false,
			Default:  false,
			Help:     "update an associated Kubernetes secret upon save",
		},
	)

	namespace := parser.String(
		"ns", "namespace",
		&argparse.Options{
			Required: false,
			Default:  "aegis-system",
			Help:     "the namespace of the Kubernetes Secret to create.",
		},
	)

	backingStore := parser.String(
		"b", "store",
		&argparse.Options{
			Required: false,
			Default:  "file",
			Help:     "backing store type (file|memory|cluster).",
		},
	)

	workload := parser.String(
		"w", "workload",
		&argparse.Options{
			Required: false,
			Help: "name of the workload (i.e. the '$name' segment of its " +
				"ClusterSPIFFEID ('spiffe://trustDomain/workload/$name/…'))",
		},
	)

	secret := parser.String(
		"s", "secret",
		&argparse.Options{
			Required: false,
			Help:     "the secret to store for the workload",
		},
	)

	err := parser.Parse(os.Args)
	if err != nil {
		fmt.Print(parser.Usage(err))
	}

	if list != nil && *list == true {
		safe.Get()
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

	if useKubernetes == nil || *useKubernetes == false {
		*namespace = "aegis-system"
	}

	safe.Post(*workload, *secret, *namespace, *backingStore, *useKubernetes)
}
