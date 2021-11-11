Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22923C433F5
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 10:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B01461215
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 10:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhKKKJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 05:09:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49702 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhKKKJd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 05:09:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7AAB221B33;
        Thu, 11 Nov 2021 10:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636625203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KXi66wVmuUBPs9ddGfpgdte41mpsYVtxLWH+NejJNek=;
        b=N2D4qVaIZayE78dt27u3R4qw2N1pSpMI26LTFpej1FhtJu5ciaRCSrOy9eKlR4RnPC7Kpz
        b/K6VtpZb5ygiZjLwFvK+SWWpMHih4idrgVGSOcMyXbZil0fpvdXEYB+Q9aRb/nqWxIASu
        E7dyBIR1e1KjvzEwgWJUDX2cHK06RG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636625203;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KXi66wVmuUBPs9ddGfpgdte41mpsYVtxLWH+NejJNek=;
        b=TflTSrd2ARll1jIH/NtrDMKFCvV1UKeL6kulYBrL2CGMBOHBeitymXnAcTE5U3IxxDfZSu
        BWq0D2mYt9b41XAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 47621A3B95;
        Thu, 11 Nov 2021 10:06:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 192061E0BF0; Thu, 11 Nov 2021 11:06:40 +0100 (CET)
Date:   Thu, 11 Nov 2021 11:06:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] block: Hold invalidate_lock in BLKRESETZONE ioctl
Message-ID: <20211111100640.GA25491@quack2.suse.cz>
References: <20211111085238.942492-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111085238.942492-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 11-11-21 17:52:38, Shin'ichiro Kawasaki wrote:
> When BLKRESETZONE ioctl and data read race, the data read leaves stale
> page cache. The commit e5113505904e ("block: Discard page cache of zone
> reset target range") added page cache truncation to avoid stale page
> cache after the ioctl. However, the stale page cache still can be read
> during the reset zone operation for the ioctl. To avoid the stale page
> cache completely, hold invalidate_lock of the block device file mapping.
> 
> Fixes: e5113505904e ("block: Discard page cache of zone reset target range")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org # v5.15

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  block/blk-zoned.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 1d0c76c18fc5..774ecc598bee 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -429,9 +429,10 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>  		op = REQ_OP_ZONE_RESET;
>  
>  		/* Invalidate the page cache, including dirty pages. */
> +		filemap_invalidate_lock(bdev->bd_inode->i_mapping);
>  		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
>  		if (ret)
> -			return ret;
> +			goto fail;
>  		break;
>  	case BLKOPENZONE:
>  		op = REQ_OP_ZONE_OPEN;
> @@ -449,15 +450,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>  	ret = blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors,
>  			       GFP_KERNEL);
>  
> -	/*
> -	 * Invalidate the page cache again for zone reset: writes can only be
> -	 * direct for zoned devices so concurrent writes would not add any page
> -	 * to the page cache after/during reset. The page cache may be filled
> -	 * again due to concurrent reads though and dropping the pages for
> -	 * these is fine.
> -	 */
> -	if (!ret && cmd == BLKRESETZONE)
> -		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
> +fail:
> +	if (cmd == BLKRESETZONE)
> +		filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
>  
>  	return ret;
>  }
> -- 
> 2.33.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
