Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2741C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 20:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8D62082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 20:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8D62082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeLDU2K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:28:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeLDU2K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 15:28:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CEECBDD1;
        Tue,  4 Dec 2018 20:28:09 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1B9B5C21C;
        Tue,  4 Dec 2018 20:28:08 +0000 (UTC)
Date:   Tue, 4 Dec 2018 15:28:07 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 05/14] dm: set the static flush bio device on demand
Message-ID: <20181204202807.GA4689@redhat.com>
References: <20181204183600.99746-1-dennis@kernel.org>
 <20181204183600.99746-6-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204183600.99746-6-dennis@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 04 Dec 2018 20:28:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04 2018 at  1:35pm -0500,
Dennis Zhou <dennis@kernel.org> wrote:

> The next patch changes the macro bio_set_dev() to associate a bio with a
> blkg based on the device set. However, dm creates a static bio to be
> used as the basis for cloning empty flush bios on creation. The
> bio_set_dev() call in alloc_dev() will cause problems with the next
> patch adding association to bio_set_dev() because the call is before the
> bdev is associated with a gendisk (bd_disk is %NULL). To get around
> this, set the device on the static bio every time and use that to clone
> to the other bios.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> ---
>  block/bio.c     |  1 +
>  drivers/md/dm.c | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 452b8e79b998..41ebb3f8e2fc 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -2021,6 +2021,7 @@ void bio_disassociate_blkg(struct bio *bio)
>  		bio->bi_blkg = NULL;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(bio_disassociate_blkg);
>  
>  /**
>   * __bio_associate_blkg - associate a bio with the a blkg
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index a733e4c920af..a2d6f8b33d23 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1417,10 +1417,21 @@ static int __send_empty_flush(struct clone_info *ci)
>  	unsigned target_nr = 0;
>  	struct dm_target *ti;
>  
> +	/*
> +	 * Empty flush uses a statically initialized bio as the base for
> +	 * cloning, &md->flush_bio.  However, blkg association requires that

Would prefer:
"Empty flush uses a statically initialized bio, &md->flush_bio, as the
base for cloning.  ..."

> +	 * a bdev is associated with a gendisk, which doesn't happen until the
> +	 * bdev is opened.  So, blkg association is done at issue time of the
> +	 * flush rather than when the device is created in dm_alloc().

Another nit but I think you mean "alloc_dev()" here .......^

> +	 */
> +	bio_set_dev(ci->bio, ci->io->md->bdev);
> +
>  	BUG_ON(bio_has_data(ci->bio));
>  	while ((ti = dm_table_get_target(ci->map, target_nr++)))
>  		__send_duplicate_bios(ci, ti, ti->num_flush_bios, NULL);
>  
> +	bio_disassociate_blkg(ci->bio);
> +
>  	return 0;
>  }
>  
> @@ -1939,7 +1950,6 @@ static struct mapped_device *alloc_dev(int minor)
>  		goto bad;
>  
>  	bio_init(&md->flush_bio, NULL, 0);
> -	bio_set_dev(&md->flush_bio, md->bdev);
>  	md->flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC;
>  
>  	dm_stats_init(&md->stats);

The top-level DM device's bdev->bd_disk is only assigned after the first
blkdev_get(), so I can see why this is needed.

Think this type of life-cycle quirk was the kind of thing that caused
blk cgroup issues with DM.

Left wondering whether there would be a better way of handling N flush
bios for DM devices.  But for the now this will have to do.

Acked-by: Mike Snitzer <snitzer@redhat.com>

Thanks,
Mike
