Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCA9C433DB
	for <linux-block@archiver.kernel.org>; Sat,  2 Jan 2021 05:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5F9205CA
	for <linux-block@archiver.kernel.org>; Sat,  2 Jan 2021 05:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbhABFOn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Jan 2021 00:14:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43174 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbhABFOn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Jan 2021 00:14:43 -0500
Received: from localhost (unknown [IPv6:2804:431:c7f4:46f8:ae05:b936:9029:cd4b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C034B1F45010;
        Sat,  2 Jan 2021 05:14:00 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: fix I/O error on fsync() in detached loop devices
Organization: Collabora
References: <20201231162845.1853347-1-mfo@canonical.com>
Date:   Sat, 02 Jan 2021 02:13:53 -0300
In-Reply-To: <20201231162845.1853347-1-mfo@canonical.com> (Mauricio Faria de
        Oliveira's message of "Thu, 31 Dec 2020 13:28:45 -0300")
Message-ID: <87k0sv6hv2.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mauricio Faria de Oliveira <mfo@canonical.com> writes:

> There's an I/O error on fsync() in a detached loop device
> if it has been previously attached.
>
> The issue is write cache is enabled in the attach path in
> loop_configure() but it isn't disabled in the detach path;
> thus it remains enabled in the block device regardless of
> whether it is attached or not.
>
> Now fsync() can get an I/O request that will just be failed
> later in loop_queue_rq() as device's state is not 'Lo_bound'.
>
> So, disable write cache in the detach path.
>
> Test-case:
>
>     # DEV=/dev/loop7
>
>     # IMG=/tmp/image
>     # truncate --size 1M $IMG
>
>     # losetup $DEV $IMG
>     # losetup -d $DEV
>
> Before:
>
>     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
>     fsync(3)                                = -1 EIO (Input/output error)
>     Warning: Error fsyncing/closing /dev/loop7: Input/output error
>     [  982.529929] blk_update_request: I/O error, dev loop7, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
>
> After:
>
>     # strace -e fsync parted -s $DEV print 2>&1 | grep fsync
>     fsync(3)                                = 0
>
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> Co-developed-by: Eric Desrochers <eric.desrochers@canonical.com>
> Signed-off-by: Eric Desrochers <eric.desrochers@canonical.com>

This sign-off chain is not sorted correctly.  See Documentation/process/submitting-patches.rst.

Other than that, I think the fix makes sense.

Tested-by: Gabriel Krisman Bertazi <krisman@collabora.com>

> ---
>  drivers/block/loop.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index e5ff328f0917..49517482e061 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1212,6 +1212,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>  		goto out_unlock;
>  	}
>  
> +	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY) && filp->f_op->fsync)
> +		blk_queue_write_cache(lo->lo_queue, false, false);
> +
>  	/* freeze request queue during the transition */
>  	blk_mq_freeze_queue(lo->lo_queue);

-- 
Gabriel Krisman Bertazi
