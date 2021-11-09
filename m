Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E816CC433EF
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 11:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C879361131
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 11:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhKIMCL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 07:02:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51486 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhKIMCL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 07:02:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C349B1FDB7;
        Tue,  9 Nov 2021 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636459164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwKG7otL2FXmdoHGQWqnjHnXRP352DKPh3S+Ed8DBTU=;
        b=w88c8FOkBlXCoe6x9y2oRiO6ikMUIsLU34heUTCs9M5i9ktYZUeagK4i/nbGDI+3KGIq7A
        JZ+bhZ1gr3IMEf1EU5PjkMkcCQK5SO9LkrvhQ8OT6xmGJKHJJZtZHmhxDThGODGSpFwa3e
        6m2BdXag4SXN8Wnj9xw6gQtgHQcey5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636459164;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwKG7otL2FXmdoHGQWqnjHnXRP352DKPh3S+Ed8DBTU=;
        b=AfO7PD48cbeSCL9GTW2JFPzwu15tF6pZ4Z+GXt+yXkJjMdgsEj5AbDoefzQuDRshKKFe0q
        uDWf6vIT0PpeuVAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B1359A3B8A;
        Tue,  9 Nov 2021 11:59:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 688D31E14ED; Tue,  9 Nov 2021 12:59:22 +0100 (CET)
Date:   Tue, 9 Nov 2021 12:59:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 1/2] block: Hold invalidate_lock in BLKDISCARD ioctl
Message-ID: <20211109115922.GD5955@quack2.suse.cz>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
 <20211109104723.835533-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109104723.835533-2-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 09-11-21 19:47:22, Shin'ichiro Kawasaki wrote:
> When BLKDISCARD ioctl and data read race, the data read leaves stale
> page cache. To avoid the stale page cache, hold invalidate_lock of the
> block device file mapping. The stale page cache is observed when
> blktests test case block/009 is repeated hundreds of times.
> 
> This patch can be applied back to the stable kernel version v5.15.y
> with slight patch edit. Rework is required for older stable kernels.
> 
> Fixes: 351499a172c0 ("block: Invalidate cache on discard v2")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org # v5.15

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/ioctl.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/block/ioctl.c b/block/ioctl.c
> index d6af0ac97e57..9fa87f64f703 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -113,6 +113,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
>  	uint64_t range[2];
>  	uint64_t start, len;
>  	struct request_queue *q = bdev_get_queue(bdev);
> +	struct inode *inode = bdev->bd_inode;
>  	int err;
>  
>  	if (!(mode & FMODE_WRITE))
> @@ -135,12 +136,17 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
>  	if (start + len > bdev_nr_bytes(bdev))
>  		return -EINVAL;
>  
> +	filemap_invalidate_lock(inode->i_mapping);
>  	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
>  	if (err)
> -		return err;
> +		goto fail;
> +
> +	err = blkdev_issue_discard(bdev, start >> 9, len >> 9,
> +				   GFP_KERNEL, flags);
>  
> -	return blkdev_issue_discard(bdev, start >> 9, len >> 9,
> -				    GFP_KERNEL, flags);
> +fail:
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	return err;
>  }
>  
>  static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
> -- 
> 2.33.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
