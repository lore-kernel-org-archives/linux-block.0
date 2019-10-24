Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB1FCA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EDD20663
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="lHUEHdVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389782AbfJXRnC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:43:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35072 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfJXRnC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 13:43:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id c3so12226791plo.2
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IubIoCqCURwBT/CcLpUkngZEOt00T9VMM4K/eeI9+rE=;
        b=lHUEHdVQ3eLAfoiZdzSYJbH8NqV4mRs1rQoSwO3Dx6RMfEoErM0vTGkxXKuwC8xc77
         rdE/ulPbGrcZwHGUIFG+KfmJ/NQYc8+sGpB/Hy/shCu5t4Fxv4VapdIkJh/kpO5Jy9n7
         0gohpRD7wYKIGXiY/e0d6UtqfdqO8NOfHGiPgGBFYi2OPGCVXhY+xzef75fm5V6dPe82
         /KZ30N3gxN9/IUr3OfmqbhYVT+eg6xh8G6wUcJCa/cCWaaTqmRZcqtJB+feyFGYGN1QY
         sxSB03Vt+nB39qj0hh061gWpAbVZidsyX9+5+H5qnfrUcoXgvk+wnPNOqHetOSdf9d0C
         GNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IubIoCqCURwBT/CcLpUkngZEOt00T9VMM4K/eeI9+rE=;
        b=Sb/bTTOsTXHa8IQFLVZtH5xz6lTUQFN+3o+EkeYazKIRhMqScKrXP+a7Mnw/fMdxGa
         Oqu8soG0pBJyQ+1AQuDi2/ktgsXm4d28hlhW6WpRJJtygy7YDTZHD70WY8WdTUOh3LE7
         bgsbsLsayaJGOf+1KFbyXEzgAiiFvV5NhluKHS4Ts3lTlhHQ3pPGroJBvtXALqLg59sR
         LH+UIi2Lb8p8GkKmParUHcuYaV3pw+cDljUjCMrHzI6bwe6ZFFMscreatV0sEWM0DYGj
         KGSb9iPgSPZSDv/DGDLixhQef7LnkezkRhlXAqjlvW52NoQVSc0kzl7npDKOhNPSi71F
         gcRA==
X-Gm-Message-State: APjAAAVQ5dj/kIlLJzHsCLJc2gCBT3H2aNil5hw8TJV5CxWGvIqmlkPo
        SHHz0Lu4cdnL+2MlYqdVwIy8+EGcF6c=
X-Google-Smtp-Source: APXvYqzAH5zhF3ZaarbsKgqvkzfTRb62+SUoJh3hkzijkjzcsXF/AvwaNFvjZ2xmluC0ZeRlvkRO9A==
X-Received: by 2002:a17:902:9b85:: with SMTP id y5mr17191755plp.138.1571938964258;
        Thu, 24 Oct 2019 10:42:44 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id j63sm12000610pfb.162.2019.10.24.10.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:42:43 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:42:42 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH blktests 2/2] Add a test that triggers
 blk_mq_update_nr_hw_queues()
Message-ID: <20191024174242.GB137052@vader>
References: <20191021225719.211651-1-bvanassche@acm.org>
 <20191021225719.211651-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021225719.211651-3-bvanassche@acm.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 21, 2019 at 03:57:19PM -0700, Bart Van Assche wrote:
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tests/block/029     | 63 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/029.out |  1 +
>  2 files changed, 64 insertions(+)
>  create mode 100755 tests/block/029
>  create mode 100644 tests/block/029.out
> 
> diff --git a/tests/block/029 b/tests/block/029
> new file mode 100755
> index 000000000000..1999168603c1
> --- /dev/null
> +++ b/tests/block/029
> @@ -0,0 +1,63 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 Google Inc.
> +#
> +# Trigger blk_mq_update_nr_hw_queues().
> +
> +. tests/block/rc
> +. common/null_blk
> +
> +DESCRIPTION="trigger blk_mq_update_nr_hw_queues()"
> +QUICK=1
> +
> +requires() {
> +	_have_null_blk
> +}
> +
> +# Configure one null_blk instance.
> +configure_null_blk() {
> +	(
> +		cd /sys/kernel/config/nullb || return $?
> +		(
> +			mkdir -p nullb0 &&
> +				cd nullb0 &&
> +				echo 0 > completion_nsec &&
> +				echo 512 > blocksize &&
> +				echo 16 > size &&
> +				echo 1 > memory_backed &&
> +				echo 1 > power
> +		)
> +	) &&
> +	ls -l /dev/nullb* &>>"$FULL"

What's the point of these nested subshells? Can't this just be:

configure_null_blk() {
	cd /sys/kernel/config/nullb &&
	mkdir -p nullb0 &&
	cd nullb0 &&
	echo 0 > completion_nsec &&
	echo 512 > blocksize &&
	echo 16 > size &&
	echo 1 > memory_backed &&
	echo 1 > power &&
	ls -l /dev/nullb* &>>"$FULL"
}

> +}
> +
> +modify_nr_hw_queues() {
> +	local deadline num_cpus
> +
> +	deadline=$(($(_uptime_s) + TIMEOUT))
> +	num_cpus=$(find /sys/devices/system/cpu -maxdepth 1 -name 'cpu[0-9]*' |
> +			   wc -l)

Please just use nproc. Or even better, can you just read the original
value of /sys/kernel/config/nullb/nullb0/submit_queues? Or does that
start at 1?

> +	while [ "$(_uptime_s)" -lt "$deadline" ]; do
> +		sleep .1
> +		echo 1 > /sys/kernel/config/nullb/nullb0/submit_queues
> +		sleep .1
> +		echo "$num_cpus" > /sys/kernel/config/nullb/nullb0/submit_queues
> +	done
> +}
> +
> +test() {
> +	: "${TIMEOUT:=30}"
> +	_init_null_blk nr_devices=0 queue_mode=2 &&
> +	configure_null_blk
> +	modify_nr_hw_queues &
> +	fio --rw=randwrite --bs=4K --loops=$((10**6)) \
> +		--iodepth=64 --group_reporting --sync=1 --direct=1 \
> +		--ioengine=libaio --filename="/dev/nullb0" \
> +		--runtime="${TIMEOUT}" --name=nullb0 \
> +		--output="${RESULTS_DIR}/block/fio-output-029.txt" \
> +		>>"$FULL"
> +	wait
> +	rmdir /sys/kernel/config/nullb/nullb0
> +	_exit_null_blk
> +	echo Passed
> +}
> diff --git a/tests/block/029.out b/tests/block/029.out
> new file mode 100644
> index 000000000000..863339fb8ced
> --- /dev/null
> +++ b/tests/block/029.out
> @@ -0,0 +1 @@
> +Passed
> -- 
> 2.23.0.866.gb869b98d4c-goog
> 
