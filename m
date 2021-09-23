Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF10C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 13:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFA86115A
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 13:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241451AbhIWNdK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:33:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48218 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241836AbhIWNcy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 09:32:54 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id 204EF1FFA8;
        Thu, 23 Sep 2021 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632403882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g531ZdtukfsR27kKw2o7VJFIiNtGR6XGudlvkn3l6Lw=;
        b=2cbesM8iPz81q6XwZR6dRYDYx4fAS9ZsfIv/Qugr8oRk6Cdkr2W9v5I+UX99abvgHwbvqy
        OVggMvjb7MAK8p+YvocTcaBuA3wcECTRSdMhl9gOrCTzGCKZD0NqKd+vPwkRSprHg1M4Fv
        6DXEV4epmBpnL5uuDKsEVdSFF7se/Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632403882;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g531ZdtukfsR27kKw2o7VJFIiNtGR6XGudlvkn3l6Lw=;
        b=XuGm2FfD7yNcG97Y0sSp9WK9HZd3PJ1F4N6kGRu20DKtvF5QlmKCWm2kWAbWou/SrbmiVx
        HQKxsFOuJfkANeBg==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay1.suse.de (Postfix) with ESMTP id 0FC6A25D47;
        Thu, 23 Sep 2021 13:31:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6DBDA1E0BE4; Thu, 23 Sep 2021 15:31:19 +0200 (CEST)
Date:   Thu, 23 Sep 2021 15:31:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V2] block: hold ->invalidate_lock in blkdev_fallocate
Message-ID: <20210923133119.GA1459@quack2.suse.cz>
References: <20210923023751.1441091-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923023751.1441091-1-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 23-09-21 10:37:51, Ming Lei wrote:
> When running ->fallocate(), blkdev_fallocate() should hold
> mapping->invalidate_lock to prevent page cache from being accessed,
> otherwise stale data may be read in page cache.
> 
> Without this patch, blktests block/009 fails sometimes. With this patch,
> block/009 can pass always.
> 
> Also as Jan pointed out, no pages can be created in the discarded area
> while you are holding the invalidate_lock, so remove the 2nd
> truncate_bdev_range().
> 
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V2:
> 	- include <linux/fs.h> for avoiding implicit declaration of function 
> 	filemap_invalidate_lock
> 	- remove 2nd truncate_bdev_range() as suggested by Jan
> 
>  block/fops.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index ffce6f6c68dd..1e970c247e0e 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -14,6 +14,7 @@
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/falloc.h>
>  #include <linux/suspend.h>
> +#include <linux/fs.h>
>  #include "blk.h"
>  
>  static struct inode *bdev_file_inode(struct file *file)
> @@ -553,7 +554,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  			     loff_t len)
>  {
> -	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
> +	struct inode *inode = bdev_file_inode(file);
> +	struct block_device *bdev = I_BDEV(inode);
>  	loff_t end = start + len - 1;
>  	loff_t isize;
>  	int error;
> @@ -580,10 +582,12 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
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
> @@ -600,17 +604,12 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
>  					     GFP_KERNEL, 0);
>  		break;
>  	default:
> -		return -EOPNOTSUPP;
> +		error = -EOPNOTSUPP;
>  	}
> -	if (error)
> -		return error;
>  
> -	/*
> -	 * Invalidate the page cache again; if someone wandered in and dirtied
> -	 * a page, we just discard it - userspace has no way of knowing whether
> -	 * the write happened before or after discard completing...
> -	 */
> -	return truncate_bdev_range(bdev, file->f_mode, start, end);
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
