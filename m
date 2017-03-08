Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:47853 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdCHP3y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2017 10:29:54 -0500
Date: Wed, 8 Mar 2017 07:03:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org
Subject: Re: [PATCH] f2fs: allocate a bio for discarding when actually
 issuing it
Message-ID: <20170308150311.GA17999@infradead.org>
References: <20170308023333.15034-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170308023333.15034-1-jaegeuk@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Mar 07, 2017 at 06:33:33PM -0800, Jaegeuk Kim wrote:
> Let's allocate a bio when issuing discard commands later.

Does this solve the issue with your queue stalls?

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h    |   4 +-
>  fs/f2fs/segment.c | 113 ++++++++++++++++++++++++++++--------------------------
>  2 files changed, 62 insertions(+), 55 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index a58c2e43bd2a..870bb4d9bc65 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -197,10 +197,12 @@ enum {
>  struct discard_cmd {
>  	struct list_head list;		/* command list */
>  	struct completion wait;		/* compleation */
> +	struct block_device *bdev;	/* bdev */
>  	block_t lstart;			/* logical start address */
> +	block_t start;			/* actual start address in dev */
>  	block_t len;			/* length */
> -	struct bio *bio;		/* bio */
>  	int state;			/* state */
> +	int error;			/* bio error */
>  };
>  
>  struct discard_cmd_control {
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 50c65cc4645a..d8f9e6c895cd 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -636,7 +636,8 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
>  }
>  
>  static void __add_discard_cmd(struct f2fs_sb_info *sbi,
> -			struct bio *bio, block_t lstart, block_t len)
> +		struct block_device *bdev, block_t lstart,
> +		block_t start, block_t len)
>  {
>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>  	struct list_head *cmd_list = &(dcc->discard_cmd_list);
> @@ -644,9 +645,9 @@ static void __add_discard_cmd(struct f2fs_sb_info *sbi,
>  
>  	dc = f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS);
>  	INIT_LIST_HEAD(&dc->list);
> -	dc->bio = bio;
> -	bio->bi_private = dc;
> +	dc->bdev = bdev;
>  	dc->lstart = lstart;
> +	dc->start = start;
>  	dc->len = len;
>  	dc->state = D_PREP;
>  	init_completion(&dc->wait);
> @@ -658,22 +659,66 @@ static void __add_discard_cmd(struct f2fs_sb_info *sbi,
>  
>  static void __remove_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *dc)
>  {
> -	int err = dc->bio->bi_error;
> -
>  	if (dc->state == D_DONE)
>  		atomic_dec(&(SM_I(sbi)->dcc_info->submit_discard));
>  
> -	if (err == -EOPNOTSUPP)
> -		err = 0;
> +	if (dc->error == -EOPNOTSUPP)
> +		dc->error = 0;
>  
> -	if (err)
> +	if (dc->error)
>  		f2fs_msg(sbi->sb, KERN_INFO,
> -				"Issue discard failed, ret: %d", err);
> -	bio_put(dc->bio);
> +				"Issue discard failed, ret: %d", dc->error);
>  	list_del(&dc->list);
>  	kmem_cache_free(discard_cmd_slab, dc);
>  }
>  
> +static void f2fs_submit_discard_endio(struct bio *bio)
> +{
> +	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
> +
> +	complete(&dc->wait);
> +	dc->error = bio->bi_error;
> +	dc->state = D_DONE;
> +	bio_put(bio);
> +}
> +
> +/* this function is copied from blkdev_issue_discard from block/blk-lib.c */
> +static int __submit_discard_cmd(struct discard_cmd *dc)
> +{
> +	struct bio *bio = NULL;
> +	int err;
> +
> +	err = __blkdev_issue_discard(dc->bdev,
> +				SECTOR_FROM_BLOCK(dc->start),
> +				SECTOR_FROM_BLOCK(dc->len),
> +				GFP_NOFS, 0, &bio);
> +	if (!err && bio) {
> +		bio->bi_private = dc;
> +		bio->bi_end_io = f2fs_submit_discard_endio;
> +		bio->bi_opf |= REQ_SYNC;
> +		submit_bio(bio);
> +	}
> +	dc->state = D_SUBMIT;
> +	return err;
> +}
> +
> +static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
> +		struct block_device *bdev, block_t blkstart, block_t blklen)
> +{
> +	block_t lblkstart = blkstart;
> +
> +	trace_f2fs_issue_discard(bdev, blkstart, blklen);
> +
> +	if (sbi->s_ndevs) {
> +		int devi = f2fs_target_device_index(sbi, blkstart);
> +
> +		blkstart -= FDEV(devi).start_blk;
> +	}
> +	__add_discard_cmd(sbi, bdev, lblkstart, blkstart, blklen);
> +	wake_up(&SM_I(sbi)->dcc_info->discard_wait_queue);
> +	return 0;
> +}
> +
>  /* This should be covered by global mutex, &sit_i->sentry_lock */
>  void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>  {
> @@ -690,8 +735,7 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>  
>  		if (blkaddr == NULL_ADDR) {
>  			if (dc->state == D_PREP) {
> -				dc->state = D_SUBMIT;
> -				submit_bio(dc->bio);
> +				__submit_discard_cmd(dc);
>  				atomic_inc(&dcc->submit_discard);
>  			}
>  			continue;
> @@ -716,14 +760,6 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>  	mutex_unlock(&dcc->cmd_lock);
>  }
>  
> -static void f2fs_submit_discard_endio(struct bio *bio)
> -{
> -	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
> -
> -	complete(&dc->wait);
> -	dc->state = D_DONE;
> -}
> -
>  static int issue_discard_thread(void *data)
>  {
>  	struct f2fs_sb_info *sbi = data;
> @@ -742,8 +778,7 @@ static int issue_discard_thread(void *data)
>  	mutex_lock(&dcc->cmd_lock);
>  	list_for_each_entry_safe(dc, tmp, cmd_list, list) {
>  		if (dc->state == D_PREP) {
> -			dc->state = D_SUBMIT;
> -			submit_bio(dc->bio);
> +			__submit_discard_cmd(dc);
>  			atomic_inc(&dcc->submit_discard);
>  			if (iter++ > DISCARD_ISSUE_RATE)
>  				break;
> @@ -763,36 +798,6 @@ static int issue_discard_thread(void *data)
>  	goto repeat;
>  }
>  
> -
> -/* this function is copied from blkdev_issue_discard from block/blk-lib.c */
> -static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
> -		struct block_device *bdev, block_t blkstart, block_t blklen)
> -{
> -	struct bio *bio = NULL;
> -	block_t lblkstart = blkstart;
> -	int err;
> -
> -	trace_f2fs_issue_discard(bdev, blkstart, blklen);
> -
> -	if (sbi->s_ndevs) {
> -		int devi = f2fs_target_device_index(sbi, blkstart);
> -
> -		blkstart -= FDEV(devi).start_blk;
> -	}
> -	err = __blkdev_issue_discard(bdev,
> -				SECTOR_FROM_BLOCK(blkstart),
> -				SECTOR_FROM_BLOCK(blklen),
> -				GFP_NOFS, 0, &bio);
> -	if (!err && bio) {
> -		bio->bi_end_io = f2fs_submit_discard_endio;
> -		bio->bi_opf |= REQ_SYNC;
> -
> -		__add_discard_cmd(sbi, bio, lblkstart, blklen);
> -		wake_up(&SM_I(sbi)->dcc_info->discard_wait_queue);
> -	}
> -	return err;
> -}
> -
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>  		struct block_device *bdev, block_t blkstart, block_t blklen)
> @@ -816,7 +821,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>  	case BLK_ZONE_TYPE_CONVENTIONAL:
>  		if (!blk_queue_discard(bdev_get_queue(bdev)))
>  			return 0;
> -		return __f2fs_issue_discard_async(sbi, bdev, lblkstart, blklen);
> +		return __queue_discard_cmd(sbi, bdev, lblkstart, blklen);
>  	case BLK_ZONE_TYPE_SEQWRITE_REQ:
>  	case BLK_ZONE_TYPE_SEQWRITE_PREF:
>  		sector = SECTOR_FROM_BLOCK(blkstart);
> @@ -848,7 +853,7 @@ static int __issue_discard_async(struct f2fs_sb_info *sbi,
>  				bdev_zoned_model(bdev) != BLK_ZONED_NONE)
>  		return __f2fs_issue_discard_zone(sbi, bdev, blkstart, blklen);
>  #endif
> -	return __f2fs_issue_discard_async(sbi, bdev, blkstart, blklen);
> +	return __queue_discard_cmd(sbi, bdev, blkstart, blklen);
>  }
>  
>  static int f2fs_issue_discard(struct f2fs_sb_info *sbi,
> -- 
> 2.11.0
> 
---end quoted text---
