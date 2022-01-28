Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F15EC433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 13:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiA1Ng4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:36:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49026 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiA1Ngz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 08:36:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 23E991F391;
        Fri, 28 Jan 2022 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643377014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOblvaJqmBhTr4lQmEG9HDnBnB7rk1mS6gNJ4Bj8tzk=;
        b=v+aMPcCOUHC5Snz/2Qe0OxIOWCN9DB+dqJOLsvzarIre51Hc1eA45SNY2Bf4WsB2J7OgF1
        vKAW47/vs+LeGBeuhENiv3vCnJu+TsNAPqkOT34rjWCbFl33T3DTVdOTbm7xV0u42HkEDu
        fPEMFdMqrlr/C9wbfyu7x5sqs1jvKeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643377014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOblvaJqmBhTr4lQmEG9HDnBnB7rk1mS6gNJ4Bj8tzk=;
        b=Ml2QZNQnqWTKSWgtpDEABqlCrE4YIrucSyRCXISgx+qCXGz3leICeTuRyoVmCscAqn2VOF
        OjYywm1eJKS431Aw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 14FE5A3B85;
        Fri, 28 Jan 2022 13:36:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B34FDA05A4; Fri, 28 Jan 2022 14:36:53 +0100 (CET)
Date:   Fri, 28 Jan 2022 14:36:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 3/8] loop: remove the racy bd_inode->i_mapping->nrpages
 asserts
Message-ID: <20220128133653.3zmcy73qf2y2pet2@quack3.lan>
References: <20220128130022.1750906-1-hch@lst.de>
 <20220128130022.1750906-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128130022.1750906-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 28-01-22 14:00:17, Christoph Hellwig wrote:
> Nothing prevents a file system or userspace opener of the block device
> from redirtying the page right afte sync_blockdev returned.  Fortunately
> data in the page cache during a block device change is mostly harmless
> anyway.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Darrick J. Wong <djwong@kernel.org>

OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 6ec55a5d9dfc4..d3a7f281ce1b6 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1278,15 +1278,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	/* I/O need to be drained during transfer transition */
>  	blk_mq_freeze_queue(lo->lo_queue);
>  
> -	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
> -		/* If any pages were dirtied after invalidate_bdev(), try again */
> -		err = -EAGAIN;
> -		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
> -			__func__, lo->lo_number, lo->lo_file_name,
> -			lo->lo_device->bd_inode->i_mapping->nrpages);
> -		goto out_unfreeze;
> -	}
> -
>  	prev_lo_flags = lo->lo_flags;
>  
>  	err = loop_set_status_from_info(lo, info);
> @@ -1497,21 +1488,10 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
>  	invalidate_bdev(lo->lo_device);
>  
>  	blk_mq_freeze_queue(lo->lo_queue);
> -
> -	/* invalidate_bdev should have truncated all the pages */
> -	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
> -		err = -EAGAIN;
> -		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
> -			__func__, lo->lo_number, lo->lo_file_name,
> -			lo->lo_device->bd_inode->i_mapping->nrpages);
> -		goto out_unfreeze;
> -	}
> -
>  	blk_queue_logical_block_size(lo->lo_queue, arg);
>  	blk_queue_physical_block_size(lo->lo_queue, arg);
>  	blk_queue_io_min(lo->lo_queue, arg);
>  	loop_update_dio(lo);
> -out_unfreeze:
>  	blk_mq_unfreeze_queue(lo->lo_queue);
>  
>  	return err;
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
