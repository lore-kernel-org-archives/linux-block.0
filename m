Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9FDC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 22:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3252820823
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 22:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="iie9xShK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCDWej (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:34:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38231 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCDWej (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 17:34:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id n125so4043326pfn.5
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 14:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XECEaOJxFqeAgHtSjTrBU+rafE/6hSD8U+y9RittPM0=;
        b=iie9xShKS9NqVcef9OALnlK/bMrreGkqwJmbmtN1/kMf6H4wBGvb3u3Gj2eMvwOGUv
         Kb1i2X7q2nFxAqGUeA/g3AkwSOz+QSHT85jKTNLnDjC5OUXn7JRLZf43kXwAyr3PHpVp
         2jAhE7LL/vkE02Wp8nACMB1pE0t1yo8pUZ8UWp//U/Rv+bRfbFjJICvAqSdBDq7oHgLm
         7C+1ypLnGUM+u/Qw9sz/MLScRc4ifccm3lbZSJks629H9PwdqgL8LeUo40gefgjfo5L9
         Aw53ME+Py6oDJrJwe2xytedzqxBOTPYeRM31eCten2FtrKVXT4K9F6YH9v8bV+G6WJTb
         cuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XECEaOJxFqeAgHtSjTrBU+rafE/6hSD8U+y9RittPM0=;
        b=rm/XAvAr6l/4MxMPx9p4mxad8zTPyysLcUKI8/jU+3Cx+yLrX9MPyFEMCh2YzZi3Oh
         wsOcTRo3AHz1MbN/BvecqEBUhO0TvpIa92S4NEumcCzRJpX41IOtWt+cklFtmKDtDd3r
         eakAzAm6RcazTAWUWhNjF9fw2dlywS4d8ufnayuY1fAoKATTCdjfGzK4gtEn3WUsSZMk
         bqSPNND5h2IrNge5Cb9SVJsGWv9ojhPx1WQSxDGhYd6h5TSjOyu2lW2jKVTULYATW3H+
         PdzosWlS+OltLvzvcQC/ty0Nh0xPvgSuS/cTmqQCnmLAKPBM2m28ndpAMk9ZeiXQCMLO
         uldg==
X-Gm-Message-State: APjAAAWiLzdt1++tZH4XpUlbSU7njqlp0fC+kiInodC5T12rUlRWcDMN
        BayWqy0pmxFSq+2YjSGjux8X5g==
X-Google-Smtp-Source: APXvYqyINNxfObQCTjp1E6YF9oJpiUnJuMowfzEFpHvP0N8FXGx3MdA+n0FEyW2qdTYs586QxJkYzw==
X-Received: by 2002:a63:e310:: with SMTP id f16mr19964361pgh.93.1551738877963;
        Mon, 04 Mar 2019 14:34:37 -0800 (PST)
Received: from vader ([2620:10d:c090:200::3:9d2c])
        by smtp.gmail.com with ESMTPSA id b15sm10928715pfj.167.2019.03.04.14.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 14:34:37 -0800 (PST)
Date:   Mon, 4 Mar 2019 14:34:36 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 3/5] check: Add TEST_DEV_PART_SYSFS variable
Message-ID: <20190304223436.GC5450@vader>
References: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
 <20190220081231.15366-4-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220081231.15366-4-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 05:12:29PM +0900, Shin'ichiro Kawasaki wrote:
> When partition devices are specified in TEST_DEV, TEST_DEV_SYSFS
> variable points to the sysfs paths of holder devices of the partition
> devices (e.g., /sys/block/sda). This sysfs path is different from the
> sysfs path of the partition devices (e.g., /sys/block/sda/sda1). For
> example, size parameters exist in both the holder device sysfs and
> the partition device sysfs with different values.
> 
> To allow test cases to access sysfs path of the partition devices,
> add TEST_DEV_PART_SYSFS variable. TEST_DEV_SYSFS is set as is to refer
> the sysfs path of the holder devices. If the TEST_DEV is not a partition
> device, an empty string is set to the TEST_DEV_PART_SYSFS variable.
> 
> Change _find_sysfs_dir() function to return the holder device sysfs as
> well as the partition device sysfs. The function obtains the canonical
> sysfs path, and if the device is a partition device, the function cut the
> last device name in the canonical sysfs path to obtain the holder device
> sysfs path.

This makes sense. A couple of small tweaks below.

> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  check | 51 ++++++++++++++++++++++++++++++++++-----------------
>  new   | 16 ++++++++++++++--
>  2 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/check b/check
> index f41ecba..e45b34f 100755
> --- a/check
> +++ b/check
> @@ -442,13 +442,19 @@ _run_test() {
>  				_warning "$TEST_NAME: fallback_device call failure"
>  				return 0
>  			fi
> -			if ! sysfs_dir="$(_find_sysfs_dir "$test_dev")"; then
> +
> +			local dirs
> +			local sysfs_dir
> +			local part_sysfs_dir
> +			if ! dirs=$(_find_sysfs_dir "$test_dev") ; then
>  				_warning "$TEST_NAME: could not find sysfs directory for ${test_dev}"
>  				cleanup_fallback_device
>  				return 0
>  			fi
> +			read -r sysfs_dir part_sysfs_dir < <(echo "${dirs}")

Let's rename _find_sysfs_dir to find_sysfs_dirs and make it set
TEST_DEV_SYSFS_DIRS["$test_dev"] and
TEST_DEV_PART_SYSFS_DIRS["$test_dev"] itself instead of returning the
string.

>  			TEST_DEVS=( "${test_dev}" )
>  			TEST_DEV_SYSFS_DIRS["$test_dev"]="$sysfs_dir"
> +			TEST_DEV_PART_SYSFS_DIRS["$test_dev"]="$part_sysfs_dir"
>  			FALLBACK_DEVICE=1
>  		fi
>  
> @@ -464,6 +470,7 @@ _run_test() {
>  		local ret=0
>  		for TEST_DEV in "${TEST_DEVS[@]}"; do
>  			TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
> +			TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
>  			if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then
>  				SKIP_REASON="${TEST_DEV} is a zoned block device"
>  				_output_notrun "$TEST_NAME => $(basename "$TEST_DEV")"
> @@ -483,6 +490,7 @@ _run_test() {
>  		if (( FALLBACK_DEVICE )); then
>  			cleanup_fallback_device
>  			unset TEST_DEV_SYSFS_DIRS["${TEST_DEVS[0]}"]
> +			unset TEST_DEV_PART_SYSFS_DIRS["${TEST_DEVS[0]}"]
>  			TEST_DEVS=()
>  		fi
>  
> @@ -507,6 +515,8 @@ _run_group() {
>  		for i in "${!TEST_DEVS[@]}"; do
>  			TEST_DEV="${TEST_DEVS[$i]}"
>  			TEST_DEV_SYSFS="${TEST_DEV_SYSFS_DIRS["$TEST_DEV"]}"
> +			# shellcheck disable=SC2034
> +			TEST_DEV_PART_SYSFS="${TEST_DEV_PART_SYSFS_DIRS["$TEST_DEV"]}"
>  			if ! group_device_requires; then
>  				_output_notrun "${group}/*** => $(basename "$TEST_DEV")"
>  				unset TEST_DEVS["$i"]
> @@ -529,28 +539,31 @@ _run_group() {
>  
>  _find_sysfs_dir() {
>  	local test_dev="$1"
> +	local sysfs_path
>  	local major=$((0x$(stat -L -c '%t' "$test_dev")))
>  	local minor=$((0x$(stat -L -c '%T' "$test_dev")))
> -	local dev="$major:$minor"
> +	local sysdev_path="/sys/dev/block/${major}:${minor}"
>  
> -	local block_dir part_dir
> -	for block_dir in /sys/block/*; do
> -		if [[ $(cat "${block_dir}/dev") = "$dev" ]]; then
> -			echo "$block_dir"
> -			return
> -		fi
> -		for part_dir in "$block_dir"/*; do
> -			if [[ -r ${part_dir}/dev && $(cat "${part_dir}/dev") = "$dev" ]]; then
> -				echo "$block_dir"
> -				return
> -			fi
> -		done
> -	done
> +	# Get the canonical sysfs path
> +	if ! sysfs_path=/sys/dev/block/$(readlink "${sysdev_path}"); then

sysfs_path="$(realpath "/sys/dev/block/${major}:${minor}")" is a bit
shorter, does that still work?

> +		return 1
> +	fi
>  
> -	return 1
> +	if [[ -r "${sysfs_path}"/partition ]]; then
> +		# If the device is a partition device, cut the last device name
> +		# of the canonical sysfs path to access to the sysfs of its
> +		# holder device.
> +		#   e.g.   .../block/sda/sda1  ->  ...block/sda
> +		# Return both the holder device sysfs path and the partition
> +		# device sysfs path.
> +		echo "${sysfs_path%/*}" "${sysfs_path}"
> +	else
> +		echo "${sysfs_path}" ""
> +	fi
>  }
>  
>  declare -A TEST_DEV_SYSFS_DIRS
> +declare -A TEST_DEV_PART_SYSFS_DIRS
>  _check() {
>  	# shellcheck disable=SC2034
>  	SRCDIR="$(realpath src)"
> @@ -563,11 +576,15 @@ _check() {
>  			_error "${test_dev} is not a block device"
>  		fi
>  
> +		local dirs
>  		local sysfs_dir
> -		if ! sysfs_dir="$(_find_sysfs_dir "$test_dev")"; then
> +		local part_sysfs_dir
> +		if ! dirs=$(_find_sysfs_dir "$test_dev") ; then
>  			_error "could not find sysfs directory for ${test_dev}"
>  		fi
> +		read -r sysfs_dir part_sysfs_dir < <(echo "${dirs}")
>  		TEST_DEV_SYSFS_DIRS["$test_dev"]="$sysfs_dir"
> +		TEST_DEV_PART_SYSFS_DIRS["$test_dev"]="$part_sysfs_dir"
>  	done
>  
>  	local test_name group prev_group
> diff --git a/new b/new
> index d7d5f7c..24c066d 100755
> --- a/new
> +++ b/new
> @@ -80,7 +80,10 @@ group_requires() {
>  # should return non-zero and set the \$SKIP_REASON variable. \$TEST_DEV is the
>  # full path of the block device (e.g., /dev/nvme0n1 or /dev/sda1), and
>  # \$TEST_DEV_SYSFS is the sysfs path of the disk (not the partition, e.g.,
> -# /sys/block/nvme0n1 or /sys/block/sda).
> +# /sys/block/nvme0n1 or /sys/block/sda). If the target device is a partition
> +# device, \$TEST_DEV_PART_SYSFS is the sysfs path of the partition device
> +# (e.g., /sys/block/nvme0n1/nvme0n1p1 or /sys/block/sda/sda1). Otherwise,
> +# \$TEST_DEV_PART_SYSFS is an empty string.
>  #
>  # Usually, group_device_requires() just needs to check that the test device is
>  # the right type of hardware or supports any necessary features using the
> @@ -165,7 +168,10 @@ DESCRIPTION=""
>  # set the \$SKIP_REASON variable. \$TEST_DEV is the full path of the block
>  # device (e.g., /dev/nvme0n1 or /dev/sda1), and \$TEST_DEV_SYSFS is the sysfs
>  # path of the disk (not the partition, e.g., /sys/block/nvme0n1 or
> -# /sys/block/sda).
> +# /sys/block/sda). If the target device is a partition device,
> +# \$TEST_DEV_PART_SYSFS is the sysfs path of the partition device (e.g.,
> +# /sys/block/nvme0n1/nvme0n1p1 or /sys/block/sda/sda1). Otherwise,
> +# \$TEST_DEV_PART_SYSFS is an empty string.
>  #
>  # Usually, device_requires() just needs to check that the test device is the
>  # right type of hardware or supports any necessary features using the
> @@ -207,6 +213,12 @@ DESCRIPTION=""
>  #    - \$TEST_DEV_SYSFS -- the sysfs directory of the device (e.g.,
>  #                         /sys/block/sda). In general, you should use the
>  #                         _test_dev_queue_{get,set} helpers.
> +#                         If the device is a partition device, the sysfs
> +#                         directory of its holder device is set.
> +#    - \$TEST_DEV_PART_SYSFS -- the sysfs directory of the device if the device
> +#                               is a partition device (e.g.,
> +#                               /sys/block/sda/sda1). Empty string is set if
> +#                               the device is not a partition device.
>  test() {
>  	echo "Running \${TEST_NAME}"
>  
> -- 
> 2.20.1
> 
