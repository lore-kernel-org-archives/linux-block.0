Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38297 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964849AbeFYSZN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jun 2018 14:25:13 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so6433267pgf.5
        for <linux-block@vger.kernel.org>; Mon, 25 Jun 2018 11:25:12 -0700 (PDT)
Date: Mon, 25 Jun 2018 11:25:10 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] check: add command line switch to test device
 drivers only
Message-ID: <20180625182510.GA11014@vader>
References: <20180612095706.4831-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180612095706.4831-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 12, 2018 at 11:57:06AM +0200, Johannes Thumshirn wrote:
> Sometimes it's useful to only run tests which exercise a device
> special driver to verify a patch for the driver doesn't introduce a
> regression.
> 
> Running the whole test-suite is just a waste of time in this case, so
> provide a way to only run tests which have a test_device() function
> set and not a test() function.

Thanks, applied with a few fixes mentioned below.

> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  check | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/check b/check
> index 4baa8dde2436..639fcc43f09d 100755
> --- a/check
> +++ b/check
> @@ -395,6 +395,12 @@ _run_test() {
>  	. "tests/${TEST_NAME}"
>  
>  	if declare -fF test >/dev/null; then
> +		if [[ -v DEVICE_ONLY ]]; then
> +			SKIP_REASON="test excluded by user"
> +			_output_notrun "$TEST_NAME"
> +			return 0
> +		fi
> +

This should go in _found_test() where we do the -q skipping, too.

>  		if declare -fF requires >/dev/null && ! requires; then
>  			_output_notrun "$TEST_NAME"
>  			return 0
> @@ -546,6 +552,9 @@ Test runs:
>    -x, --exclude=TEST     exclude a test (or test group) from the list of
>  			 tests to run
>  
> +  -d --device-only       only run test which use a test device from the
> +                         TEST_DEV config setting
> +
>  Miscellaneous:
>    -h, --help             display this help message and exit"
>  
> @@ -570,6 +579,7 @@ unset TEMP
>  
>  # Default configuration.
>  QUICK_RUN=0
> +DEVICE_ONLY=0
>  EXCLUDE=()
>  TEST_DEVS=()
>  
> @@ -592,6 +602,10 @@ while true; do
>  			EXCLUDE+=("$2")
>  			shift 2
>  			;;
> +		'-d'|'--device-only')
> +			DEVICE_ONLY=1
> +			shift 2

This doesn't take an argument, so it's just shift, not shift 2.

> +			;;

This needs a matching "d" added to the getopt call.

>  		'-h'|'--help')
>  			usage out
>  			;;
> @@ -609,6 +623,10 @@ if [[ QUICK_RUN -ne 0 && ! -v TIMEOUT ]]; then
>  	_error "QUICK_RUN specified without TIMEOUT"
>  fi
>  
> +if [[ DEVICE_ONLY -ne 0 && ${#TEST_DEVS[@]} -eq 0 ]]; then

This should be $DEVICE_ONLY. Looks like I made the same mistake above
with $QUICK_RUN ;)

> +	_error "DEVICE_ONLY specified without TEST_DEVS"
> +fi
> +
>  # Convert the exclude list to an associative array.
>  TEMP_EXCLUDE=("${EXCLUDE[@]}")
>  unset EXCLUDE
> -- 
> 2.16.4
> 
