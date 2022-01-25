# ocp-4-7-31-ipv4-ipstats-mib-inhdrerrors
DaemonSet and Container Image to monitor IPv4 InHdrErrors on an OCP 4.7.31 cluster.

This is intended to be run *only* on a Red Hat OpenShift 4.7.31 cluster running kernel version 4.18.0-305.19.1.el8_4.x86_64.  Running it on other versions may vary results or have unforseen consequences.

## Disclaimer
THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Usage
- Verify that your cluster is running Red Hat OpenShift 4.7.31 like so:
```
$ oc get clusterversion 
NAME      VERSION   AVAILABLE   PROGRESSING   SINCE   STATUS
version   4.7.31    True        False         58s     Cluster version is 4.7.31
```

- Verify a node's kernel version by logging into a node and running `uname`, like so:
```
$ oc debug node/worker-0.example.redhat.com
Starting pod/worker-0exampleredhatcom-debug ...
To use host binaries, run `chroot /host`

Pod IP: 10.0.91.161
If you don't see a command prompt, try pressing enter.

sh-4.4# uname -r
4.18.0-305.19.1.el8_4.x86_64
```

- To deploy the DaemonSet on the cluster, run the following command from an administrative user:
```
$ oc create -f daemonset.yaml
daemonset.apps/ocp-4-7-31-ipv4-ipstats-mib-inhdrerrors created

$ oc get ds
NAME                                      DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR      AGE
ocp-4-7-31-ipv4-ipstats-mib-inhdrerrors   0         0         0       0            0           inhdrerrors=true   6s 
```

- You must choose specific nodes to deploy the DaemonSet's pods on; to do so, label the node with the `inhdrerrors=true` tag:
```
$ oc label node worker-0.example.redhat.com inhdrerrors=true
node/worker-0.example.redhat.com labeled
```

- You should now be able to observe the new pod and retrieve logs from the systemtap script:
```
$ oc get pods
NAME                                            READY   STATUS    RESTARTS   AGE
ocp-4-7-31-ipv4-ipstats-mib-inhdrerrors-l96fs   1/1     Running   0          5s

$ oc logs ocp-4-7-31-ipv4-ipstats-mib-inhdrerrors-l96fs
ocp-4-7-31-ipv4-ipstats-mib-inhdrerrors
--------------------------------------
Systemtap toolbox container for observing IPv4 InHdrErrors on OCP 4.7.31.

This systemtap container is *specifically* designed to only work on a 
Red Hat OpenShift 4.7.31 node that is running on kernel 4.18.0-305.19.1.el8_4.x86_64.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
OR OTHER DEALINGS IN THE SOFTWARE.
============================================
[2022-01-25 16:15:51]: Starting execution.
Output of `uname -a` for the node:
Linux ocp-4-7-31-ipv4-ipstats-mib-inhdrerrors-l96fs 4.18.0-305.19.1.el8_4.x86_64 #1 SMP Tue Sep 7 07:07:31 EDT 2021 x86_64 x86_64 x86_64 GNU/Linux
[2022-01-25 16:15:51]: Running systemtap script...
```

## Image Building Instructions
The container image is already built and available at `quay.io/robbmanes/`.  You can likely skip this set of instructions.

If you wish to build it yourself, on a subscribed Red Hat Enterprise Linux system, run the following with the `buildah` utility (replacing the image tag with your desired tag):
```
$ buildah bud -t quay.io/robbmanes/ocp-4-7-31-ipv4-ipstats-mib-inhdrerrors:latest .
```
