Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E03C5DF60
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 09:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1C22085B
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 09:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbfKGJsz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:48:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:38226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387964AbfKGJsz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Nov 2019 04:48:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2A76B132;
        Thu,  7 Nov 2019 09:48:49 +0000 (UTC)
Subject: Re: [PATCH 3/5] block: move rescan_partitions to fs/block_dev.c
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
References: <20191106151439.30056-1-hch@lst.de>
 <20191106151439.30056-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <fa144fed-bde9-1602-b94a-32f9fbf235c4@suse.de>
Date:   Thu, 7 Nov 2019 10:48:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191106151439.30056-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/6/19 4:14 PM, Christoph Hellwig wrote:
> Large parts of rescan_partitions aren't about partitions, and
> moving it to block_dev.c will allow for some further cleanups by
> merging it into its only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
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

... see my comments in the previous patch to drop get_capacity() and
have check_disk_size_change() return bool ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
