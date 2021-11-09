Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC1C433F5
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 11:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 818F3611BF
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 11:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhKIMC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 07:02:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51504 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhKIMCZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 07:02:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5DAFF1FDBC;
        Tue,  9 Nov 2021 11:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636459179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xK5Pl+mvsRPm/q9GhLK3H4NJo/ZtqLhPc9Z59Q9yL2c=;
        b=eU1p14RGS6E6uni7EVmitNSJy4L0pqahuxfQqA3458mp2dwl5ld7wP0YadUO/fNFQU666b
        v/hKS8TzLkYmA1wq6hrZ2YPAxI4PPPSOPzkJ5NTfgFomE2m8mZnmfbhy9LS94c4U4eE89D
        vI0kqK7rEGvW9H3f+A20Z8Fnoui3hes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636459179;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xK5Pl+mvsRPm/q9GhLK3H4NJo/ZtqLhPc9Z59Q9yL2c=;
        b=1B8c5o1zWwH6OzYtJXJIsw/XLJqP+H4jzGMIoSiUfbiSPMqIghlWKrRaKJDdeNwHxHeiWR
        ycGN9t1/Pd3a4pAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 50B7CA3B81;
        Tue,  9 Nov 2021 11:59:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 07A991E14ED; Tue,  9 Nov 2021 12:59:38 +0100 (CET)
Date:   Tue, 9 Nov 2021 12:59:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 2/2] block: Hold invalidate_lock in BLKZEROOUT ioctl
Message-ID: <20211109115938.GE5955@quack2.suse.cz>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
 <20211109104723.835533-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109104723.835533-3-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 09-11-21 19:47:23, Shin'ichiro Kawasaki wrote:
> When BLKZEROOUT ioctl and data read race, the data read leaves stale
> page cache. To avoid the stale page cache, hold invalidate_lock of the
> block device file mapping. The stale page cache is observed when
> blktests test case block/009 is modified to call "blkdiscard -z" command
> and repeated hundreds of times.
> 
> This patch can be applied back to the stable kernel version v5.15.y.
> Rework is required for older stable kernels.
> 
> Fixes: 22dd6d356628 ("block: invalidate the page cache when issuing BLKZEROOUT")
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
> index 9fa87f64f703..0a1d10ac2e1a 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -154,6 +154,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
>  {
>  	uint64_t range[2];
>  	uint64_t start, end, len;
> +	struct inode *inode = bdev->bd_inode;
>  	int err;
>  
>  	if (!(mode & FMODE_WRITE))
> @@ -176,12 +177,17 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
>  		return -EINVAL;
>  
>  	/* Invalidate the page cache, including dirty pages */
> +	filemap_invalidate_lock(inode->i_mapping);
>  	err = truncate_bdev_range(bdev, mode, start, end);
>  	if (err)
> -		return err;
> +		goto fail;
> +
> +	err = blkdev_issue_zeroout(bdev, start >> 9, len >> 9, GFP_KERNEL,
> +				   BLKDEV_ZERO_NOUNMAP);
>  
> -	return blkdev_issue_zeroout(bdev, start >> 9, len >> 9, GFP_KERNEL,
> -			BLKDEV_ZERO_NOUNMAP);
> +fail:
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	return err;
>  }
>  
>  static int put_ushort(unsigned short __user *argp, unsigned short val)
> -- 
> 2.33.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
