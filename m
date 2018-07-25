Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Wed, 25 Jul 2018 14:23:01 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] blktests: Add '--outdir' to store results in a different
 directory
Message-ID: <20180725212301.GC16847@vader>
References: <20180717132750.38767-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180717132750.38767-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 17, 2018 at 03:27:50PM +0200, Hannes Reinecke wrote:
> Adding an option '--outdir' to store results in a different
> director so as not to clutter the git repository itself.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  check | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/check b/check
> index a635531..42d07f8 100755
> --- a/check
> +++ b/check
> @@ -334,7 +334,7 @@ _call_test() {
>  	fi
>  
>  	trap _cleanup EXIT
> -	if ! TMPDIR="$(mktemp --tmpdir -p "$PWD/results" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
> +	if ! TMPDIR="$(mktemp --tmpdir -p "$RESULTS_DIR" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
>  		return
>  	fi
>  
> @@ -415,7 +415,7 @@ _run_test() {
>  			return 0
>  		fi
>  
> -		RESULTS_DIR="results/nodev"
> +		RESULTS_DIR="${OUT_DIR}/results/nodev"
>  		_call_test test
>  	else
>  		if [[ ${#TEST_DEVS[@]} -eq 0 ]]; then
> @@ -434,7 +434,7 @@ _run_test() {
>  				_output_notrun "$TEST_NAME => $(basename "$TEST_DEV")"
>  				continue
>  			fi
> -			RESULTS_DIR="results/$(basename "$TEST_DEV")"
> +			RESULTS_DIR="${OUT_DIR}/results/$(basename "$TEST_DEV")"
>  			if ! _call_test test_device; then
>  				ret=1
>  			fi
> @@ -567,6 +567,7 @@ Test runs:
>  			 tests to run
>  
>  Miscellaneous:
> +  -o, --outdir=OUTDIR    write results into the specified directory
>    -h, --help             display this help message and exit"
>  
>  	case "$1" in
> @@ -581,12 +582,13 @@ Miscellaneous:
>  	esac
>  }
>  
> -if ! TEMP=$(getopt -o 'dq::x:h' --long 'quick::,exclude:,help' -n "$0" -- "$@"); then
> +if ! TEMP=$(getopt -o 'dq::o:x:h' --long 'quick::,exclude:,outdir:,help' -n "$0" -- "$@"); then
>  	exit 1
>  fi
>  
>  eval set -- "$TEMP"
>  unset TEMP
> +OUT_DIR="."

This doesn't allow setting it from the config file. How about this?

diff --git a/check b/check
index 5f4461f..5e99415 100755
--- a/check
+++ b/check
@@ -313,7 +313,7 @@ _call_test() {
 	local test_func="$1"
 	local seqres="${RESULTS_DIR}/${TEST_NAME}"
 	# shellcheck disable=SC2034
-	FULL="$PWD/${seqres}.full"
+	FULL="${seqres}.full"
 	declare -A TEST_DEV_QUEUE_SAVED
 
 	_read_last_test_run
@@ -334,7 +334,7 @@ _call_test() {
 	fi
 
 	trap _cleanup EXIT
-	if ! TMPDIR="$(mktemp --tmpdir -p "$PWD/results" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
+	if ! TMPDIR="$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
 		return
 	fi
 
@@ -415,7 +415,7 @@ _run_test() {
 			return 0
 		fi
 
-		RESULTS_DIR="results/nodev"
+		RESULTS_DIR="$OUTPUT/nodev"
 		_call_test test
 	else
 		if [[ ${#TEST_DEVS[@]} -eq 0 ]]; then
@@ -434,7 +434,7 @@ _run_test() {
 				_output_notrun "$TEST_NAME => $(basename "$TEST_DEV")"
 				continue
 			fi
-			RESULTS_DIR="results/$(basename "$TEST_DEV")"
+			RESULTS_DIR="$OUTPUT/$(basename "$TEST_DEV")"
 			if ! _call_test test_device; then
 				ret=1
 			fi
@@ -559,6 +559,9 @@ Test runs:
   -d, --device-only	 only run tests which use a test device from the
 			 TEST_DEVS config setting
 
+  -o, --output=DIR	 output results to the given directory (the default is
+			 ./results)
+
   -q, --quick=SECONDS	 do a quick run (only run quick tests and limit the
 			 runtime of longer tests to the given timeout,
 			 defaulting to 30 seconds)
@@ -581,7 +584,7 @@ Miscellaneous:
 	esac
 }
 
-if ! TEMP=$(getopt -o 'dq::x:h' --long 'quick::,exclude:,help' -n "$0" -- "$@"); then
+if ! TEMP=$(getopt -o 'do:q::x:h' --long 'quick::,exclude:,output:,help' -n "$0" -- "$@"); then
 	exit 1
 fi
 
@@ -596,6 +599,7 @@ fi
 # Default configuration.
 : "${DEVICE_ONLY:=0}"
 : "${QUICK_RUN:=0}"
+: "${OUTPUT:=results}"
 if [[ -v EXCLUDE ]] && ! declare -p EXCLUDE | grep -q '^declare -a'; then
 	# If EXCLUDE was not defined as an array, convert it to one.
 	# shellcheck disable=SC2190,SC2206
@@ -617,6 +621,10 @@ while true; do
 			DEVICE_ONLY=1
 			shift
 			;;
+		'-o'|'--output')
+			OUTPUT="$2"
+			shift 2
+			;;
 		'-q'|'--quick')
 			QUICK_RUN=1
 			# Use the timeout specified on the command line, from
@@ -659,4 +667,7 @@ for filter in "${TEMP_EXCLUDE[@]}"; do
 done
 unset TEMP_EXCLUDE
 
+mkdir -p "$OUTPUT"
+OUTPUT="$(realpath "$OUTPUT")"
+
 _check "$@"
