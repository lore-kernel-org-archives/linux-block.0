Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721DFC433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 08:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKCIMR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 04:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKCIMQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 04:12:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B887B1;
        Thu,  3 Nov 2022 01:12:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1C23868AA6; Thu,  3 Nov 2022 09:12:12 +0100 (CET)
Date:   Thu, 3 Nov 2022 09:12:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH 2/2] block: fix use after free for bd_holder_dir
Message-ID: <20221103081211.GB3346@lst.de>
References: <20221103025541.1875809-1-yukuai1@huaweicloud.com> <20221103025541.1875809-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103025541.1875809-3-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 03, 2022 at 10:55:41AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, the caller of bd_link_disk_holer() get 'bdev' by
> blkdev_get_by_dev(), which will look up 'bdev' by inode number 'dev'.
> Howerver, it's possible that del_gendisk() can be called currently, and
> 'bd_holder_dir' can be freed before bd_link_disk_holer() access it, thus
> use after free is triggered.
> 
> t1:				t2:
> bdev = blkdev_get_by_dev
> 				del_gendisk
> 				 kobject_put(bd_holder_dir)
> 				  kobject_free()
> bd_link_disk_holder
> 
> Fix the problem by checking disk is still live and grabbing a reference
> to 'bd_holder_dir' first in bd_link_disk_holder().

Looks good with some minor stilistic nipicks:

> +	if (!disk_live(bdev->bd_disk)) {
> +		mutex_unlock(&bdev->bd_disk->open_mutex);
> +		return -ENODEV;
> +	}

This can use a goto out_unlock;

>  		holder->refcnt++;
> +		kobject_put(bdev->bd_holder_dir);
>  		goto out_unlock;
>  	}
>  
>  	holder = kzalloc(sizeof(*holder), GFP_KERNEL);
>  	if (!holder) {
>  		ret = -ENOMEM;
> +		kobject_put(bdev->bd_holder_dir);
>  		goto out_unlock;
>  	}
>  
> @@ -101,16 +114,12 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>  		ret = __link_disk_holder(bdev, disk);
>  		if (ret) {
>  			kfree(holder);
> +			kobject_put(bdev->bd_holder_dir);

And I think a goto out_put_holder and out_free_holder would clean this up
nicely.

>  	list_add(&holder->list, &disk->slave_bdevs);
> -	/*
> -	 * del_gendisk drops the initial reference to bd_holder_dir, so we need
> -	 * to keep our own here to allow for cleanup past that point.
> -	 */
> -	kobject_get(bdev->bd_holder_dir);

.. with this then jumping straight to out_unlock.


We should repost a series with my first 7 patches and your two.  I can do
that, but it might take some time as I just got through (minor) knee
surgery and am still at the hospital, so if you have spare cycles feel
free to do it.
