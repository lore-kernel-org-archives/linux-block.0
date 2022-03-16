Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E45C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 10:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344510AbiCPKZ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 06:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbiCPKZZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 06:25:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4D344757
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 03:24:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D906B21108;
        Wed, 16 Mar 2022 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647426250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mO8SKUZsZIQ4xJh7x5seCmL/ZpaQWkzd2cjMt+W1s18=;
        b=3AG6q2jgFEJDBPsa2ssTGvPuDLmt+0xm+VvxFegtUzvc6u3RU+RmOwigPkus3xPZ6nQHmt
        e/a+MFR8NrP4rXKhwe754Ly6pL1iadtal1IjCow0XZD32SPRQfPz8/aCmLnhH38OHQ/xvL
        grpspzKglUmdqvjneCSKXNvSK8Fc8Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647426250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mO8SKUZsZIQ4xJh7x5seCmL/ZpaQWkzd2cjMt+W1s18=;
        b=jL8zs8i3YjTix6lKRFQoo9W+jPQH0op+LvZyi4W8me1P8xgu8CRiTjdotdfeNwVbPVyJdb
        hHhlWmFNOkakqIDw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D892A3B81;
        Wed, 16 Mar 2022 10:24:10 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 12D55A0615; Wed, 16 Mar 2022 11:24:10 +0100 (CET)
Date:   Wed, 16 Mar 2022 11:24:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/8] loop: remove the racy bd_inode->i_mapping->nrpages
 asserts
Message-ID: <20220316102410.j3ugylmeu3j2hgvm@quack3.lan>
References: <20220316084519.2850118-1-hch@lst.de>
 <20220316084519.2850118-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316084519.2850118-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 16-03-22 09:45:14, Christoph Hellwig wrote:
> Nothing prevents a file system or userspace opener of the block device
> from redirtying the page right afte sync_blockdev returned.  Fortunately
> data in the page cache during a block device change is mostly harmless
> anyway.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Darrick J. Wong <djwong@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/loop.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 2d344fefda6b8..e3361c6b22150 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1276,15 +1276,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	/* I/O need to be drained during transfer transition */
>  	blk_mq_freeze_queue(lo->lo_queue);
>  
> -	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
> -		/* If any pages were dirtied after invalidate_bdev(), try again */
> -		err = -EAGAIN;
> -		pr_warn("%s: loop%d (%s) still has dirty pages (nrpages=%lu)\n",
> -			__func__, lo->lo_number, lo->lo_file_name,
> -			lo->lo_device->bd_inode->i_mapping->nrpages);
> -		goto out_unfreeze;
> -	}
> -
>  	prev_lo_flags = lo->lo_flags;
>  
>  	err = loop_set_status_from_info(lo, info);
> @@ -1495,21 +1486,10 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
>  	invalidate_bdev(lo->lo_device);
>  
>  	blk_mq_freeze_queue(lo->lo_queue);
> -
> -	/* invalidate_bdev should have truncated all the pages */
> -	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
> -		err = -EAGAIN;
> -		pr_warn("%s: loop%d (%s) still has dirty pages (nrpages=%lu)\n",
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
