Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72133C07E94
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 14:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5414E6140C
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 14:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhFDO7d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jun 2021 10:59:33 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:36694 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFDO7d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 10:59:33 -0400
Received: by mail-qk1-f170.google.com with SMTP id i68so6017645qke.3
        for <linux-block@vger.kernel.org>; Fri, 04 Jun 2021 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EapXRX7qql2t5NiRCxLGNSnGSE7Dr4V6203P39laPVo=;
        b=Zl1hjpc/OWGsziQ5IyxLiQFbnPSRpHrVuRRMU4qHDM2/6GDsftAgzwmXQCnkPWg3y+
         hyiHnPBO2exEDCfemTluLcV4AXxVePntKZf+5g3Z9WWFt/mPnMtwlAE9pC3BTm36ejcL
         qfUaSiJXDoMImWLlMht8Cr/H3l6YKZsF06tKybF/c/RzqoPrXDm38HtUy9LK7NczzxxZ
         z+/TrLhu7ljZpi2QPKrcyElm4xj0zZFZBAh2e2G8cgj+RALfkmW8K8dibKWM378Ryjej
         +KD9cYCnQREeOe2Mv5jO9DMY0lDPuAWGoWYe/FrAC9hdGyt1yoFy3YFuGhSlQE6bNrRj
         v0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EapXRX7qql2t5NiRCxLGNSnGSE7Dr4V6203P39laPVo=;
        b=Fb8R0iR2afxdXY4Bj8SM45QIYNgBhcn45WSsCJ5Dr/qsvShA48Rxboh6nGnh2P/nft
         ChrayqgbBHyZM4VE45igfDUDFdt4J+RhOPhzaDqMyJN1i++sPW2ZP1ZbkD9wUVxqhWNQ
         bGHb9VsgfMQ3pGBuCAVkwfN/daEY7jl15CtR9M5UCrvuLhAfqJf5k0GnryhOGtyQ6JLu
         RynNK7hNNT4dzoPW60DP5SOSIXWNI11sw4rF77u6D3tvdbWgC48aWUjINyeL0QkqapYU
         niZydIlIfRB8lcB8Xs/Os71JzydyzH9ewnLWcm59C4+KOxuIBnSD1RjN0MoeF9Okx4hA
         fyJA==
X-Gm-Message-State: AOAM532n+jtEqNbMLH5AwvTAJZfFjBFYYT0bKNhmeiEF/6O7NIdAPb5P
        0gkWdWpogB4gU6TkzdsknBuBRGrQLyc=
X-Google-Smtp-Source: ABdhPJz6/z6e+EgsHYGDYUsKt8ZrSz5fJbQL+2toCpf6BzaXBJV/8e0HBaIJ8Y3mqC56GLU87PDYRg==
X-Received: by 2002:a05:620a:30d:: with SMTP id s13mr4761020qkm.58.1622818606772;
        Fri, 04 Jun 2021 07:56:46 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id p14sm4154956qki.27.2021.06.04.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:56:45 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Fri, 4 Jun 2021 10:56:44 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5 08/11] dm: Forbid requeue of writes to zones
Message-ID: <YLo/LO32+rdrfygC@redhat.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
 <20210525212501.226888-9-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525212501.226888-9-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 25 2021 at  5:24P -0400,
Damien Le Moal <damien.lemoal@wdc.com> wrote:

> A target map method requesting the requeue of a bio with
> DM_MAPIO_REQUEUE or completing it with DM_ENDIO_REQUEUE can cause
> unaligned write errors if the bio is a write operation targeting a
> sequential zone. If a zoned target request such a requeue, warn about
> it and kill the IO.
> 
> The function dm_is_zone_write() is introduced to detect write operations
> to zoned targets.
> 
> This change does not affect the target drivers supporting zoned devices
> and exposing a zoned device, namely dm-crypt, dm-linear and dm-flakey as
> none of these targets ever request a requeue.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> ---
>  drivers/md/dm-zone.c | 17 +++++++++++++++++
>  drivers/md/dm.c      | 18 +++++++++++++++---
>  drivers/md/dm.h      |  5 +++++
>  3 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index b42474043249..edc3bbb45637 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -104,6 +104,23 @@ int dm_report_zones(struct block_device *bdev, sector_t start, sector_t sector,
>  }
>  EXPORT_SYMBOL_GPL(dm_report_zones);
>  
> +bool dm_is_zone_write(struct mapped_device *md, struct bio *bio)
> +{
> +	struct request_queue *q = md->queue;
> +
> +	if (!blk_queue_is_zoned(q))
> +		return false;
> +
> +	switch (bio_op(bio)) {
> +	case REQ_OP_WRITE_ZEROES:
> +	case REQ_OP_WRITE_SAME:
> +	case REQ_OP_WRITE:
> +		return !op_is_flush(bio->bi_opf) && bio_sectors(bio);
> +	default:
> +		return false;
> +	}
> +}
> +
>  void dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
>  {
>  	if (!blk_queue_is_zoned(q))
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index c49976cc4e44..ed8c5a8df2e5 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -846,11 +846,15 @@ static void dec_pending(struct dm_io *io, blk_status_t error)
>  			 * Target requested pushing back the I/O.
>  			 */
>  			spin_lock_irqsave(&md->deferred_lock, flags);
> -			if (__noflush_suspending(md))
> +			if (__noflush_suspending(md) &&
> +			    !WARN_ON_ONCE(dm_is_zone_write(md, bio)))
>  				/* NOTE early return due to BLK_STS_DM_REQUEUE below */
>  				bio_list_add_head(&md->deferred, io->orig_bio);
>  			else
> -				/* noflush suspend was interrupted. */
> +				/*
> +				 * noflush suspend was interrupted or this is
> +				 * a write to a zoned target.
> +				 */
>  				io->status = BLK_STS_IOERR;
>  			spin_unlock_irqrestore(&md->deferred_lock, flags);
>  		}

So I now see this incremental fix:
https://patchwork.kernel.org/project/dm-devel/patch/20210604004703.408562-1-damien.lemoal@opensource.wdc.com/

And I've folded it in...

> @@ -947,7 +951,15 @@ static void clone_endio(struct bio *bio)
>  		int r = endio(tio->ti, bio, &error);
>  		switch (r) {
>  		case DM_ENDIO_REQUEUE:
> -			error = BLK_STS_DM_REQUEUE;
> +			/*
> +			 * Requeuing writes to a sequential zone of a zoned
> +			 * target will break the sequential write pattern:
> +			 * fail such IO.
> +			 */
> +			if (WARN_ON_ONCE(dm_is_zone_write(md, bio)))
> +				error = BLK_STS_IOERR;
> +			else
> +				error = BLK_STS_DM_REQUEUE;
>  			fallthrough;
>  		case DM_ENDIO_DONE:
>  			break;

But I'm left wondering why dec_pending, now dm_io_dec_pending, needs
to be modified to also check dm_is_zone_write() if clone_endio() is
already dealing with it?

Not that big a deal, just not loving how we're sprinkling special
zoned code around...

Mike
