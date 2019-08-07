Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C2EC31E40
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 00:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6132216F4
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 00:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="p2bipK/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfHGALe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:11:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41447 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfHGALe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Aug 2019 20:11:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so42407908pff.8
        for <linux-block@vger.kernel.org>; Tue, 06 Aug 2019 17:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FHkYZFdhu0EroWjiQgrWlC/DWW5EUBpZdJOx/PE1gZQ=;
        b=p2bipK/hp+GWCpIUnLm5PJ2DUZuZCS1DAuEkkJqx8OyM4PHsr3j1AbqHt5cZBXssbA
         m2rrDFLvqgYjdmkdAvn5Vct8fnwqsn8ll0w8RPzEkO0fl0BPIzBs9FLkULW6uk9QYUhF
         vbyds1+r9XVS5m5REgqxayqvcvxEENUghKfgDET1Nk+awEcyWmneeCTpILk69v3nUgQc
         ESwBdORAm1R26Ezo5UPM7K+XjVJ1irEFOER1gWPx46ZTMlw8DhkVlnN87KQket49tzPT
         VayODgU/GPeAkQruipkpLQh5odQXOUhCL0uoRngTv02FhhvpMQEGpDBhUEMNi+xeAuLp
         /aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FHkYZFdhu0EroWjiQgrWlC/DWW5EUBpZdJOx/PE1gZQ=;
        b=H1aJMXG2SyjRdeVs07c1GXEho7FP5ug4AooTjyzTLlGX53VLFiVMvXWPufvneHQ6qa
         6XRGeyg8MSHpMb9nWpauiWOVJStwqVa3MbGuqylHxGgNq7mx73q8MaKs47kQinNc4NKS
         fBYkMgBfylu8u68P1xMthQG/sRN1EgsZyGAWcSdZl5nfb7t08b6mfvMdHXyKKceK0so5
         YoifE5cgl6xW4EeVhiCOprmtyObg+lWgPxHMLUcTj0nGED5mmdRjsSbafIHx+YkrbsfG
         a8eK/wBc5pZn7w/cUKPLh8hVvp10s5B0TeoKz5xbYKsRwCqr1Ayh/+92mox7vHTVvLUz
         bgEQ==
X-Gm-Message-State: APjAAAUJu0HQEIWCFi7/J1vRzNea/ecQ+q+mcGpEt4y0x7jhs490q+ye
        W/x8RDHt55wJMETgoFXnE+1H9w==
X-Google-Smtp-Source: APXvYqxhuUyZmPzhQA90jaQ84hjwbgbba83Yuz+P3uc30r1sQHJ49cSlriadx1oApsIuUDHdBti7GA==
X-Received: by 2002:a17:90a:8a84:: with SMTP id x4mr5603574pjn.105.1565136693315;
        Tue, 06 Aug 2019 17:11:33 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::aa33])
        by smtp.gmail.com with ESMTPSA id n17sm95514602pfq.182.2019.08.06.17.11.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 17:11:32 -0700 (PDT)
Date:   Tue, 6 Aug 2019 17:11:32 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] tests/srp/014: Add a test that triggers a SCSI
 reset while I/O is ongoing
Message-ID: <20190807001132.GA29151@vader>
References: <20190801220937.133392-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801220937.133392-1-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 01, 2019 at 03:09:37PM -0700, Bart Van Assche wrote:

Hi, Bart, a few comments.

> This test triggers the task management function handling code in the SRP
> initiator and target drivers. This test verifies the following kernel
> patch: fd5614124406 ("scsi: RDMA/srp: Fix a sleep-in-invalid-context
> bug") # v5.3.

The commit reference belongs in the test file itself (see, e.g.,
block/001).

> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> 
> A note regarding the copyright notice: I wrote this patch more than a year
> ago. Hence the copyright attribution to Western Digital.
> 
>  tests/srp/014     | 104 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/srp/014.out |   2 +
>  2 files changed, 106 insertions(+)
>  create mode 100755 tests/srp/014
>  create mode 100644 tests/srp/014.out

> diff --git a/tests/srp/014 b/tests/srp/014
> new file mode 100755
> index 000000000000..bc2e844abdd2
> --- /dev/null
> +++ b/tests/srp/014
> @@ -0,0 +1,104 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (c) 2016-2018 Western Digital Corporation or its affiliates
> +
> +. tests/srp/rc
> +
> +DESCRIPTION="Run sg_reset while I/O is ongoing"
> +TIMED=1
> +

[snip]

> +test_sg_reset() {
> +	local dev fio_status m job jobfile
> +
> +	use_blk_mq y y || return $?
> +	dev=$(get_bdev 0) || return $?
> +	sg_reset_loop "$dev" "$TIMEOUT" &

TIMEOUT is only set if the user configured it, so you should set a
default (see block/001).

> +	jobfile=$(mktemp)
> +	# Redirect stderr to suppress the bash "Terminated" message.
> +	(set_running_loop "$dev" 2>/dev/null & echo $! > "$jobfile")

Why is the subshell/jobfile necessary here? The following seems to work,
am I missing something?

	set_running_loop "$dev" 2>/dev/null &
	job=$!

Thanks!

> +	job=$(<"$jobfile")
> +	rm -f "$jobfile"
> +	run_fio --verify=md5 --rw=randwrite --bs=64K --loops=$((10**6)) \
> +		--iodepth=16 --group_reporting --sync=1 --direct=1 \
> +		--ioengine=libaio --runtime="${TIMEOUT}" \
> +		--filename="$dev" --name=sg-reset-test --thread --numjobs=1 \
> +		--output="${RESULTS_DIR}/srp/fio-output-014.txt" \
> +		>>"$FULL"
> +	fio_status=$?
> +	kill "$job"
> +	make_all_running "$dev"
> +	wait
> +	return $fio_status
> +}
> +
> +test() {
> +	trap 'trap "" EXIT; teardown' EXIT
> +	setup && test_sg_reset && echo Passed
> +}
> diff --git a/tests/srp/014.out b/tests/srp/014.out
> new file mode 100644
> index 000000000000..5e25d8e8672d
> --- /dev/null
> +++ b/tests/srp/014.out
> @@ -0,0 +1,2 @@
> +Configured SRP target driver
> +Passed
> -- 
> 2.22.0.770.g0f2c4a37fd-goog
> 
