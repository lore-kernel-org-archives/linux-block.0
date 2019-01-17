Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48FBC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 23:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9460F20855
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 23:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5JMzDob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfAQXDU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:03:20 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36449 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfAQXDT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 18:03:19 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so13305286qtn.3
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 15:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqBUcR9XZzQnnZhAhjO2twNy5upfAkhgq15vICzAi5k=;
        b=f5JMzDobXbVrmXbfrKS7uG971K+9Q3A5pO04HvNN3MPr/zky+/zTr14+cbdZUqENfP
         bjXMdjStulht1KlBz3Nu0ml4MVreXD4yFLQCPwPGqSAkCpA4mliI7kY7o+z5m+yCB0x7
         kohqmKWGOvF71FMMiT4fE6k/mMvr++LZUvk5bnnl492KWZTZoupM8fNoh5fOGblPcHip
         aoVEJUKxZl8daMQNJmLbHi7a+jIlhGutv6dgKP3Bn7nunK7gJB6Q8YfcOb98V5YIuGMH
         q0dXwZWCbW+bCX1x1OmCts1tFEmIOYet7D1/DpjAOa6CnGhMJSDGWdURmiGil+Fsbgcu
         CKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqBUcR9XZzQnnZhAhjO2twNy5upfAkhgq15vICzAi5k=;
        b=uczVLomcJLQjOd7CuvITxWG8mM1V1bZIYLmA32TPvJYAAqcYnA+iAuA1o5C1fVCknB
         LGiSHSq70OZlH8zU1VZQL2M1fSH75MVrropeGbBbOkj+rYRrJEfDwWZz2OBjLXOoEOvp
         1P4JKJ0uHdCyw8OmzBsO3wxGfnUOJkcO/Wocvil00yge11Wh/7L4HKqr8dOzD+mQZ9pJ
         s4cbhNbW1eugSHUDc8q1KkLEuLiFJJ7pC2+7FMFxy2g021wodwJHpFzWBDutznjFYDMt
         IbVV4xlrR6DffHHY3PaZ2GyddqPLJd+fjD2NH4n57JtwkJwK6tzwNYgvDE3h5DY2qqVg
         5Pjg==
X-Gm-Message-State: AJcUukfhi0Amz6n7ikWvAGzulhHup8aDH5uk8OVI+6ToY2r89hTYj8ha
        HA15mBcGLyD7jrS2srmMWVKQAb1Y/1h9R2kXBee5IA==
X-Google-Smtp-Source: ALg8bN42mMyRa4Ob+a1Tb7HWuwY62v0f+9sOt9/0Fg/8ysCHVdjI/c2A+A0Iu1vvwVf+rSg2wb5iaEDYXZJZ4DapfPA=
X-Received: by 2002:ac8:788:: with SMTP id l8mr13617360qth.384.1547766198707;
 Thu, 17 Jan 2019 15:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20190114192137.111275-1-bo.liu@linux.alibaba.com>
In-Reply-To: <20190114192137.111275-1-bo.liu@linux.alibaba.com>
From:   Liu Bo <obuil.liubo@gmail.com>
Date:   Thu, 17 Jan 2019 15:03:07 -0800
Message-ID: <CANQeFDAOQRf69SYDwXuW2+0xdK4tWD1DVrj+mHQTXg6h62i6yQ@mail.gmail.com>
Subject: Re: [PATCH] blk-iolatency: fix IO hang due to negative inflight counter
To:     Liu Bo <bo.liu@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

thanks,
liubo

On Mon, Jan 14, 2019 at 11:25 AM Liu Bo <bo.liu@linux.alibaba.com> wrote:
>
> Our test reported the following stack, and vmcore showed that
> ->inflight counter is -1.
>
> [ffffc9003fcc38d0] __schedule at ffffffff8173d95d
> [ffffc9003fcc3958] schedule at ffffffff8173de26
> [ffffc9003fcc3970] io_schedule at ffffffff810bb6b6
> [ffffc9003fcc3988] blkcg_iolatency_throttle at ffffffff813911cb
> [ffffc9003fcc3a20] rq_qos_throttle at ffffffff813847f3
> [ffffc9003fcc3a48] blk_mq_make_request at ffffffff8137468a
> [ffffc9003fcc3b08] generic_make_request at ffffffff81368b49
> [ffffc9003fcc3b68] submit_bio at ffffffff81368d7d
> [ffffc9003fcc3bb8] ext4_io_submit at ffffffffa031be00 [ext4]
> [ffffc9003fcc3c00] ext4_writepages at ffffffffa03163de [ext4]
> [ffffc9003fcc3d68] do_writepages at ffffffff811c49ae
> [ffffc9003fcc3d78] __filemap_fdatawrite_range at ffffffff811b6188
> [ffffc9003fcc3e30] filemap_write_and_wait_range at ffffffff811b6301
> [ffffc9003fcc3e60] ext4_sync_file at ffffffffa030cee8 [ext4]
> [ffffc9003fcc3ea8] vfs_fsync_range at ffffffff8128594b
> [ffffc9003fcc3ee8] do_fsync at ffffffff81285abd
> [ffffc9003fcc3f18] sys_fsync at ffffffff81285d50
> [ffffc9003fcc3f28] do_syscall_64 at ffffffff81003c04
> [ffffc9003fcc3f50] entry_SYSCALL_64_after_swapgs at ffffffff81742b8e
>
> The ->inflight counter may be negative (-1) if
>
> 0) blk-throttle had been enabled when the IO was issued, so its bio
> has a associated blkg,
>
> 1) blk-iolatency was disabled when the IO was issued, so iolatency_grp
> in this blkg was not available by then,
>
> 2) blk-iolatency was enabled before this IO reached its endio, so that
> iolatency_grp became available when the IO did the endio.
>
> 3) the ->inflight counter is decreased from 0 to -1.
>
> This uses atomic_dec_is_positive() instead to avoid the negative
> inflight counter.
>
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> ---
>  block/blk-iolatency.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index 159af76d60e6..da4ede5c5ddf 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -660,7 +660,12 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
>                 }
>                 rqw = &iolat->rq_wait;
>
> -               atomic_dec(&rqw->inflight);
> +               /*
> +                * if blkg is enabled by another throttler (e.g. blk-throttle)
> +                * and blk-iolatency is enabled while IO is inflight,
> +                * blk-iolatency's ->inflight counter may be still 0.
> +                */
> +               atomic_dec_if_positive(&rqw->inflight);
>                 if (!enabled || iolat->min_lat_nsec == 0)
>                         goto next;
>                 iolatency_record_time(iolat, &bio->bi_issue, now,
> @@ -692,7 +697,8 @@ static void blkcg_iolatency_cleanup(struct rq_qos *rqos, struct bio *bio)
>                         goto next;
>
>                 rqw = &iolat->rq_wait;
> -               atomic_dec(&rqw->inflight);
> +               /* see comments in blkcg_iolatency_done_io() */
> +               atomic_dec_if_positive(&rqw->inflight);
>                 wake_up(&rqw->wait);
>  next:
>                 blkg = blkg->parent;
> --
> 2.20.1.2.gb21ebb6
>
