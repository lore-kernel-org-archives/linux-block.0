Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07082C433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 06:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DEF60E76
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 06:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbhJ0Gri (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 02:47:38 -0400
Received: from verein.lst.de ([213.95.11.211]:36468 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231530AbhJ0Gri (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 02:47:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A7ED67373; Wed, 27 Oct 2021 08:45:11 +0200 (CEST)
Date:   Wed, 27 Oct 2021 08:45:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2] block: Fix partition check for host-aware zoned
 block devices
Message-ID: <20211027064511.GA10749@lst.de>
References: <20211026060115.753746-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026060115.753746-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

can you pick this up for 5.15?  It fixes a nasty regression.

On Tue, Oct 26, 2021 at 03:01:15PM +0900, Shin'ichiro Kawasaki wrote:
> Commit a33df75c6328 ("block: use an xarray for disk->part_tbl") modified
> the method to check partition existence in host-aware zoned block
> devices from disk_has_partitions() helper function call to empty check
> of xarray disk->part_tbl. However, disk->part_tbl always has single
> entry for disk->part0 and never becomes empty. This resulted in the
> host-aware zoned devices always judged to have partitions, and it made
> the sysfs queue/zoned attribute to be "none" instead of "host-aware"
> regardless of partition existence in the devices.
> 
> This also caused DEBUG_LOCKS_WARN_ON(lock->magic != lock) for
> sdkp->rev_mutex in scsi layer when the kernel detects host-aware zoned
> device. Since block layer handled the host-aware zoned devices as non-
> zoned devices, scsi layer did not have chance to initialize the mutex
> for zone revalidation. Therefore, the warning was triggered.
> 
> To fix the issues, call the helper function disk_has_partitions() in
> place of disk->part_tbl empty check. Since the function was removed with
> the commit a33df75c6328, reimplement it to walk through entries in the
> xarray disk->part_tbl.
> 
> Fixes: a33df75c6328 ("block: use an xarray for disk->part_tbl")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org # v5.14+
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> Changes from v1:
> * Added Reviewed-by tags
> 
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
