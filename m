Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH] blktests: Add '--outdir' to store results in a different directory
Date: Tue, 17 Jul 2018 15:27:50 +0200
Message-Id: <20180717132750.38767-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Adding an option '--outdir' to store results in a different
director so as not to clutter the git repository itself.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 check | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/check b/check
index a635531..42d07f8 100755
--- a/check
+++ b/check
@@ -334,7 +334,7 @@ _call_test() {
 	fi
 
 	trap _cleanup EXIT
-	if ! TMPDIR="$(mktemp --tmpdir -p "$PWD/results" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
+	if ! TMPDIR="$(mktemp --tmpdir -p "$RESULTS_DIR" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
 		return
 	fi
 
@@ -415,7 +415,7 @@ _run_test() {
 			return 0
 		fi
 
-		RESULTS_DIR="results/nodev"
+		RESULTS_DIR="${OUT_DIR}/results/nodev"
 		_call_test test
 	else
 		if [[ ${#TEST_DEVS[@]} -eq 0 ]]; then
@@ -434,7 +434,7 @@ _run_test() {
 				_output_notrun "$TEST_NAME => $(basename "$TEST_DEV")"
 				continue
 			fi
-			RESULTS_DIR="results/$(basename "$TEST_DEV")"
+			RESULTS_DIR="${OUT_DIR}/results/$(basename "$TEST_DEV")"
 			if ! _call_test test_device; then
 				ret=1
 			fi
@@ -567,6 +567,7 @@ Test runs:
 			 tests to run
 
 Miscellaneous:
+  -o, --outdir=OUTDIR    write results into the specified directory
   -h, --help             display this help message and exit"
 
 	case "$1" in
@@ -581,12 +582,13 @@ Miscellaneous:
 	esac
 }
 
-if ! TEMP=$(getopt -o 'dq::x:h' --long 'quick::,exclude:,help' -n "$0" -- "$@"); then
+if ! TEMP=$(getopt -o 'dq::o:x:h' --long 'quick::,exclude:,outdir:,help' -n "$0" -- "$@"); then
 	exit 1
 fi
 
 eval set -- "$TEMP"
 unset TEMP
+OUT_DIR="."
 
 if [[ -r config ]]; then
 	# shellcheck disable=SC1091
@@ -629,6 +631,10 @@ while true; do
 			EXCLUDE+=("$2")
 			shift 2
 			;;
+		'-o'|'--outdir')
+			OUT_DIR="${2:-${OUT_DIR:-.}}"
+			shift 2
+			;;
 		'-h'|'--help')
 			usage out
 			;;
-- 
2.12.3
