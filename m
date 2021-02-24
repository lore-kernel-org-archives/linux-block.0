Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF011C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 01:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736D164E7A
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 01:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhBXBlE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 20:41:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232050AbhBXBlD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 20:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614130776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VZuELx3YPIz0q6Av5RIhb7o/L20RAqonrzXYZvGp11k=;
        b=MDqmV06eZXoQc8ol9otNYqyp7gq0antJyTT/jlRl1QUjojM9Tzcn6U6t/j7LZLc003mcBb
        0d07aMs6eGbvXJpKuXlZBthpu4yzqXQWJQ2cKH6NohxmIBy6WMlve8fT3LGUYRLkyVXkbK
        YZ9whbRxflUo7mWFjUPN2Yn/HLhkjcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-zVEFquoONYiWZ4hVboyUgg-1; Tue, 23 Feb 2021 20:39:02 -0500
X-MC-Unique: zVEFquoONYiWZ4hVboyUgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D3F1100CCC2;
        Wed, 24 Feb 2021 01:39:01 +0000 (UTC)
Received: from T590 (ovpn-13-84.pek2.redhat.com [10.72.13.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EF8C2C01F;
        Wed, 24 Feb 2021 01:38:55 +0000 (UTC)
Date:   Wed, 24 Feb 2021 09:38:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Tom Seewald <tseewald@gmail.com>
Subject: Re: [PATCH] block: reopen the device in blkdev_reread_part
Message-ID: <YDWuKk3SkyMCFfci@T590>
References: <20210223151822.399791-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223151822.399791-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 23, 2021 at 04:18:22PM +0100, Christoph Hellwig wrote:
> Historically the BLKRRPART ioctls called into the now defunct ->revalidate
> method, which caused the sd driver to check if any media is present.
> When the ->revalidate method was removed this revalidation was lost,
> leading to lots of I/O errors when using the eject command.  Fix this by
> reopening the device to rescan the partitions, and thus calling the
> revalidation logic in the sd driver.
> 
> Fixes: 471bd0af544b ("sd: use bdev_check_media_change")
> Reported--by: Tom Seewald <tseewald@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Tom Seewald <tseewald@gmail.com>
> ---
>  block/ioctl.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index d61d652078f41c..ff241e663c018f 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -81,20 +81,27 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
>  }
>  #endif
>  
> -static int blkdev_reread_part(struct block_device *bdev)
> +static int blkdev_reread_part(struct block_device *bdev, fmode_t mode)
>  {
> -	int ret;
> +	struct block_device *tmp;
>  
>  	if (!disk_part_scan_enabled(bdev->bd_disk) || bdev_is_partition(bdev))
>  		return -EINVAL;
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EACCES;
>  
> -	mutex_lock(&bdev->bd_mutex);
> -	ret = bdev_disk_changed(bdev, false);
> -	mutex_unlock(&bdev->bd_mutex);
> +	/*
> +	 * Reopen the device to revalidate the driver state and force a
> +	 * partition rescan.
> +	 */
> +	mode &= ~FMODE_EXCL;
> +	set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
>  
> -	return ret;
> +	tmp = blkdev_get_by_dev(bdev->bd_dev, mode, NULL);
> +	if (IS_ERR(tmp))
> +		return PTR_ERR(tmp);
> +	blkdev_put(tmp, mode);
> +	return 0;
>  }
>  
>  static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
> @@ -498,7 +505,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>  		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
>  		return 0;
>  	case BLKRRPART:
> -		return blkdev_reread_part(bdev);
> +		return blkdev_reread_part(bdev, mode);
>  	case BLKTRACESTART:
>  	case BLKTRACESTOP:
>  	case BLKTRACETEARDOWN:
> -- 
> 2.29.2
> 

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming

