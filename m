Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857A9C432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 13:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CA920725
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 13:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKNN0B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:26:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:51592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfKNN0B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 08:26:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4610CAEC4;
        Thu, 14 Nov 2019 13:25:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 248F91E4331; Thu, 14 Nov 2019 14:25:55 +0100 (CET)
Date:   Thu, 14 Nov 2019 14:25:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/5] block: merge invalidate_partitions into
 rescan_partitions
Message-ID: <20191114132555.GG28486@quack2.suse.cz>
References: <20191106151439.30056-1-hch@lst.de>
 <20191106151439.30056-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106151439.30056-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 06-11-19 16:14:36, Christoph Hellwig wrote:
> A lot of the logic in invalidate_partitions and invalidate_partitions
			^^ rescan_partitions as others already mentioned

> is shared.  Merge the two functions to simplify things.  There is
> a small behavior change in that we now send the keven change notice
						  ^^^ kevent

> also if we were not invalidating but no partitions were found, which
> seems like the right thing to do.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Otherwise the patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  block/ioctl.c             |  2 +-
>  block/partition-generic.c | 38 ++++++++++++++------------------------
>  fs/block_dev.c            |  5 +----
>  include/linux/genhd.h     |  4 ++--
>  4 files changed, 18 insertions(+), 31 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 15a0eb80ada9..8a7e33ce2097 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -171,7 +171,7 @@ int __blkdev_reread_part(struct block_device *bdev)
>  
>  	lockdep_assert_held(&bdev->bd_mutex);
>  
> -	return rescan_partitions(disk, bdev);
> +	return rescan_partitions(disk, bdev, false);
>  }
>  EXPORT_SYMBOL(__blkdev_reread_part);
>  
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index f113be069b40..eae9daa8a523 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -632,7 +632,8 @@ static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
>  	return ret;
>  }
>  
> -int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
> +int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
> +		bool invalidate)
>  {
>  	int ret;
>  
> @@ -641,13 +642,22 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
>  	if (ret)
>  		return ret;
>  
> -	if (disk->fops->revalidate_disk)
> +	if (invalidate)
> +		set_capacity(disk, 0);
> +	else if (disk->fops->revalidate_disk)
>  		disk->fops->revalidate_disk(disk);
> -	check_disk_size_change(disk, bdev, true);
> +
> +	check_disk_size_change(disk, bdev, !invalidate);
>  	bdev->bd_invalidated = 0;
>  
> -	if (!get_capacity(disk))
> +	if (!get_capacity(disk)) {
> +		/*
> +		 * Tell userspace that the media / partition table may have
> +		 * changed.
> +		 */
> +		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
>  		return 0;
> +	}
>  	
>  	ret = blk_add_partitions(disk, bdev);
>  	if (ret == -EAGAIN)
> @@ -655,26 +665,6 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev)
>  	return ret;
>  }
>  
> -int invalidate_partitions(struct gendisk *disk, struct block_device *bdev)
> -{
> -	int res;
> -
> -	if (!bdev->bd_invalidated)
> -		return 0;
> -
> -	res = drop_partitions(disk, bdev);
> -	if (res)
> -		return res;
> -
> -	set_capacity(disk, 0);
> -	check_disk_size_change(disk, bdev, false);
> -	bdev->bd_invalidated = 0;
> -	/* tell userspace that the media / partition table may have changed */
> -	kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
> -
> -	return 0;
> -}
> -
>  unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
>  {
>  	struct address_space *mapping = bdev->bd_inode->i_mapping;
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index d612468ee66b..0af62b76d031 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1511,10 +1511,7 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
>  static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
>  {
>  	if (disk_part_scan_enabled(bdev->bd_disk)) {
> -		if (invalidate)
> -			invalidate_partitions(bdev->bd_disk, bdev);
> -		else
> -			rescan_partitions(bdev->bd_disk, bdev);
> +		rescan_partitions(bdev->bd_disk, bdev, invalidate);
>  	} else {
>  		check_disk_size_change(bdev->bd_disk, bdev, !invalidate);
>  		bdev->bd_invalidated = 0;
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 8b5330dd5ac0..fd7774e64f0b 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -622,8 +622,8 @@ extern dev_t blk_lookup_devt(const char *name, int partno);
>  extern char *disk_name (struct gendisk *hd, int partno, char *buf);
>  
>  extern int disk_expand_part_tbl(struct gendisk *disk, int target);
> -extern int rescan_partitions(struct gendisk *disk, struct block_device *bdev);
> -extern int invalidate_partitions(struct gendisk *disk, struct block_device *bdev);
> +int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
> +		bool invalidate);
>  extern struct hd_struct * __must_check add_partition(struct gendisk *disk,
>  						     int partno, sector_t start,
>  						     sector_t len, int flags,
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
