Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC04C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 20:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D54D218A6
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 20:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="jVtKEtbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfAYU7q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:59:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39767 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYU7q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 15:59:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so5284934pfc.6
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 12:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AJvOjGgmniraSu9kJ4tUloMk8F3p7eABc7Nno2MLuWA=;
        b=jVtKEtbFsJjXtt/sZogYnbgux5Fhsqr7iPrYkLDHcOhMuAEtVfSDwgrY8w3vldTrUw
         gD9Vza32ywCc+XQmj3ge4FqXmgBkjAWn2feKpKxQ/s5K/b3CbPb3FqKKgCHEpQ2qKDv9
         LtuuHVsXByk18m/1pciwcAor/9AxJixXzTOhhZRvBVE6DU4WxN5B76BWQhedBn2tiNS1
         JTFQAEi+Q9PlZNZr58/xqCZ+njHnpeMj3glxSpsx4wt82T5SI9D+QAAkuUCsS9T6lE66
         PZFxrwBhG4Hujs7lYTx4uiUDlz8l1SO7gYnBAvxZVgwgF5t/JuNeB2zN8WjeG3o7e/jj
         ntzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AJvOjGgmniraSu9kJ4tUloMk8F3p7eABc7Nno2MLuWA=;
        b=qvMnePto2rfshASzQe2a0rpL/2MT8MW7JZH0XkR82AdgjbFPwC9dg+w32wE4i48fs1
         OhlOfbP/YqZw5gIRQdbCoveET4XCuJxHH4A5CVbft9glkiij7Ys2aCp2oGZ8R8L8/+Rg
         cTuIaZc64vJakM6pbES/EntCm20kQOqnpi0wvcWSTs/0fkt/bpnAtUw9iwg2WR2tznSD
         JMjNM1WWl5F3KdoERkRAtwsqJX0Rs4+T0Edgdv9gpBk4B/vTm0ck6gOQ6r/BPrOUco/S
         ESwg2divPeRXjjD0LOTggfHDyJzI+03xWZK5wPeCfF81F4VbTQwREwbkPGL52NnErQYy
         ppCQ==
X-Gm-Message-State: AJcUukf3d5R4tH1WkNRZP2Ruwi1sXs+RieMkNqXBMuUfLLtN5CWXD4Ix
        ZUC/1/LoL2Mz8YYS6HIZIJbEBw==
X-Google-Smtp-Source: ALg8bN4bocUSTi1yczcVOdtzGJKL30Yu9MfbIPVwx2L1r+mKdmIm/Ro2hnm2JCdjBHB13U1yxET5xw==
X-Received: by 2002:a63:61c1:: with SMTP id v184mr11433142pgb.54.1548449984691;
        Fri, 25 Jan 2019 12:59:44 -0800 (PST)
Received: from vader ([2620:10d:c090:200::6:f0e2])
        by smtp.gmail.com with ESMTPSA id p7sm37300152pfa.22.2019.01.25.12.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 12:59:44 -0800 (PST)
Date:   Fri, 25 Jan 2019 12:59:43 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v3 01/13] config: Introduce RUN_ZONED_TESTS
 variable and CAN_BE_ZONED flag
Message-ID: <20190125205943.GA26739@vader>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
 <20190118094453.13773-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118094453.13773-2-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 18, 2019 at 06:44:41PM +0900, Shin'ichiro Kawasaki wrote:
> To allow running tests using a null_blk device with the zoned mode
> disabled (current setup) as well as enabled, introduce the config
> the RUN_ZONED_TESTS config variable and the per-test flag CAN_BE_ZONED.
> 
> RUN_ZONED_TESTS=1 indicates that tests run against null_blk will be
> executed twice, first with null_blk as a regular block device
> (RUN_FOR_ZONED=0) and a second time with null_blk set as a zoned block
> device (RUN_FOR_ZONED=1). This applies only to tests cases that have the
> variable CAN_BE_ZONED set to 1, indicating that the test case applies to
> zoned block devices. If CAN_BE_ZONED is not defined by a test case, the
> test is executed only with the regular null_blk device.
> 
> _init_null_blk is modified to prepare null_blk as a zoned blocked device
> if RUN_FOR_ZONED is set and as a regular block device otherwise. To avoid
> "modprobe -r null_blk" failures, rmdir calls on all sysfs nullbX
> directories is added.
> 
> When a zoned block device is specified in TEST_DEVS, failures of test
> cases that do not set CAN_BE_ZONED are avoided by automatically skipping
> the test. The new helper function _test_dev_is_zoned() is introduced to
> implement this.
> 
> The use of the RUN_ZONED_TESTS variable requires that the kernel be
> compiled with CONFIG_BLK_DEV_ZONED enabled.

This is much better, thanks! Some comments below.

> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  Documentation/running-tests.md | 13 +++++++++++++
>  check                          | 29 ++++++++++++++++++++++++++---
>  common/null_blk                | 23 ++++++++++++++++++++++-
>  common/shellcheck              |  2 +-
>  new                            |  4 ++++
>  5 files changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
> index 8f32af3..459c96b 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -82,6 +82,19 @@ passing the `-d` command line option or setting the `DEVICE_ONLY` variable.
>  DEVICE_ONLY=1
>  ```
>  
> +### Zoned Block Device
> +
> +To run test cases for zoned block devices, set `RUN_ZONED_TESTS` variable.
> +When this variable is set and a test case can prepare a virtual devices such
> +as null_blk with zoned mode, the test case is executed twice: first with
> +non-zoned mode and second with zoned mode. The use of the RUN_ZONED_TESTS
> +variable requires that the kernel be compiled with CONFIG_BLK_DEV_ZONED
> +enabled.
> +

Minor proofreading:

To run test cases for zoned block devices, set the `RUN_ZONED_TESTS` variable.
When this variable is set and a test case can prepare a virtual device such as
`null_blk` with zoned mode, the test case is executed twice: first in non-zoned
mode and second in zoned mode. The use of the `RUN_ZONED_TESTS` variable
requires that the kernel be compiled with `CONFIG_BLK_DEV_ZONED` enabled.

> +```sh
> +RUN_ZONED_TESTS=1
> +```
> +
>  ### Custom Setup
>  
>  The `config` file is really just a bash file that is sourced at the beginning
> diff --git a/check b/check
> index 6c6d9f5..4563d62 100755
> --- a/check
> +++ b/check
> @@ -17,7 +17,7 @@ _found_test() {
>  	local test_name="$1"
>  	local explicit="$2"
>  
> -	unset DESCRIPTION QUICK TIMED requires device_requires test test_device
> +	unset DESCRIPTION QUICK TIMED CAN_BE_ZONED requires device_requires test test_device
>  
>  	# shellcheck disable=SC1090
>  	if ! . "tests/${test_name}"; then
> @@ -182,11 +182,14 @@ _write_test_run() {
>  _output_status() {
>  	local test="$1"
>  	local status="$2"
> +	local zoned=" "
> +
> +	if (( RUN_FOR_ZONED )); then zoned=" (zoned) "; fi
>  
>  	if [[ -v DESCRIPTION ]]; then
> -		printf '%-60s' "$test ($DESCRIPTION)"
> +		printf '%-60s' "${test}${zoned}($DESCRIPTION)"
>  	else
> -		printf '%-60s' "$test"
> +		printf '%-60s' "${test}${zoned}"
>  	fi
>  	if [[ -z $status ]]; then
>  		echo
> @@ -391,10 +394,19 @@ _call_test() {
>  	fi
>  }
>  
> +_test_dev_is_zoned() {
> +	if grep -qe "none" "${TEST_DEV_SYSFS}/queue/zoned" ; then
> +		SKIP_REASON="${TEST_DEV} is not a zoned block device"
> +		return 1
> +	fi
> +	return 0
> +}
> +
>  _run_test() {
>  	TEST_NAME="$1"
>  	CHECK_DMESG=1
>  	DMESG_FILTER="cat"
> +	RUN_FOR_ZONED=0
>  
>  	# shellcheck disable=SC1090
>  	. "tests/${TEST_NAME}"
> @@ -407,6 +419,11 @@ _run_test() {
>  
>  		RESULTS_DIR="$OUTPUT/nodev"
>  		_call_test test
> +		if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
> +			RESULTS_DIR="$OUTPUT/nodev_zoned"
> +			RUN_FOR_ZONED=1
> +			_call_test test
> +		fi
>  	else
>  		if [[ ${#TEST_DEVS[@]} -eq 0 ]]; then
>  			return 0
> @@ -420,6 +437,11 @@ _run_test() {
>  		local ret=0
>  		for TEST_DEV in "${TEST_DEVS[@]}"; do
>  			TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
> +			if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then
> +				SKIP_REASON="${TEST_DEV} is a zoned block device"
> +				_output_notrun "$TEST_NAME => $(basename "$TEST_DEV")"
> +				continue
> +			fi

We should unset SKIP_REASON here from _test_dev_is_zoned just in case
device_requires forgets to set a SKIP_REASON.

>  			if declare -fF device_requires >/dev/null && ! device_requires; then
>  				_output_notrun "$TEST_NAME => $(basename "$TEST_DEV")"
>  				continue
> @@ -591,6 +613,7 @@ fi
>  # Default configuration.
>  : "${DEVICE_ONLY:=0}"
>  : "${QUICK_RUN:=0}"
> +: "${RUN_ZONED_TESTS:=0}"
>  : "${OUTPUT:=results}"
>  if [[ -v EXCLUDE ]] && ! declare -p EXCLUDE | grep -q '^declare -a'; then
>  	# If EXCLUDE was not defined as an array, convert it to one.
> diff --git a/common/null_blk b/common/null_blk
> index 937ece0..fd035b7 100644
> --- a/common/null_blk
> +++ b/common/null_blk
> @@ -8,8 +8,29 @@ _have_null_blk() {
>  	_have_modules null_blk
>  }
>  
> +_null_blk_not_zoned() {
> +	if [[ "${ZONED}" != "0" ]]; then
> +		# shellcheck disable=SC2034
> +		SKIP_REASON="null_blk zoned mode not supported"
> +		return 1
> +	fi
> +	return 0
> +}

Is this still used anywhere in this version?

>  _init_null_blk() {
> -	if ! modprobe -r null_blk || ! modprobe null_blk "$@"; then
> +	for d in /sys/kernel/config/nullb/*;
> +	do [[ -d "$d" ]] && rmdir "$d";	done

I'd prefer to do this without globbing:

        if [[ -d /sys/kernel/config/nullb ]]; then
                find /sys/kernel/config/nullb -mindepth 1 -maxdepth 1 -type d -delete
        fi

> +	local _zoned=""
> +	if [[ ${RUN_FOR_ZONED} -ne 0 ]] ; then
> +		if ! _have_kernel_option BLK_DEV_ZONED ; then
> +			echo -n "ZONED specified for kernel with "
> +			echo "CONFIG_BLK_DEV_ZONED disabled"
> +			return 1
> +		fi

Let's avoid _have_kernel_option if we can, since that requires that the
user enabled CONFIG_IKCONFIG_PROC or installed their config in /boot. We
can just skip this check and the modprobe below will fail with
"null_blk: CONFIG_BLK_DEV_ZONED not enabled" in dmesg.

While you're here, this variable name doesn't need the leading
underscore.

> +		_zoned="zoned=1"
> +	fi
> +	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${_zoned}" ; then
>  		return 1
>  	fi
>  
> diff --git a/common/shellcheck b/common/shellcheck
> index 5f46c00..b9be7d2 100644
> --- a/common/shellcheck
> +++ b/common/shellcheck
> @@ -6,5 +6,5 @@
>  
>  # Suppress unused global variable warnings.
>  _silence_sc2034() {
> -	echo "$CGROUP2_DIR $CHECK_DMESG $DESCRIPTION $DMESG_FILTER $FIO_PERF_FIELDS $FIO_PERF_PREFIX $QUICK $SKIP_REASON ${TEST_RUN[*]} $TIMED" > /dev/null
> +	echo "$CGROUP2_DIR $CHECK_DMESG $DESCRIPTION $DMESG_FILTER $FIO_PERF_FIELDS $FIO_PERF_PREFIX $QUICK $SKIP_REASON ${TEST_RUN[*]} $TIMED $CAN_BE_ZONED" > /dev/null
>  }
> diff --git a/new b/new
> index 63e36cd..d7d5f7c 100755
> --- a/new
> +++ b/new
> @@ -145,6 +145,10 @@ DESCRIPTION=""
>  # Alternatively, you can filter out any unimportant messages in dmesg like so:
>  # DMESG_FILTER="grep -v sysfs"
>  
> +# TODO: if this test can be run for both regular block devices and zoned block
> +# devices, uncomment the line below.
> +# CAN_BE_ZONED=1
> +
>  # TODO: if this test has any extra requirements, it should define a requires()
>  # function. If the test can be run, requires() should return 0. Otherwise, it
>  # should return non-zero and set the \$SKIP_REASON variable. Usually,
> -- 
> 2.20.1
> 
