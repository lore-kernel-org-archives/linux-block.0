Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55790C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 19:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC4021473
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 19:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlxLEIN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbeLQTmm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:42:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36375 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeLQTmm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 14:42:42 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so15519113qtn.3;
        Mon, 17 Dec 2018 11:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3PPDNFe9g5OsR5LN7ZnTRGlAKV1rIaOnirACR3WcmzQ=;
        b=BlxLEIN267TRyXxBbfImYhIvz5DkHmmZoBMXgoKD+ZONxkERmiWwZlPdqxG/BK5XIk
         F4veTheVsiFq9FuQMHIytEKZHw5w0oAxWj7VJo849xeAPUZQjBgtARNqLOd4IdQoZwAj
         1VlzVIQGHFAP3VKPg7M9ResVy8dTEa5uT2yjkEUYYTMS7aFgc/5d6q69TRKa7ifGxes6
         cMqKMTKFEDvw5mTB0ORVZsfs+8R3fTj1B1qZcDU5Bu4XdKoZDkExwfAXPsPOUaw0mEOx
         SdzIk4NZoImNYxmcubf7UtNXSXcP5Shkmi4/gJYQd/cTfItbbwOeT7HeOySgAKKlURgP
         8WCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3PPDNFe9g5OsR5LN7ZnTRGlAKV1rIaOnirACR3WcmzQ=;
        b=tDIul7B4FbgXvl2hhY+0nxXKt1uAsZUhBomPFBqjvFTGGwNweEw2SMjYKXYRojCbXw
         NpS+ARMd6vbHa0xBFuzEl+FTMl3hOoQ/8WQ5A1mXNRysa46efubB9abBhl7wH8RrT1yI
         qk7Weqcry2iG9BFaHbZPHaEY58/eRJyd5i4oydZOEUxFMaGCYAiv7JpdRLsqEKuj222i
         FAfPeuAC/wr7C6vXKp1LCXumtnbkm2NBAo90BOdCBRWoZVHe4kNSLGABgcCefl4x0+75
         +rYwu4CKAW0Ec2AeHUx3Q5CKQwN5fztAtlBBjoM3spr+bTXQCSmi/WhHAOlFrDDZNXEe
         04+w==
X-Gm-Message-State: AA+aEWbz41EHC/3yPt372i13Deb3MhPCKB2uIuM1nhwXW/8KQphQ0jjo
        qcjKmc9JHp5dMcSG5L9zhRAnXUXMElVFdJWfOVA=
X-Google-Smtp-Source: AFSGD/VJbZp7HAhlr1TlVmMqLOHRn2Jp91dwT15fUQ/Fq8hmkUiIrHk4GD0jtZnM6Wx9gUG4AtzXWjCEu4S3u292mYo=
X-Received: by 2002:a0c:a4a3:: with SMTP id x32mr14299976qvx.89.1545075759517;
 Mon, 17 Dec 2018 11:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20181217160351.27903-1-dennis@kernel.org>
In-Reply-To: <20181217160351.27903-1-dennis@kernel.org>
From:   Liu Bo <obuil.liubo@gmail.com>
Date:   Mon, 17 Dec 2018 11:42:28 -0800
Message-ID: <CANQeFDAO5PdMOrZnn0UgFHcHGvXEs7qS9Kqrk1KRCAwgfRzSOg@mail.gmail.com>
Subject: Re: [PATCH v3] block: fix blk-iolatency accounting underflow
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 17, 2018 at 8:04 AM Dennis Zhou <dennis@kernel.org> wrote:
>
> The blk-iolatency controller measures the time from rq_qos_throttle() to
> rq_qos_done_bio() and attributes this time to the first bio that needs
> to create the request. This means if a bio is plug-mergeable or
> bio-mergeable, it gets to bypass the blk-iolatency controller.
>

Hi,

I have a question about merging in plug list, since plug merges are
done before rq_qos_throttle(), why would plug-mergeable bios bypass
the controller?

thanks,
liubo

> The recent series [1], to tag all bios w/ blkgs undermined how iolatency
> was determining which bios it was charging and should process in
> rq_qos_done_bio(). Because all bios are being tagged, this caused the
> atomic_t for the struct rq_wait inflight count to underflow and result
> in a stall.
>
> This patch adds a new flag BIO_TRACKED to let controllers know that a
> bio is going through the rq_qos path. blk-iolatency now checks if this
> flag is set to see if it should process the bio in rq_qos_done_bio().
>
> Overloading BLK_QUEUE_ENTERED works, but makes the flag rules confusing.
> BIO_THROTTLED was another candidate, but the flag is set for all bios
> that have gone through blk-throttle code. Overloading a flag comes with
> the burden of making sure that when either implementation changes, a
> change in setting rules for one doesn't cause a bug in the other. So
> here, we unfortunately opt for adding a new flag.
>
> [1] https://lore.kernel.org/lkml/20181205171039.73066-1-dennis@kernel.org/
>
> Fixes: 5cdf2e3fea5e ("blkcg: associate blkg when associating a device")
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> ---
>  block/blk-iolatency.c     | 2 +-
>  block/blk-rq-qos.h        | 5 +++++
>  include/linux/blk_types.h | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index bee092727cad..fc714ef402a6 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -593,7 +593,7 @@ static void blkcg_iolatency_done_bio(struct rq_qos *rqos, struct bio *bio)
>         bool enabled = false;
>
>         blkg = bio->bi_blkg;
> -       if (!blkg)
> +       if (!blkg || !bio_flagged(bio, BIO_TRACKED))
>                 return;
>
>         iolat = blkg_to_lat(bio->bi_blkg);
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
> index fd8a0c5debd3..58f62483b537 100644
> --- a/block/blk-rq-qos.h
> +++ b/block/blk-rq-qos.h
> @@ -170,6 +170,11 @@ static inline void rq_qos_done_bio(struct request_queue *q, struct bio *bio)
>
>  static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
>  {
> +       /*
> +        * BIO_TRACKED lets controllers know that a bio went through the
> +        * normal rq_qos path.
> +        */
> +       bio_set_flag(bio, BIO_TRACKED);
>         if (q->rq_qos)
>                 __rq_qos_throttle(q->rq_qos, bio);
>  }
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 46c005d601ac..fc99474ac968 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -228,6 +228,7 @@ struct bio {
>  #define BIO_TRACE_COMPLETION 10        /* bio_endio() should trace the final completion
>                                  * of this bio. */
>  #define BIO_QUEUE_ENTERED 11   /* can use blk_queue_enter_live() */
> +#define BIO_TRACKED 12         /* set if bio goes through the rq_qos path */
>
>  /* See BVEC_POOL_OFFSET below before adding new flags */
>
> --
> 2.17.1
>
