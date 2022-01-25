#!/bin/bash

cat << EOF
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
[$(date +"%Y-%m-%d %T")]: Starting execution.
EOF

echo "Output of \`uname -a\` for the node:"
echo "$(uname -a)"
echo "[$(date +"%Y-%m-%d %T")]: Running systemtap script..."
stap -g /root/ipv4-ipstats-mib-inhdrerrors.stap
echo "[$(date +"%Y-%m-%d %T")]: Execution stopped for systemtap script, exiting."
