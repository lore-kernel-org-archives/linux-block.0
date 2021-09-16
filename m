Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF14C433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 14:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8309F60E08
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 14:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhIPOSR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 10:18:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46792 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhIPOSQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 10:18:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4D215223D5;
        Thu, 16 Sep 2021 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631801815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4smCv84xjzrS2IvT32QW7dEMqnHlEwo/B3oX7KHTeVA=;
        b=SQsXmQgGIlxJMOdJB0L97ZzVglADOPxS38WgMmkU+6nlVBsAFkvIaz+cF5zb5D9gvbcqu9
        ottoIuq7cDgEUcVI70qV7AOaakWpyme8MS2MbmQALH1iUp4ygLHE2tLQzkUuj2g+qZtsbt
        APUgobWJBxNvIv1ujt+lPg8sbF6CsMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631801815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4smCv84xjzrS2IvT32QW7dEMqnHlEwo/B3oX7KHTeVA=;
        b=t1UZ1mBj8GapnVtgxqeDri5m1+N/D1i8pZiHo20NlhxHhzaw7rc7J4pL+SIQvyNCk7fzw5
        IqgC3QGP5C/2fYBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 3D2A6A3B90;
        Thu, 16 Sep 2021 14:16:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2056F1E0C06; Thu, 16 Sep 2021 16:16:55 +0200 (CEST)
Date:   Thu, 16 Sep 2021 16:16:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: hold ->invalidate_lock in blkdev_fallocate
Message-ID: <20210916141655.GI10610@quack2.suse.cz>
References: <20210915123545.1000534-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915123545.1000534-1-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 15-09-21 20:35:45, Ming Lei wrote:
> When running ->fallocate(), blkdev_fallocate() should hold
> mapping->invalidate_lock to prevent page cache from being
> accessed, otherwise stale data may be read in page cache.
> 
> Without this patch, blktests block/009 fails sometimes. With
> this patch, block/009 can pass always.
> 
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Interesting. Looking at block/009 testcase I'm somewhat struggling to see
how it could trigger a situation where stale data would be seen. Do you
have some independent read accesses to the block device while the testcase
is running? That would explain it and yes, this patch should fix that.

BTW, you'd need to rebase this against current Linus' tree - Christoph has
moved this code to block/...

Also with the invalidate_lock held, there's no need for the second
truncate_bdev_range() call anymore. No pages can be created in the
discarded area while you are holding the invalidate_lock.

								Honza

> ---
>  fs/block_dev.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 45df6cbccf12..f55e14ae89a0 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1516,7 +1516,8 @@ static const struct address_space_operations def_blk_aops = {
>  static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  			     loff_t len)
>  {
> -	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
> +	struct inode *inode = bdev_file_inode(file);
> +	struct block_device *bdev = I_BDEV(inode);
>  	loff_t end = start + len - 1;
>  	loff_t isize;
>  	int error;
> @@ -1543,10 +1544,12 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
>  		return -EINVAL;
>  
> +	filemap_invalidate_lock(inode->i_mapping);
> +
>  	/* Invalidate the page cache, including dirty pages. */
>  	error = truncate_bdev_range(bdev, file->f_mode, start, end);
>  	if (error)
> -		return error;
> +		goto fail;
>  
>  	switch (mode) {
>  	case FALLOC_FL_ZERO_RANGE:
> @@ -1563,17 +1566,18 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  					     GFP_KERNEL, 0);
>  		break;
>  	default:
> -		return -EOPNOTSUPP;
> +		error = -EOPNOTSUPP;
>  	}
> -	if (error)
> -		return error;
> -
>  	/*
>  	 * Invalidate the page cache again; if someone wandered in and dirtied
>  	 * a page, we just discard it - userspace has no way of knowing whether
>  	 * the write happened before or after discard completing...
>  	 */
> -	return truncate_bdev_range(bdev, file->f_mode, start, end);
> +	if (!error)
> +		error = truncate_bdev_range(bdev, file->f_mode, start, end);
> + fail:
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	return error;
>  }
>  
>  const struct file_operations def_blk_fops = {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
