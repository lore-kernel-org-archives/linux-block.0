Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FF1C3DA6E
	for <linux-block@archiver.kernel.org>; Fri, 23 Dec 2022 06:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLWGAP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Dec 2022 01:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWGAO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Dec 2022 01:00:14 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626E640D
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 22:00:14 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 35F626732D; Fri, 23 Dec 2022 07:00:10 +0100 (CET)
Date:   Fri, 23 Dec 2022 07:00:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: save user max_sectors limit
Message-ID: <20221223060009.GA3088@lst.de>
References: <20221222175204.1782061-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222175204.1782061-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 22, 2022 at 09:52:04AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The user can set the max_sectors limit to any valid value via sysfs
> /sys/block/<dev>/queue/max_sectors_kb attribute. If the device limits
> are ever rescanned, though, the limit reverts back to the kernel defined
> BLK_DEF_MAX_SECTORS limit.
> 
> Preserve the user's setting for the max_sectors limit as long as it's
> valid. The user can reset back to defaults by writing 0 to the sysfs
> file.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-settings.c   |  9 +++++++--
>  block/blk-sysfs.c      | 10 +++++++++-
>  include/linux/blkdev.h |  1 +
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 0477c4d527fee..e75304f853bd5 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -40,7 +40,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->virt_boundary_mask = 0;
>  	lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
>  	lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
> -	lim->max_dev_sectors = 0;
> +	lim->max_user_sectors = lim->max_dev_sectors = 0;
>  	lim->chunk_sectors = 0;
>  	lim->max_write_zeroes_sectors = 0;
>  	lim->max_zone_append_sectors = 0;
> @@ -135,7 +135,12 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>  	limits->max_hw_sectors = max_hw_sectors;
>  
>  	max_sectors = min_not_zero(max_hw_sectors, limits->max_dev_sectors);
> -	max_sectors = min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
> +
> +	if (limits->max_user_sectors)
> +		max_sectors = min_not_zero(max_sectors, limits->max_user_sectors);

I don't think the min_not_zero here makes sense, as you just checked
max_user_sectors for zero above, and max_sectors better not be zero.

> +	else
> +		max_sectors = min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);

And please make BLK_DEF_MAX_SECTORS an unsigned constant as it should be
and drop the min_t here.  Instead of working around type mismatches
just avoid them from the beginning..

> +	if (max_sectors_kb == 0) {
> +		q->limits.max_user_sectors = 0;
> +		max_sectors_kb = min_t(unsigned int, max_hw_sectors_kb,
> +				       BLK_DEF_MAX_SECTORS >> 1);

.. which will also pay off here.

> +	} else if (max_sectors_kb > max_hw_sectors_kb ||
> +		   max_sectors_kb < page_kb)  {
>  		return -EINVAL;

And this check should probably move above the old one to keep the
sanity checks first.

> +	} else {
> +		q->limits.max_user_sectors = max_sectors_kb << 1;
> +	}

i.e.

	if (max_sectors_kb > max_hw_sectors_kb || max_sectors_kb < page_kb)
		return -EINVAL;

	q->limits.max_user_sectors = max_sectors_kb << 1;

	/* reset to default when the user clears max_sectors_kb: */
	if (max_sectors_kb == 0) {
		max_sectors_kb =
			min(max_hw_sectors_kb, BLK_DEF_MAX_SECTORS >> 1);
	}
