Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E31C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 00:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78CA208E7
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 00:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="pH9g5nwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78CA208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbeK0L3M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:29:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44608 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeK0L3L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 06:29:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so7421166pfh.11
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 16:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qGfTtaOUgqCddDkUsplkDrHOWcD/M39UhHjpLaEFXls=;
        b=pH9g5nwPOfDiyKwDxzMAxilk/2AVmXCOG9uM3j5PiLeBRvzinuV46r40bS7m0c8xnr
         GpOueDMu8EHC98aVklEFVfcPoGITeO2FAqmfc2/iYgreX40UP0cnKO8r9sgKRTK4OPKK
         9tR2rvxg+77NX1Vgwb2JikMOQvmjcM6mPAoPF2ikgXfx4lMrxE9JTZWCDPodtINg9rE/
         1bUp5+jOlX2sy0peTpAAX6dQyPQrhirVjpL/ITHyKWa+aiTNNqyAqsm8+361EdyXafjj
         w+eB3iZjnBhJp0kTTNakG8QZaq5qls1OFut6mb8UxDoAFyA+dAZ5IQIG+cHrmOWM+dfo
         t/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qGfTtaOUgqCddDkUsplkDrHOWcD/M39UhHjpLaEFXls=;
        b=ccpJor6+f++1Qppdh2Uyw+2rtMAOpZuIXmg5ptgmbJyuFys9wJ0ypaVoBn7IF5lU99
         26TOxnBA2a8mJF75/bPB0ExaLhcPipPqWIpmqo550Ya4lVRQ2R/AQoU2HN4UVi7AoXAj
         wRN1N5tTgyyIdqweZ62cVzAfQhjDW9Gr4BDdd1VGSROSOaKcUAA5CHIJXdzRUSWOj1QG
         Qc9tRucB0K+PAscAGh6EKb0XW2ZjnyNrHFLsSfJyJ+pQELXA3xQBcT6RI6kHNp/lee3i
         X2qGeyQJN6nAVcgoGiQ2eMiEE04d/YOyn+CsFeL0ynOrFew9fFKhzsCXb5PZLr4bXOVt
         sVNg==
X-Gm-Message-State: AA+aEWZNCGPkGdbJEbjuFrwwjVhDru8bgUP92Eu2CqEYXmmMIMj5hYDo
        z11HACjnQPdV9dw6OkCxFQtDvA==
X-Google-Smtp-Source: AFSGD/VOprmpF0/Dr5kIJvd1OBlk0+EEwSVFzpVxEQ+ivzyDf5Iknfe3cRg9GbHDAkTmm7kRVeeLwg==
X-Received: by 2002:a63:a552:: with SMTP id r18mr27151338pgu.176.1543278792355;
        Mon, 26 Nov 2018 16:33:12 -0800 (PST)
Received: from vader ([2620:10d:c090:180::1:ec9f])
        by smtp.gmail.com with ESMTPSA id 6sm4587339pfv.30.2018.11.26.16.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 16:33:11 -0800 (PST)
Date:   Mon, 26 Nov 2018 16:33:10 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block/025: test discard sector alignement and sector
 size overflow
Message-ID: <20181127003310.GA846@vader>
References: <20181115040017.4920-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115040017.4920-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 12:00:17PM +0800, Ming Lei wrote:
> This test covers the following two issues:
> 
> 1) discard sector need to be aligned with logical block size
> 
> 2) make sure 'sector_t' instead of 'unsigned int' is used when comparing
> with discard sector size
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tests/block/025     | 37 +++++++++++++++++++++++++++++++++++++
>  tests/block/025.out |  2 ++
>  2 files changed, 39 insertions(+)
>  create mode 100755 tests/block/025
>  create mode 100644 tests/block/025.out
> 
> diff --git a/tests/block/025 b/tests/block/025
> new file mode 100755
> index 000000000000..32b632431793
> --- /dev/null
> +++ b/tests/block/025
> @@ -0,0 +1,37 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2018 Ming Lei <ming.lei@redhat.com>
> +#
> +# Check two corener cases of BLKDISCARD.
> +#
> +# 1) test if discard bio's sector is algined with logical size, fixed by
> +#    1adfc5e4136f ("block: make sure discard bio is aligned with logical block size")

Hm, I'm not seeing how this test case tests this commit. Aren't 2049G
and 512M both aligned to 4096 bytes?

> +# 2) test 32 bit overflow when comparing discard sector size. Fixed by
> +#    4800bf7bc8c72 ("block: fix 32 bit overflow in __blkdev_issue_discard()")
> +
> +. tests/block/rc
> +. common/scsi_debug
> +
> +DESCRIPTION="check sector alignment and sector size overflow of BLKDISCARD"
> +
> +requires() {
> +	_have_scsi_debug
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	rm -f "$FULL"
> +
> +	# Create virtual device with unmap_zeroes_data support
> +	if ! _init_scsi_debug virtual_gb=2049 sector_size=4096 lbpws10=1 dev_size_mb=512; then
> +		return 1
> +	fi
> +
> +	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}"
> +	blkdiscard "$dev"
> +
> +	_exit_scsi_debug
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/block/025.out b/tests/block/025.out
> new file mode 100644
> index 000000000000..fd9a6d5f70de
> --- /dev/null
> +++ b/tests/block/025.out
> @@ -0,0 +1,2 @@
> +Running block/025
> +Test complete
> -- 
> 2.9.5
> 
