Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1124BC433EF
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 09:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiEPJwy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 05:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbiEPJwp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 05:52:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBD165D3
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 02:52:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E99741F958;
        Mon, 16 May 2022 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652694759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0JWMNuka0ir9ScUchkNvuhx7zcmNsu0UOd5gJnfJt4g=;
        b=W38EXIOigYPgkDppXLQqRashFPTU/CfhoYEZJyunHGAf+LaKU3/r10AczNls0kAAbcbbP3
        adrSUBrFiIln7GmzI/fZB3X+ZonnTiGX7+ttHiZ/8zta4Th2TjljS1UvfsU+F8TQx+f3oe
        vT/9p/DFDL2ARS7zawQv49URE4RkBBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652694759;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0JWMNuka0ir9ScUchkNvuhx7zcmNsu0UOd5gJnfJt4g=;
        b=uptfEkTClE9bj5S/GzOT+2v2wb5wOdx9EQm6U6XvNl3yh5wH5xzNR/6fms9bTOPhL97pM3
        KmySCm4iotpEwRBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D1CC02C141;
        Mon, 16 May 2022 09:52:39 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 62C97A062F; Mon, 16 May 2022 11:52:39 +0200 (CEST)
Date:   Mon, 16 May 2022 11:52:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block: avoid to serialize blkdev_fallocate
Message-ID: <20220516095239.pgk6uda376agnrjw@quack3.lan>
References: <20220512134814.1454451-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512134814.1454451-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 12-05-22 21:48:14, Ming Lei wrote:
> Commit f278eb3d8178 ("block: hold ->invalidate_lock in blkdev_fallocate")
> adds ->invalidate_lock in blkdev_fallocate() for preventing stale data
> from being read during fallocate().
> 
> However, the side effect is that blkdev_fallocate() becomes serialized
> since blkdev_fallocate() always blocks.
> 
> Add one atomic fallocate counter for allowing blkdev_fallocate() to
> be run concurrently so that discard/write_zero bios from different
> fallocate() can be submitted in parallel.
> 
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Couple of points:
* What about blk_ioctl_zeroout() or blk_ioctl_discard()?
* This way processes calling discard / zeroout can easily starve process
  wanting to do read which does not seem ideal. Somewhat related is that I
  know that Christoph wanted to modify how we use filemap_invalidate_lock()
  so that huge zeroouts performed by actually writing zeros will not block
  readers for ages and this seems to be going in somewhat opposite direction
  favoring writers even more.
* I suspect this is going to upset lockdep (and lock owner tracking for the
  purposes of spinning) pretty badly because the lock owner may be returning
  to userspace without unlocking the lock.

								Honza

> ---
>  block/fops.c              | 6 ++++--
>  include/linux/blk_types.h | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 9f2ecec406b0..368866b15e68 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -651,7 +651,8 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
>  		return -EINVAL;
>  
> -	filemap_invalidate_lock(inode->i_mapping);
> +	if (atomic_inc_return(&bdev->bd_fallocate_count) == 1)
> +		filemap_invalidate_lock(inode->i_mapping);
>  
>  	/* Invalidate the page cache, including dirty pages. */
>  	error = truncate_bdev_range(bdev, file->f_mode, start, end);
> @@ -679,7 +680,8 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	}
>  
>   fail:
> -	filemap_invalidate_unlock(inode->i_mapping);
> +	if (!atomic_dec_return(&bdev->bd_fallocate_count))
> +		filemap_invalidate_unlock(inode->i_mapping);
>  	return error;
>  }
>  
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 1973ef9bd40f..9ccd841ea8ed 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -58,6 +58,8 @@ struct block_device {
>  	struct gendisk *	bd_disk;
>  	struct request_queue *	bd_queue;
>  
> +	atomic_t		bd_fallocate_count;
> +
>  	/* The counter of freeze processes */
>  	int			bd_fsfreeze_count;
>  	/* Mutex for freeze */
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
