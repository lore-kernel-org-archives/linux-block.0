Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC38C433F5
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 04:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3411E61211
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 04:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbhJPEhA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 00:37:00 -0400
Received: from verein.lst.de ([213.95.11.211]:56709 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239469AbhJPEhA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 00:37:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B422868BEB; Sat, 16 Oct 2021 06:34:50 +0200 (CEST)
Date:   Sat, 16 Oct 2021 06:34:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] block: Fix partition check for host-aware zoned block
 devices
Message-ID: <20211016043450.GA27231@lst.de>
References: <20211015020740.506425-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015020740.506425-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 15, 2021 at 11:07:40AM +0900, Shin'ichiro Kawasaki wrote:
> To fix the issues, call the helper function disk_has_partitions() in
> place of disk->part_tbl empty check. Since the function was removed with
> the commit a33df75c6328, reimplement it to walk through entries in the
> xarray disk->part_tbl.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Matthew,

we talked about possiblig adding a xa_nr_entries helper a while ago.
This would be a good place for it, as we could just check
xa_nr_entries() > 1 for example.

> 
> Fixes: a33df75c6328 ("block: use an xarray for disk->part_tbl")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org # v5.14+
> ---
>  block/blk-settings.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index a7c857ad7d10..b880c70e22e4 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -842,6 +842,24 @@ bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
>  }
>  EXPORT_SYMBOL_GPL(blk_queue_can_use_dma_map_merging);
>  
> +static bool disk_has_partitions(struct gendisk *disk)
> +{
> +	unsigned long idx;
> +	struct block_device *part;
> +	bool ret = false;
> +
> +	rcu_read_lock();
> +	xa_for_each(&disk->part_tbl, idx, part) {
> +		if (bdev_is_partition(part)) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
>  /**
>   * blk_queue_set_zoned - configure a disk queue zoned model.
>   * @disk:	the gendisk of the queue to configure
> @@ -876,7 +894,7 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>  		 * we do nothing special as far as the block layer is concerned.
>  		 */
>  		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) ||
> -		    !xa_empty(&disk->part_tbl))
> +		    disk_has_partitions(disk))
>  			model = BLK_ZONED_NONE;
>  		break;
>  	case BLK_ZONED_NONE:
> -- 
> 2.31.1
---end quoted text---
