Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412FEC433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 13:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346698AbiCXNdK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243053AbiCXNdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 09:33:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CF7673E8
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 06:31:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 34499210FD;
        Thu, 24 Mar 2022 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648128697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0Cr2mQ8cWcFJUA6V7ww5aJ6cyPtJwF77BTMIEivlo4=;
        b=Ebig25vDZgJtSK5nD8Kxt5HyjRsp/LWzUgUUsTboAj3lQ80t2L2SMPgL4qANETrBP0zkDN
        Efw7ObJAC3VdSxPm6+ah8QqIvoErieJfmAPZ1MYefHNTm8RHa2f1ZZ2bv+DraJsD/PUJgo
        eMSP0ESW9ODXlChKmCxUJ7e1k47ARtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648128697;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0Cr2mQ8cWcFJUA6V7ww5aJ6cyPtJwF77BTMIEivlo4=;
        b=pAUBZy07TiJsA2ToO/paxJHMJNVNW8ewqLykuZZDfdj/XlAUPxH6QXLhEoJ9tw5GOYL/hJ
        q5hRZ3hstdHvciBg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0BD52A3B83;
        Thu, 24 Mar 2022 13:31:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AC068A0610; Thu, 24 Mar 2022 14:31:36 +0100 (CET)
Date:   Thu, 24 Mar 2022 14:31:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 05/13] block: turn bdev->bd_openers into an atomic_t
Message-ID: <20220324133136.h6vimclhyhly7uyh@quack3.lan>
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324075119.1556334-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 24-03-22 08:51:11, Christoph Hellwig wrote:
> All manipulation of bd_openers is under disk->open_mutex and will remain
> so for the foreseeable future.  But at least one place reads it without
> the lock (blkdev_get) and there are more to be added.  So make sure the
> compiler does not do turn the increments and decrements into non-atomic
> sequences by using an atomic_t.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW I suspect that drivers/block/aoe/ could now use bd_openers instead of
its driver specific mirror of it (->nopen). But that's certainly a separate
cleanup for some other time.

								Honza

> ---
>  block/bdev.c              | 16 ++++++++--------
>  block/partitions/core.c   |  2 +-
>  include/linux/blk_types.h |  2 +-
>  include/linux/blkdev.h    |  2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 13de871fa8169..7bf88e591aaf3 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -673,17 +673,17 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
>  		}
>  	}
>  
> -	if (!bdev->bd_openers)
> +	if (!atomic_read(&bdev->bd_openers))
>  		set_init_blocksize(bdev);
>  	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
>  		bdev_disk_changed(disk, false);
> -	bdev->bd_openers++;
> +	atomic_inc(&bdev->bd_openers);
>  	return 0;
>  }
>  
>  static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
>  {
> -	if (!--bdev->bd_openers)
> +	if (atomic_dec_and_test(&bdev->bd_openers))
>  		blkdev_flush_mapping(bdev);
>  	if (bdev->bd_disk->fops->release)
>  		bdev->bd_disk->fops->release(bdev->bd_disk, mode);
> @@ -694,7 +694,7 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
>  	struct gendisk *disk = part->bd_disk;
>  	int ret;
>  
> -	if (part->bd_openers)
> +	if (atomic_read(&part->bd_openers))
>  		goto done;
>  
>  	ret = blkdev_get_whole(bdev_whole(part), mode);
> @@ -708,7 +708,7 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
>  	disk->open_partitions++;
>  	set_init_blocksize(part);
>  done:
> -	part->bd_openers++;
> +	atomic_inc(&part->bd_openers);
>  	return 0;
>  
>  out_blkdev_put:
> @@ -720,7 +720,7 @@ static void blkdev_put_part(struct block_device *part, fmode_t mode)
>  {
>  	struct block_device *whole = bdev_whole(part);
>  
> -	if (--part->bd_openers)
> +	if (!atomic_dec_and_test(&part->bd_openers))
>  		return;
>  	blkdev_flush_mapping(part);
>  	whole->bd_disk->open_partitions--;
> @@ -899,7 +899,7 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
>  	 * of the world and we want to avoid long (could be several minute)
>  	 * syncs while holding the mutex.
>  	 */
> -	if (bdev->bd_openers == 1)
> +	if (atomic_read(&bdev->bd_openers) == 1)
>  		sync_blockdev(bdev);
>  
>  	mutex_lock(&disk->open_mutex);
> @@ -1044,7 +1044,7 @@ void sync_bdevs(bool wait)
>  		bdev = I_BDEV(inode);
>  
>  		mutex_lock(&bdev->bd_disk->open_mutex);
> -		if (!bdev->bd_openers) {
> +		if (!atomic_read(&bdev->bd_openers)) {
>  			; /* skip */
>  		} else if (wait) {
>  			/*
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 2ef8dfa1e5c85..373ed748dcf26 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -486,7 +486,7 @@ int bdev_del_partition(struct gendisk *disk, int partno)
>  		goto out_unlock;
>  
>  	ret = -EBUSY;
> -	if (part->bd_openers)
> +	if (atomic_read(&part->bd_openers))
>  		goto out_unlock;
>  
>  	delete_partition(part);
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 0c3563b45fe90..b1ced43ed0d3f 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -44,7 +44,7 @@ struct block_device {
>  	unsigned long		bd_stamp;
>  	bool			bd_read_only;	/* read-only policy */
>  	dev_t			bd_dev;
> -	int			bd_openers;
> +	atomic_t		bd_openers;
>  	struct inode *		bd_inode;	/* will die */
>  	struct super_block *	bd_super;
>  	void *			bd_claiming;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 9824ebc9b4d31..6b7c5af1d01df 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -188,7 +188,7 @@ static inline bool disk_live(struct gendisk *disk)
>   */
>  static inline unsigned int disk_openers(struct gendisk *disk)
>  {
> -	return disk->part0->bd_openers;
> +	return atomic_read(&disk->part0->bd_openers);
>  }
>  
>  /*
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
