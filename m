Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A4FC47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 10:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEBF61246
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 10:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhFHKJ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 06:09:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58544 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhFHKJ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 06:09:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 718A41FD2A;
        Tue,  8 Jun 2021 10:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623146885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j3oQJTAxsaMlR5mofyE9iQMvOyfxks38Af2lCeJM+pE=;
        b=UYTkhhw8VtyoWojD0pjIgF+hTdPLSqwf9mV3KHnToyUTRLWi6KSofyOplH+8PJyJvyJgs4
        zVDVMcIkHmhqPBVORDlcS71zCmHIrMH4CKRcPTDGrPfsxK7O1Q20SK/XF908qzb0n1GbvG
        MVNvRdkEnFyKRMzFDi8LrTYEA1H5CIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623146885;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j3oQJTAxsaMlR5mofyE9iQMvOyfxks38Af2lCeJM+pE=;
        b=3zwlAVhwsFavHuzCBlGrIQZEqs7lSF3xJy1IxkIlLwcfYWw5tFiqVo/4BUuUWzuwbAJdaw
        nz5pVSqcJFn2idDQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 615A9A3B84;
        Tue,  8 Jun 2021 10:08:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 308F51F2C94; Tue,  8 Jun 2021 12:08:04 +0200 (CEST)
Date:   Tue, 8 Jun 2021 12:08:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jack@suse.cz,
        hare@suse.de, ming.lei@redhat.com, damien.lemoal@wdc.com
Subject: Re: [PATCH] block: check disk exist before trying to add partition
Message-ID: <20210608100804.GD5562@quack2.suse.cz>
References: <20210608092707.1062259-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608092707.1062259-1-yuyufen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 08-06-21 17:27:07, Yufen Yu wrote:
> If disk have been deleted, we should return fail for ioctl
> BLKPG_DEL_PARTITION. Otherwise, the directory /sys/class/block
> may remain invalid symlinks file. The race as following:
> 
> blkdev_open
> 				del_gendisk
> 				    disk->flags &= ~GENHD_FL_UP;
> 				    blk_drop_partitions
> blkpg_ioctl
>     bdev_add_partition
>     add_partition
>         device_add
> 	    device_add_class_symlinks
> 
> ioctl may add_partition after del_gendisk() have tried to delete
> partitions. Then, symlinks file will be created.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/partitions/core.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index dc60ecf46fe6..58662a0f48e4 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -449,17 +449,26 @@ int bdev_add_partition(struct block_device *bdev, int partno,
>  		sector_t start, sector_t length)
>  {
>  	struct block_device *part;
> +	struct gendisk *disk = bdev->bd_disk;
> +	int ret;
>  
>  	mutex_lock(&bdev->bd_mutex);
> -	if (partition_overlaps(bdev->bd_disk, start, length, -1)) {
> -		mutex_unlock(&bdev->bd_mutex);
> -		return -EBUSY;
> +	if (!(disk->flags & GENHD_FL_UP)) {
> +		ret = -ENXIO;
> +		goto out;
>  	}
>  
> -	part = add_partition(bdev->bd_disk, partno, start, length,
> +	if (partition_overlaps(disk, start, length, -1)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	part = add_partition(disk, partno, start, length,
>  			ADDPART_FLAG_NONE, NULL);
> +	ret = PTR_ERR_OR_ZERO(part);
> +out:
>  	mutex_unlock(&bdev->bd_mutex);
> -	return PTR_ERR_OR_ZERO(part);
> +	return ret;
>  }
>  
>  int bdev_del_partition(struct block_device *bdev, int partno)
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
