Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EF9C31D63
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 07:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF2320989
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 07:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfAUH2E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:28:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbfAUH2E (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 02:28:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F7A8637EB;
        Mon, 21 Jan 2019 03:52:22 +0000 (UTC)
Received: from ming.t460p (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B246B5C276;
        Mon, 21 Jan 2019 03:52:09 +0000 (UTC)
Date:   Mon, 21 Jan 2019 11:52:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, NeilBrown <neilb@suse.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] dm: fix redundant IO accounting for bios that need
 splitting
Message-ID: <20190121035203.GC24610@ming.t460p>
References: <20190119180506.1300-1-snitzer@redhat.com>
 <20190119180506.1300-3-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119180506.1300-3-snitzer@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 21 Jan 2019 03:52:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 19, 2019 at 01:05:04PM -0500, Mike Snitzer wrote:
> The risk of redundant IO accounting was not taken into consideration
> when commit 18a25da84354 ("dm: ensure bio submission follows a
> depth-first tree walk") introduced IO splitting in terms of recursion
> via generic_make_request().
> 
> Fix this by subtracting the split bio's payload from the IO stats that
> were already accounted for by start_io_acct() upon dm_make_request()
> entry.  This repeat oscillation of the IO accounting, up then down,
> isn't ideal but refactoring DM core's IO splitting to pre-split bios
> _before_ they are accounted turned out to be an excessive amount of
> change that will need a full development cycle to refine and verify.
> 
> Before this fix:
> 
>   /dev/mapper/stripe_dev is a 4-way stripe using a 32k chunksize, so
>   bios are split on 32k boundaries.
> 
>   # fio --name=16M --filename=/dev/mapper/stripe_dev --rw=write --bs=64k --size=16M \
>     	--iodepth=1 --ioengine=libaio --direct=1 --refill_buffers
> 
>   with debugging added:
>   [103898.310264] device-mapper: core: start_io_acct: dm-2 WRITE bio->bi_iter.bi_sector=0 len=128
>   [103898.318704] device-mapper: core: __split_and_process_bio: recursing for following split bio:
>   [103898.329136] device-mapper: core: start_io_acct: dm-2 WRITE bio->bi_iter.bi_sector=64 len=64
>   ...
> 
>   16M written yet 136M (278528 * 512b) accounted:
>   # cat /sys/block/dm-2/stat | awk '{ print $7 }'
>   278528
> 
> After this fix:
> 
>   16M written and 16M (32768 * 512b) accounted:
>   # cat /sys/block/dm-2/stat | awk '{ print $7 }'
>   32768
> 
> Fixes: 18a25da84354 ("dm: ensure bio submission follows a depth-first tree walk")
> Cc: stable@vger.kernel.org # 4.16+
> Reported-by: Bryan Gurney <bgurney@redhat.com>
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> ---
>  drivers/md/dm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index fcb97b0a5743..fbadda68e23b 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1584,6 +1584,9 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
>  	ci->sector = bio->bi_iter.bi_sector;
>  }
>  
> +#define __dm_part_stat_sub(part, field, subnd)	\
> +	(part_stat_get(part, field) -= (subnd))
> +
>  /*
>   * Entry point to split a bio into clones and submit them to the targets.
>   */
> @@ -1638,6 +1641,19 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
>  				struct bio *b = bio_split(bio, bio_sectors(bio) - ci.sector_count,
>  							  GFP_NOIO, &md->queue->bio_split);
>  				ci.io->orig_bio = b;
> +
> +				/*
> +				 * Adjust IO stats for each split, otherwise upon queue
> +				 * reentry there will be redundant IO accounting.
> +				 * NOTE: this is a stop-gap fix, a proper fix involves
> +				 * significant refactoring of DM core's bio splitting
> +				 * (by eliminating DM's splitting and just using bio_split)
> +				 */
> +				part_stat_lock();
> +				__dm_part_stat_sub(&dm_disk(md)->part0,
> +						   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
> +				part_stat_unlock();
> +
>  				bio_chain(b, bio);
>  				ret = generic_make_request(bio);
>  				break;

This ways is a bit ugly, but looks it works and it is simple, especially
DM target may accept partial bio, so:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
