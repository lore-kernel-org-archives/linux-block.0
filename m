Return-Path: <SRS0=aEt0=ZG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E6FC432C3
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 13:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468FA206DC
	for <linux-block@archiver.kernel.org>; Thu, 14 Nov 2019 13:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfKNN27 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:28:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:52830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbfKNN27 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 08:28:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63694AD6B;
        Thu, 14 Nov 2019 13:28:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 21E491E4331; Thu, 14 Nov 2019 14:28:52 +0100 (CET)
Date:   Thu, 14 Nov 2019 14:28:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move rescan_partitions to fs/block_dev.c
Message-ID: <20191114132852.GH28486@quack2.suse.cz>
References: <20191106151439.30056-1-hch@lst.de>
 <20191106151439.30056-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106151439.30056-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 06-11-19 16:14:37, Christoph Hellwig wrote:
> Large parts of rescan_partitions aren't about partitions, and
> moving it to block_dev.c will allow for some further cleanups by
> merging it into its only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/partition-generic.c | 37 ++-----------------------------------
>  fs/block_dev.c            | 38 ++++++++++++++++++++++++++++++++++++--
>  include/linux/fs.h        |  2 --
>  include/linux/genhd.h     |  4 ++--
>  4 files changed, 40 insertions(+), 41 deletions(-)
> 
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index eae9daa8a523..7a6e406ac490 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -439,7 +439,7 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
>  	}
>  }
>  
> -static int drop_partitions(struct gendisk *disk, struct block_device *bdev)
> +int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)
>  {
>  	struct disk_part_iter piter;
>  	struct hd_struct *part;
> @@ -573,7 +573,7 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
>  	return true;
>  }
>  
> -static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
> +int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
>  {
>  	struct parsed_partitions *state;
>  	int ret = -EAGAIN, p, highest;
> @@ -632,39 +632,6 @@ static int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
>  	return ret;
>  }
>  
> -int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
> -		bool invalidate)
> -{
> -	int ret;
> -
> -rescan:
> -	ret = drop_partitions(disk, bdev);
> -	if (ret)
> -		return ret;
> -
> -	if (invalidate)
> -		set_capacity(disk, 0);
> -	else if (disk->fops->revalidate_disk)
> -		disk->fops->revalidate_disk(disk);
> -
> -	check_disk_size_change(disk, bdev, !invalidate);
> -	bdev->bd_invalidated = 0;
> -
> -	if (!get_capacity(disk)) {
> -		/*
> -		 * Tell userspace that the media / partition table may have
> -		 * changed.
> -		 */
> -		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
> -		return 0;
> -	}
> -	
> -	ret = blk_add_partitions(disk, bdev);
> -	if (ret == -EAGAIN)
> -		goto rescan;
> -	return ret;
> -}
> -
>  unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
>  {
>  	struct address_space *mapping = bdev->bd_inode->i_mapping;
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 0af62b76d031..f0710085e1f1 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1416,8 +1416,8 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
>   * and adjusts it if it differs. When shrinking the bdev size, its all caches
>   * are freed.
>   */
> -void check_disk_size_change(struct gendisk *disk, struct block_device *bdev,
> -		bool verbose)
> +static void check_disk_size_change(struct gendisk *disk,
> +		struct block_device *bdev, bool verbose)
>  {
>  	loff_t disk_size, bdev_size;
>  
> @@ -1508,6 +1508,40 @@ EXPORT_SYMBOL(bd_set_size);
>  
>  static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
>  
> +static int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
> +		bool invalidate)
> +{
> +	int ret;
> +
> +rescan:
> +	ret = blk_drop_partitions(disk, bdev);
> +	if (ret)
> +		return ret;
> +
> +	if (invalidate)
> +		set_capacity(disk, 0);
> +	else if (disk->fops->revalidate_disk)
> +		disk->fops->revalidate_disk(disk);
> +
> +	check_disk_size_change(disk, bdev, !invalidate);
> +	bdev->bd_invalidated = 0;
> +
> +	if (!get_capacity(disk)) {
> +		/*
> +		 * Tell userspace that the media / partition table may have
> +		 * changed.
> +		 */
> +		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
> +		return 0;
> +	}
> +	
> +	ret = blk_add_partitions(disk, bdev);
> +	if (ret == -EAGAIN)
> +		goto rescan;
> +	return ret;
> +}
> +
> +
>  static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
>  {
>  	if (disk_part_scan_enabled(bdev->bd_disk)) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e0d909d35763..d233dd661df7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2703,8 +2703,6 @@ extern void make_bad_inode(struct inode *);
>  extern bool is_bad_inode(struct inode *);
>  
>  #ifdef CONFIG_BLOCK
> -extern void check_disk_size_change(struct gendisk *disk,
> -		struct block_device *bdev, bool verbose);
>  extern int revalidate_disk(struct gendisk *);
>  extern int check_disk_change(struct block_device *);
>  extern int __invalidate_device(struct block_device *, bool);
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index fd7774e64f0b..f5cffbf63abf 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -621,9 +621,9 @@ extern void blk_invalidate_devt(dev_t devt);
>  extern dev_t blk_lookup_devt(const char *name, int partno);
>  extern char *disk_name (struct gendisk *hd, int partno, char *buf);
>  
> +int blk_add_partitions(struct gendisk *disk, struct block_device *bdev);
> +int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev);
>  extern int disk_expand_part_tbl(struct gendisk *disk, int target);
> -int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
> -		bool invalidate);
>  extern struct hd_struct * __must_check add_partition(struct gendisk *disk,
>  						     int partno, sector_t start,
>  						     sector_t len, int flags,
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
