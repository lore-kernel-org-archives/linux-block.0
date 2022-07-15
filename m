Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C73AC43334
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 09:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiGOJi4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 05:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiGOJiy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 05:38:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D211B13F26
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 02:38:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E3CE634248;
        Fri, 15 Jul 2022 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657877928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hRDHWMOMxwbT8q+Q0B6Y+g44kQmAxL1wNqWJRw2uxvY=;
        b=ujX8+yAS6NAOfriWG25Zw3aSJJa8maCS4vCINL4DMlFWiOXb3SC0oze6Skok9gvVMpNbLo
        eXARs2RSLgM5v/RDPp3G2erUOlikFSYq0oqV12ZYNjTypKeiQu3Oib4q3LwyC/ai7D4uXO
        u97Uw0T09OaDbntZHqU0IWvlf/Vo7Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657877928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hRDHWMOMxwbT8q+Q0B6Y+g44kQmAxL1wNqWJRw2uxvY=;
        b=zY2utqTAAkCH7c7isHyZ/Z177tK0KjFo9b1bHhrxBNr3XSFefVvDYWFecQbpXex9+PQj4g
        X6eDmQnqzogJXsBw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CF5E02C141;
        Fri, 15 Jul 2022 09:38:47 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 603BCA0657; Fri, 15 Jul 2022 11:38:47 +0200 (CEST)
Date:   Fri, 15 Jul 2022 11:38:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 47/63] fs/buffer: Combine two submit_bh() and
 ll_rw_block() arguments
Message-ID: <20220715093847.26vdp3tto3wn2m6n@quack3>
References: <20220714180729.1065367-1-bvanassche@acm.org>
 <20220714180729.1065367-48-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714180729.1065367-48-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 14-07-22 11:07:13, Bart Van Assche wrote:
> Both submit_bh() and ll_rw_block() accept a request operation type and
> request flags as their first two arguments. Micro-optimize these two
> functions by combining these first two arguments into a single argument.
> This patch does not change the behavior of any of the modified code.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jan Kara <jack@suse.cz>
> Acked-by: Song Liu <song@kernel.org> (for the md changes)
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/md/md-bitmap.c      |  4 +--
>  fs/buffer.c                 | 53 +++++++++++++++++++------------------
>  fs/ext4/fast_commit.c       |  2 +-
>  fs/ext4/mmp.c               |  2 +-
>  fs/ext4/super.c             |  6 ++---
>  fs/gfs2/bmap.c              |  5 ++--
>  fs/gfs2/dir.c               |  5 ++--
>  fs/gfs2/meta_io.c           |  9 +++----
>  fs/gfs2/quota.c             |  2 +-
>  fs/isofs/compress.c         |  2 +-
>  fs/jbd2/commit.c            |  8 +++---
>  fs/jbd2/journal.c           |  4 +--
>  fs/jbd2/recovery.c          |  4 +--
>  fs/nilfs2/btnode.c          |  2 +-
>  fs/nilfs2/gcinode.c         |  2 +-
>  fs/nilfs2/mdt.c             |  2 +-
>  fs/ntfs/aops.c              |  6 ++---
>  fs/ntfs/compress.c          |  2 +-
>  fs/ntfs/file.c              |  2 +-
>  fs/ntfs/logfile.c           |  2 +-
>  fs/ntfs/mft.c               |  4 +--
>  fs/ntfs3/file.c             |  2 +-
>  fs/ntfs3/inode.c            |  2 +-
>  fs/ocfs2/aops.c             |  2 +-
>  fs/ocfs2/buffer_head_io.c   |  8 +++---
>  fs/ocfs2/super.c            |  2 +-
>  fs/reiserfs/inode.c         |  4 +--
>  fs/reiserfs/journal.c       | 12 ++++-----
>  fs/reiserfs/stree.c         |  4 +--
>  fs/reiserfs/super.c         |  2 +-
>  fs/udf/dir.c                |  2 +-
>  fs/udf/directory.c          |  2 +-
>  fs/udf/inode.c              |  2 +-
>  fs/ufs/balloc.c             |  2 +-
>  include/linux/buffer_head.h |  4 +--
>  35 files changed, 88 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 0a21b8317103..bf6dffadbe6f 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -302,7 +302,7 @@ static void write_page(struct bitmap *bitmap, struct page *page, int wait)
>  			atomic_inc(&bitmap->pending_writes);
>  			set_buffer_locked(bh);
>  			set_buffer_mapped(bh);
> -			submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
> +			submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
>  			bh = bh->b_this_page;
>  		}
>  
> @@ -394,7 +394,7 @@ static int read_page(struct file *file, unsigned long index,
>  			atomic_inc(&bitmap->pending_writes);
>  			set_buffer_locked(bh);
>  			set_buffer_mapped(bh);
> -			submit_bh(REQ_OP_READ, 0, bh);
> +			submit_bh(REQ_OP_READ, bh);
>  		}
>  		blk_cur++;
>  		bh = bh->b_this_page;
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 4a00b61f35ec..af53569930bb 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -52,8 +52,8 @@
>  #include "internal.h"
>  
>  static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
> -static int submit_bh_wbc(enum req_op op, blk_opf_t op_flags,
> -			 struct buffer_head *bh, struct writeback_control *wbc);
> +static int submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
> +			 struct writeback_control *wbc);
>  
>  #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
>  
> @@ -562,7 +562,7 @@ void write_boundary_block(struct block_device *bdev,
>  	struct buffer_head *bh = __find_get_block(bdev, bblock + 1, blocksize);
>  	if (bh) {
>  		if (buffer_dirty(bh))
> -			ll_rw_block(REQ_OP_WRITE, 0, 1, &bh);
> +			ll_rw_block(REQ_OP_WRITE, 1, &bh);
>  		put_bh(bh);
>  	}
>  }
> @@ -1174,7 +1174,7 @@ static struct buffer_head *__bread_slow(struct buffer_head *bh)
>  	} else {
>  		get_bh(bh);
>  		bh->b_end_io = end_buffer_read_sync;
> -		submit_bh(REQ_OP_READ, 0, bh);
> +		submit_bh(REQ_OP_READ, bh);
>  		wait_on_buffer(bh);
>  		if (buffer_uptodate(bh))
>  			return bh;
> @@ -1342,7 +1342,7 @@ void __breadahead(struct block_device *bdev, sector_t block, unsigned size)
>  {
>  	struct buffer_head *bh = __getblk(bdev, block, size);
>  	if (likely(bh)) {
> -		ll_rw_block(REQ_OP_READ, REQ_RAHEAD, 1, &bh);
> +		ll_rw_block(REQ_OP_READ | REQ_RAHEAD, 1, &bh);
>  		brelse(bh);
>  	}
>  }
> @@ -1353,7 +1353,7 @@ void __breadahead_gfp(struct block_device *bdev, sector_t block, unsigned size,
>  {
>  	struct buffer_head *bh = __getblk_gfp(bdev, block, size, gfp);
>  	if (likely(bh)) {
> -		ll_rw_block(REQ_OP_READ, REQ_RAHEAD, 1, &bh);
> +		ll_rw_block(REQ_OP_READ | REQ_RAHEAD, 1, &bh);
>  		brelse(bh);
>  	}
>  }
> @@ -1804,7 +1804,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
>  	do {
>  		struct buffer_head *next = bh->b_this_page;
>  		if (buffer_async_write(bh)) {
> -			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, wbc);
> +			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh, wbc);
>  			nr_underway++;
>  		}
>  		bh = next;
> @@ -1858,7 +1858,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
>  		struct buffer_head *next = bh->b_this_page;
>  		if (buffer_async_write(bh)) {
>  			clear_buffer_dirty(bh);
> -			submit_bh_wbc(REQ_OP_WRITE, write_flags, bh, wbc);
> +			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh, wbc);
>  			nr_underway++;
>  		}
>  		bh = next;
> @@ -2033,7 +2033,7 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
>  		if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
>  		    !buffer_unwritten(bh) &&
>  		     (block_start < from || block_end > to)) {
> -			ll_rw_block(REQ_OP_READ, 0, 1, &bh);
> +			ll_rw_block(REQ_OP_READ, 1, &bh);
>  			*wait_bh++=bh;
>  		}
>  	}
> @@ -2334,7 +2334,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  		if (buffer_uptodate(bh))
>  			end_buffer_async_read(bh, 1);
>  		else
> -			submit_bh(REQ_OP_READ, 0, bh);
> +			submit_bh(REQ_OP_READ, bh);
>  	}
>  	return 0;
>  }
> @@ -2665,7 +2665,7 @@ int nobh_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
>  		if (block_start < from || block_end > to) {
>  			lock_buffer(bh);
>  			bh->b_end_io = end_buffer_read_nobh;
> -			submit_bh(REQ_OP_READ, 0, bh);
> +			submit_bh(REQ_OP_READ, bh);
>  			nr_reads++;
>  		}
>  	}
> @@ -2915,7 +2915,7 @@ int block_truncate_page(struct address_space *mapping,
>  
>  	if (!buffer_uptodate(bh) && !buffer_delay(bh) && !buffer_unwritten(bh)) {
>  		err = -EIO;
> -		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
> +		ll_rw_block(REQ_OP_READ, 1, &bh);
>  		wait_on_buffer(bh);
>  		/* Uhhuh. Read error. Complain and punt. */
>  		if (!buffer_uptodate(bh))
> @@ -2994,9 +2994,10 @@ static void end_bio_bh_io_sync(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> -static int submit_bh_wbc(enum req_op op, blk_opf_t op_flags,
> -			 struct buffer_head *bh, struct writeback_control *wbc)
> +static int submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
> +			 struct writeback_control *wbc)
>  {
> +	const enum req_op op = opf & REQ_OP_MASK;
>  	struct bio *bio;
>  
>  	BUG_ON(!buffer_locked(bh));
> @@ -3012,11 +3013,11 @@ static int submit_bh_wbc(enum req_op op, blk_opf_t op_flags,
>  		clear_buffer_write_io_error(bh);
>  
>  	if (buffer_meta(bh))
> -		op_flags |= REQ_META;
> +		opf |= REQ_META;
>  	if (buffer_prio(bh))
> -		op_flags |= REQ_PRIO;
> +		opf |= REQ_PRIO;
>  
> -	bio = bio_alloc(bh->b_bdev, 1, op | op_flags, GFP_NOIO);
> +	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
>  
>  	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
>  
> @@ -3040,9 +3041,9 @@ static int submit_bh_wbc(enum req_op op, blk_opf_t op_flags,
>  	return 0;
>  }
>  
> -int submit_bh(enum req_op op, blk_opf_t op_flags, struct buffer_head *bh)
> +int submit_bh(blk_opf_t opf, struct buffer_head *bh)
>  {
> -	return submit_bh_wbc(op, op_flags, bh, NULL);
> +	return submit_bh_wbc(opf, bh, NULL);
>  }
>  EXPORT_SYMBOL(submit_bh);
>  
> @@ -3072,9 +3073,9 @@ EXPORT_SYMBOL(submit_bh);
>   * All of the buffers must be for the same device, and must also be a
>   * multiple of the current approved size for the device.
>   */
> -void ll_rw_block(enum req_op op, blk_opf_t op_flags, int nr,
> -		 struct buffer_head *bhs[])
> +void ll_rw_block(const blk_opf_t opf, int nr, struct buffer_head *bhs[])
>  {
> +	const enum req_op op = opf & REQ_OP_MASK;
>  	int i;
>  
>  	for (i = 0; i < nr; i++) {
> @@ -3086,14 +3087,14 @@ void ll_rw_block(enum req_op op, blk_opf_t op_flags, int nr,
>  			if (test_clear_buffer_dirty(bh)) {
>  				bh->b_end_io = end_buffer_write_sync;
>  				get_bh(bh);
> -				submit_bh(op, op_flags, bh);
> +				submit_bh(opf, bh);
>  				continue;
>  			}
>  		} else {
>  			if (!buffer_uptodate(bh)) {
>  				bh->b_end_io = end_buffer_read_sync;
>  				get_bh(bh);
> -				submit_bh(op, op_flags, bh);
> +				submit_bh(opf, bh);
>  				continue;
>  			}
>  		}
> @@ -3111,7 +3112,7 @@ void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
>  	}
>  	bh->b_end_io = end_buffer_write_sync;
>  	get_bh(bh);
> -	submit_bh(REQ_OP_WRITE, op_flags, bh);
> +	submit_bh(REQ_OP_WRITE | op_flags, bh);
>  }
>  EXPORT_SYMBOL(write_dirty_buffer);
>  
> @@ -3138,7 +3139,7 @@ int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
>  
>  		get_bh(bh);
>  		bh->b_end_io = end_buffer_write_sync;
> -		ret = submit_bh(REQ_OP_WRITE, op_flags, bh);
> +		ret = submit_bh(REQ_OP_WRITE | op_flags, bh);
>  		wait_on_buffer(bh);
>  		if (!ret && !buffer_uptodate(bh))
>  			ret = -EIO;
> @@ -3366,7 +3367,7 @@ int bh_submit_read(struct buffer_head *bh)
>  
>  	get_bh(bh);
>  	bh->b_end_io = end_buffer_read_sync;
> -	submit_bh(REQ_OP_READ, 0, bh);
> +	submit_bh(REQ_OP_READ, bh);
>  	wait_on_buffer(bh);
>  	if (buffer_uptodate(bh))
>  		return 0;
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 795a60ad1897..0df5482c6c1c 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -668,7 +668,7 @@ static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
>  	set_buffer_dirty(bh);
>  	set_buffer_uptodate(bh);
>  	bh->b_end_io = ext4_end_buffer_io_sync;
> -	submit_bh(REQ_OP_WRITE, write_flags, bh);
> +	submit_bh(REQ_OP_WRITE | write_flags, bh);
>  	EXT4_SB(sb)->s_fc_bh = NULL;
>  }
>  
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index b221f313ded6..9af68a7ecdcf 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -52,7 +52,7 @@ static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
>  	lock_buffer(bh);
>  	bh->b_end_io = end_buffer_write_sync;
>  	get_bh(bh);
> -	submit_bh(REQ_OP_WRITE, REQ_SYNC | REQ_META | REQ_PRIO, bh);
> +	submit_bh(REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO, bh);
>  	wait_on_buffer(bh);
>  	sb_end_write(sb);
>  	if (unlikely(!buffer_uptodate(bh)))
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 845f2f8aee5f..24922184b622 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -171,7 +171,7 @@ static inline void __ext4_read_bh(struct buffer_head *bh, int op_flags,
>  
>  	bh->b_end_io = end_io ? end_io : end_buffer_read_sync;
>  	get_bh(bh);
> -	submit_bh(REQ_OP_READ, op_flags, bh);
> +	submit_bh(REQ_OP_READ | op_flags, bh);
>  }
>  
>  void ext4_read_bh_nowait(struct buffer_head *bh, int op_flags,
> @@ -5939,8 +5939,8 @@ static int ext4_commit_super(struct super_block *sb)
>  	/* Clear potential dirty bit if it was journalled update */
>  	clear_buffer_dirty(sbh);
>  	sbh->b_end_io = end_buffer_write_sync;
> -	submit_bh(REQ_OP_WRITE,
> -		  REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0), sbh);
> +	submit_bh(REQ_OP_WRITE | REQ_SYNC |
> +		  (test_opt(sb, BARRIER) ? REQ_FUA : 0), sbh);
>  	wait_on_buffer(sbh);
>  	if (buffer_write_io_error(sbh)) {
>  		ext4_msg(sb, KERN_ERR, "I/O error while writing "
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index b6697333bb2b..3bdb2c668a71 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -310,9 +310,8 @@ static void gfs2_metapath_ra(struct gfs2_glock *gl, __be64 *start, __be64 *end)
>  		if (trylock_buffer(rabh)) {
>  			if (!buffer_uptodate(rabh)) {
>  				rabh->b_end_io = end_buffer_read_sync;
> -				submit_bh(REQ_OP_READ,
> -					  REQ_RAHEAD | REQ_META | REQ_PRIO,
> -					  rabh);
> +				submit_bh(REQ_OP_READ | REQ_RAHEAD | REQ_META |
> +					  REQ_PRIO, rabh);
>  				continue;
>  			}
>  			unlock_buffer(rabh);
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index 42b7dfffb5e7..a0562dd1bada 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -1508,9 +1508,8 @@ static void gfs2_dir_readahead(struct inode *inode, unsigned hsize, u32 index,
>  				continue;
>  			}
>  			bh->b_end_io = end_buffer_read_sync;
> -			submit_bh(REQ_OP_READ,
> -				  REQ_RAHEAD | REQ_META | REQ_PRIO,
> -				  bh);
> +			submit_bh(REQ_OP_READ | REQ_RAHEAD | REQ_META |
> +				  REQ_PRIO, bh);
>  			continue;
>  		}
>  		brelse(bh);
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index 868dcc71b581..3570739f005d 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -75,7 +75,7 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
>  	do {
>  		struct buffer_head *next = bh->b_this_page;
>  		if (buffer_async_write(bh)) {
> -			submit_bh(REQ_OP_WRITE, write_flags, bh);
> +			submit_bh(REQ_OP_WRITE | write_flags, bh);
>  			nr_underway++;
>  		}
>  		bh = next;
> @@ -527,7 +527,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
>  	if (buffer_uptodate(first_bh))
>  		goto out;
>  	if (!buffer_locked(first_bh))
> -		ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1, &first_bh);
> +		ll_rw_block(REQ_OP_READ | REQ_META | REQ_PRIO, 1, &first_bh);
>  
>  	dblock++;
>  	extlen--;
> @@ -536,9 +536,8 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
>  		bh = gfs2_getbuf(gl, dblock, CREATE);
>  
>  		if (!buffer_uptodate(bh) && !buffer_locked(bh))
> -			ll_rw_block(REQ_OP_READ,
> -				    REQ_RAHEAD | REQ_META | REQ_PRIO,
> -				    1, &bh);
> +			ll_rw_block(REQ_OP_READ | REQ_RAHEAD | REQ_META |
> +				    REQ_PRIO, 1, &bh);
>  		brelse(bh);
>  		dblock++;
>  		extlen--;
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 59d727a4ae2c..c98a7faa67d3 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -746,7 +746,7 @@ static int gfs2_write_buf_to_page(struct gfs2_inode *ip, unsigned long index,
>  		if (PageUptodate(page))
>  			set_buffer_uptodate(bh);
>  		if (!buffer_uptodate(bh)) {
> -			ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1, &bh);
> +			ll_rw_block(REQ_OP_READ | REQ_META | REQ_PRIO, 1, &bh);
>  			wait_on_buffer(bh);
>  			if (!buffer_uptodate(bh))
>  				goto unlock_out;
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index 95a19f25d61c..b466172eec25 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -82,7 +82,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  		return 0;
>  	}
>  	haveblocks = isofs_get_blocks(inode, blocknum, bhs, needblocks);
> -	ll_rw_block(REQ_OP_READ, 0, haveblocks, bhs);
> +	ll_rw_block(REQ_OP_READ, haveblocks, bhs);
>  
>  	curbh = 0;
>  	curpage = 0;
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index eb315e81f1a6..890b5543a1c5 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -155,10 +155,10 @@ static int journal_submit_commit_record(journal_t *journal,
>  
>  	if (journal->j_flags & JBD2_BARRIER &&
>  	    !jbd2_has_feature_async_commit(journal))
> -		ret = submit_bh(REQ_OP_WRITE,
> -			REQ_SYNC | REQ_PREFLUSH | REQ_FUA, bh);
> +		ret = submit_bh(REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH |
> +				REQ_FUA, bh);
>  	else
> -		ret = submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
> +		ret = submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
>  
>  	*cbh = bh;
>  	return ret;
> @@ -763,7 +763,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  				clear_buffer_dirty(bh);
>  				set_buffer_uptodate(bh);
>  				bh->b_end_io = journal_end_buffer_io_sync;
> -				submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
> +				submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
>  			}
>  			cond_resched();
>  
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 9015f5fa2862..07e6aaf7e213 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1638,7 +1638,7 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
>  		sb->s_checksum = jbd2_superblock_csum(journal, sb);
>  	get_bh(bh);
>  	bh->b_end_io = end_buffer_write_sync;
> -	ret = submit_bh(REQ_OP_WRITE, write_flags, bh);
> +	ret = submit_bh(REQ_OP_WRITE | write_flags, bh);
>  	wait_on_buffer(bh);
>  	if (buffer_write_io_error(bh)) {
>  		clear_buffer_write_io_error(bh);
> @@ -1900,7 +1900,7 @@ static int journal_get_superblock(journal_t *journal)
>  
>  	J_ASSERT(bh != NULL);
>  	if (!buffer_uptodate(bh)) {
> -		ll_rw_block(REQ_OP_READ, 0, 1, &bh);
> +		ll_rw_block(REQ_OP_READ, 1, &bh);
>  		wait_on_buffer(bh);
>  		if (!buffer_uptodate(bh)) {
>  			printk(KERN_ERR
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 8ca3527189f8..e699d6ab2c0e 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -100,7 +100,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
>  		if (!buffer_uptodate(bh) && !buffer_locked(bh)) {
>  			bufs[nbufs++] = bh;
>  			if (nbufs == MAXBUF) {
> -				ll_rw_block(REQ_OP_READ, 0, nbufs, bufs);
> +				ll_rw_block(REQ_OP_READ, nbufs, bufs);
>  				journal_brelse_array(bufs, nbufs);
>  				nbufs = 0;
>  			}
> @@ -109,7 +109,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
>  	}
>  
>  	if (nbufs)
> -		ll_rw_block(REQ_OP_READ, 0, nbufs, bufs);
> +		ll_rw_block(REQ_OP_READ, nbufs, bufs);
>  	err = 0;
>  
>  failed:
> diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
> index ca611ac09f7c..5c39efbf733f 100644
> --- a/fs/nilfs2/btnode.c
> +++ b/fs/nilfs2/btnode.c
> @@ -122,7 +122,7 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
>  	bh->b_blocknr = pblocknr; /* set block address for read */
>  	bh->b_end_io = end_buffer_read_sync;
>  	get_bh(bh);
> -	submit_bh(mode, mode_flags, bh);
> +	submit_bh(mode | mode_flags, bh);
>  	bh->b_blocknr = blocknr; /* set back to the given block address */
>  	*submit_ptr = pblocknr;
>  	err = 0;
> diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
> index 04fdd420eae7..847def8af315 100644
> --- a/fs/nilfs2/gcinode.c
> +++ b/fs/nilfs2/gcinode.c
> @@ -92,7 +92,7 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
>  	bh->b_blocknr = pbn;
>  	bh->b_end_io = end_buffer_read_sync;
>  	get_bh(bh);
> -	submit_bh(REQ_OP_READ, 0, bh);
> +	submit_bh(REQ_OP_READ, bh);
>  	if (vbn)
>  		bh->b_blocknr = vbn;
>   out:
> diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
> index d29a0f2b9c16..66e8811c2528 100644
> --- a/fs/nilfs2/mdt.c
> +++ b/fs/nilfs2/mdt.c
> @@ -148,7 +148,7 @@ nilfs_mdt_submit_block(struct inode *inode, unsigned long blkoff,
>  
>  	bh->b_end_io = end_buffer_read_sync;
>  	get_bh(bh);
> -	submit_bh(mode, mode_flags, bh);
> +	submit_bh(mode | mode_flags, bh);
>  	ret = 0;
>  
>  	trace_nilfs2_mdt_submit_block(inode, inode->i_ino, blkoff, mode);
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index 9e3964ea2ea0..b5765fdb3a47 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -342,7 +342,7 @@ static int ntfs_read_block(struct page *page)
>  		for (i = 0; i < nr; i++) {
>  			tbh = arr[i];
>  			if (likely(!buffer_uptodate(tbh)))
> -				submit_bh(REQ_OP_READ, 0, tbh);
> +				submit_bh(REQ_OP_READ, tbh);
>  			else
>  				ntfs_end_buffer_async_read(tbh, 1);
>  		}
> @@ -859,7 +859,7 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
>  	do {
>  		struct buffer_head *next = bh->b_this_page;
>  		if (buffer_async_write(bh)) {
> -			submit_bh(REQ_OP_WRITE, 0, bh);
> +			submit_bh(REQ_OP_WRITE, bh);
>  			need_end_writeback = false;
>  		}
>  		bh = next;
> @@ -1187,7 +1187,7 @@ static int ntfs_write_mst_block(struct page *page,
>  		BUG_ON(!buffer_mapped(tbh));
>  		get_bh(tbh);
>  		tbh->b_end_io = end_buffer_write_sync;
> -		submit_bh(REQ_OP_WRITE, 0, tbh);
> +		submit_bh(REQ_OP_WRITE, tbh);
>  	}
>  	/* Synchronize the mft mirror now if not @sync. */
>  	if (is_mft && !sync)
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index a60f543e7557..587e9b187873 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -658,7 +658,7 @@ int ntfs_read_compressed_block(struct page *page)
>  		}
>  		get_bh(tbh);
>  		tbh->b_end_io = end_buffer_read_sync;
> -		submit_bh(REQ_OP_READ, 0, tbh);
> +		submit_bh(REQ_OP_READ, tbh);
>  	}
>  
>  	/* Wait for io completion on all buffer heads. */
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index a8abe2296514..46ed69b86c33 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -537,7 +537,7 @@ static inline int ntfs_submit_bh_for_read(struct buffer_head *bh)
>  	lock_buffer(bh);
>  	get_bh(bh);
>  	bh->b_end_io = end_buffer_read_sync;
> -	return submit_bh(REQ_OP_READ, 0, bh);
> +	return submit_bh(REQ_OP_READ, bh);
>  }
>  
>  /**
> diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
> index bc1bf217b38e..6ce60ffc6ac0 100644
> --- a/fs/ntfs/logfile.c
> +++ b/fs/ntfs/logfile.c
> @@ -807,7 +807,7 @@ bool ntfs_empty_logfile(struct inode *log_vi)
>  			 * completed ignore errors afterwards as we can assume
>  			 * that if one buffer worked all of them will work.
>  			 */
> -			submit_bh(REQ_OP_WRITE, 0, bh);
> +			submit_bh(REQ_OP_WRITE, bh);
>  			if (should_wait) {
>  				should_wait = false;
>  				wait_on_buffer(bh);
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index 0d62cd5bb7f8..f7bf5ce960cc 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -583,7 +583,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
>  			clear_buffer_dirty(tbh);
>  			get_bh(tbh);
>  			tbh->b_end_io = end_buffer_write_sync;
> -			submit_bh(REQ_OP_WRITE, 0, tbh);
> +			submit_bh(REQ_OP_WRITE, tbh);
>  		}
>  		/* Wait on i/o completion of buffers. */
>  		for (i_bhs = 0; i_bhs < nr_bhs; i_bhs++) {
> @@ -780,7 +780,7 @@ int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync)
>  		clear_buffer_dirty(tbh);
>  		get_bh(tbh);
>  		tbh->b_end_io = end_buffer_write_sync;
> -		submit_bh(REQ_OP_WRITE, 0, tbh);
> +		submit_bh(REQ_OP_WRITE, tbh);
>  	}
>  	/* Synchronize the mft mirror now if not @sync. */
>  	if (!sync && ni->mft_no < vol->mftmirr_size)
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 8e9d2b35175f..4a21745711fe 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -242,7 +242,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
>  				lock_buffer(bh);
>  				bh->b_end_io = end_buffer_read_sync;
>  				get_bh(bh);
> -				submit_bh(REQ_OP_READ, 0, bh);
> +				submit_bh(REQ_OP_READ, bh);
>  
>  				wait_on_buffer(bh);
>  				if (!buffer_uptodate(bh)) {
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index be4ebdd8048b..d100a063def2 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -629,7 +629,7 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
>  			bh->b_size = block_size;
>  			off = vbo & (PAGE_SIZE - 1);
>  			set_bh_page(bh, page, off);
> -			ll_rw_block(REQ_OP_READ, 0, 1, &bh);
> +			ll_rw_block(REQ_OP_READ, 1, &bh);
>  			wait_on_buffer(bh);
>  			if (!buffer_uptodate(bh)) {
>  				err = -EIO;
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index 35d40a67204c..304ed2be1b83 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -638,7 +638,7 @@ int ocfs2_map_page_blocks(struct page *page, u64 *p_blkno,
>  			   !buffer_new(bh) &&
>  			   ocfs2_should_read_blk(inode, page, block_start) &&
>  			   (block_start < from || block_end > to)) {
> -			ll_rw_block(REQ_OP_READ, 0, 1, &bh);
> +			ll_rw_block(REQ_OP_READ, 1, &bh);
>  			*wait_bh++=bh;
>  		}
>  
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index e7758778abef..196638a22b48 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -64,7 +64,7 @@ int ocfs2_write_block(struct ocfs2_super *osb, struct buffer_head *bh,
>  
>  	get_bh(bh); /* for end_buffer_write_sync() */
>  	bh->b_end_io = end_buffer_write_sync;
> -	submit_bh(REQ_OP_WRITE, 0, bh);
> +	submit_bh(REQ_OP_WRITE, bh);
>  
>  	wait_on_buffer(bh);
>  
> @@ -147,7 +147,7 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
>  
>  		get_bh(bh); /* for end_buffer_read_sync() */
>  		bh->b_end_io = end_buffer_read_sync;
> -		submit_bh(REQ_OP_READ, 0, bh);
> +		submit_bh(REQ_OP_READ, bh);
>  	}
>  
>  read_failure:
> @@ -328,7 +328,7 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>  			if (validate)
>  				set_buffer_needs_validate(bh);
>  			bh->b_end_io = end_buffer_read_sync;
> -			submit_bh(REQ_OP_READ, 0, bh);
> +			submit_bh(REQ_OP_READ, bh);
>  			continue;
>  		}
>  	}
> @@ -449,7 +449,7 @@ int ocfs2_write_super_or_backup(struct ocfs2_super *osb,
>  	get_bh(bh); /* for end_buffer_write_sync() */
>  	bh->b_end_io = end_buffer_write_sync;
>  	ocfs2_compute_meta_ecc(osb->sb, bh->b_data, &di->i_check);
> -	submit_bh(REQ_OP_WRITE, 0, bh);
> +	submit_bh(REQ_OP_WRITE, bh);
>  
>  	wait_on_buffer(bh);
>  
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index f7298816d8d9..e68807196076 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -1785,7 +1785,7 @@ static int ocfs2_get_sector(struct super_block *sb,
>  	if (!buffer_dirty(*bh))
>  		clear_buffer_uptodate(*bh);
>  	unlock_buffer(*bh);
> -	ll_rw_block(REQ_OP_READ, 0, 1, bh);
> +	ll_rw_block(REQ_OP_READ, 1, bh);
>  	wait_on_buffer(*bh);
>  	if (!buffer_uptodate(*bh)) {
>  		mlog_errno(-EIO);
> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
> index 0cffe054b78e..23f542d1748b 100644
> --- a/fs/reiserfs/inode.c
> +++ b/fs/reiserfs/inode.c
> @@ -2664,7 +2664,7 @@ static int reiserfs_write_full_page(struct page *page,
>  	do {
>  		struct buffer_head *next = bh->b_this_page;
>  		if (buffer_async_write(bh)) {
> -			submit_bh(REQ_OP_WRITE, 0, bh);
> +			submit_bh(REQ_OP_WRITE, bh);
>  			nr++;
>  		}
>  		put_bh(bh);
> @@ -2724,7 +2724,7 @@ static int reiserfs_write_full_page(struct page *page,
>  		struct buffer_head *next = bh->b_this_page;
>  		if (buffer_async_write(bh)) {
>  			clear_buffer_dirty(bh);
> -			submit_bh(REQ_OP_WRITE, 0, bh);
> +			submit_bh(REQ_OP_WRITE, bh);
>  			nr++;
>  		}
>  		put_bh(bh);
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index d8cc9a366124..94addfcefede 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -650,7 +650,7 @@ static void submit_logged_buffer(struct buffer_head *bh)
>  		BUG();
>  	if (!buffer_uptodate(bh))
>  		BUG();
> -	submit_bh(REQ_OP_WRITE, 0, bh);
> +	submit_bh(REQ_OP_WRITE, bh);
>  }
>  
>  static void submit_ordered_buffer(struct buffer_head *bh)
> @@ -660,7 +660,7 @@ static void submit_ordered_buffer(struct buffer_head *bh)
>  	clear_buffer_dirty(bh);
>  	if (!buffer_uptodate(bh))
>  		BUG();
> -	submit_bh(REQ_OP_WRITE, 0, bh);
> +	submit_bh(REQ_OP_WRITE, bh);
>  }
>  
>  #define CHUNK_SIZE 32
> @@ -868,7 +868,7 @@ static int write_ordered_buffers(spinlock_t * lock,
>  		 */
>  		if (buffer_dirty(bh) && unlikely(bh->b_page->mapping == NULL)) {
>  			spin_unlock(lock);
> -			ll_rw_block(REQ_OP_WRITE, 0, 1, &bh);
> +			ll_rw_block(REQ_OP_WRITE, 1, &bh);
>  			spin_lock(lock);
>  		}
>  		put_bh(bh);
> @@ -1054,7 +1054,7 @@ static int flush_commit_list(struct super_block *s,
>  		if (tbh) {
>  			if (buffer_dirty(tbh)) {
>  		            depth = reiserfs_write_unlock_nested(s);
> -			    ll_rw_block(REQ_OP_WRITE, 0, 1, &tbh);
> +			    ll_rw_block(REQ_OP_WRITE, 1, &tbh);
>  			    reiserfs_write_lock_nested(s, depth);
>  			}
>  			put_bh(tbh) ;
> @@ -2240,7 +2240,7 @@ static int journal_read_transaction(struct super_block *sb,
>  		}
>  	}
>  	/* read in the log blocks, memcpy to the corresponding real block */
> -	ll_rw_block(REQ_OP_READ, 0, get_desc_trans_len(desc), log_blocks);
> +	ll_rw_block(REQ_OP_READ, get_desc_trans_len(desc), log_blocks);
>  	for (i = 0; i < get_desc_trans_len(desc); i++) {
>  
>  		wait_on_buffer(log_blocks[i]);
> @@ -2342,7 +2342,7 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
>  		} else
>  			bhlist[j++] = bh;
>  	}
> -	ll_rw_block(REQ_OP_READ, 0, j, bhlist);
> +	ll_rw_block(REQ_OP_READ, j, bhlist);
>  	for (i = 1; i < j; i++)
>  		brelse(bhlist[i]);
>  	bh = bhlist[0];
> diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
> index ef42729216d1..9a293609a022 100644
> --- a/fs/reiserfs/stree.c
> +++ b/fs/reiserfs/stree.c
> @@ -579,7 +579,7 @@ static int search_by_key_reada(struct super_block *s,
>  		if (!buffer_uptodate(bh[j])) {
>  			if (depth == -1)
>  				depth = reiserfs_write_unlock_nested(s);
> -			ll_rw_block(REQ_OP_READ, REQ_RAHEAD, 1, bh + j);
> +			ll_rw_block(REQ_OP_READ | REQ_RAHEAD, 1, bh + j);
>  		}
>  		brelse(bh[j]);
>  	}
> @@ -685,7 +685,7 @@ int search_by_key(struct super_block *sb, const struct cpu_key *key,
>  			if (!buffer_uptodate(bh) && depth == -1)
>  				depth = reiserfs_write_unlock_nested(sb);
>  
> -			ll_rw_block(REQ_OP_READ, 0, 1, &bh);
> +			ll_rw_block(REQ_OP_READ, 1, &bh);
>  			wait_on_buffer(bh);
>  
>  			if (depth != -1)
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index cfb7c44c7366..c88cd2ce0665 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -1702,7 +1702,7 @@ static int read_super_block(struct super_block *s, int offset)
>  /* after journal replay, reread all bitmap and super blocks */
>  static int reread_meta_blocks(struct super_block *s)
>  {
> -	ll_rw_block(REQ_OP_READ, 0, 1, &SB_BUFFER_WITH_SB(s));
> +	ll_rw_block(REQ_OP_READ, 1, &SB_BUFFER_WITH_SB(s));
>  	wait_on_buffer(SB_BUFFER_WITH_SB(s));
>  	if (!buffer_uptodate(SB_BUFFER_WITH_SB(s))) {
>  		reiserfs_warning(s, "reiserfs-2504", "error reading the super");
> diff --git a/fs/udf/dir.c b/fs/udf/dir.c
> index 42e3e551fa4c..cad3772f9dbe 100644
> --- a/fs/udf/dir.c
> +++ b/fs/udf/dir.c
> @@ -130,7 +130,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
>  					brelse(tmp);
>  			}
>  			if (num) {
> -				ll_rw_block(REQ_OP_READ, REQ_RAHEAD, num, bha);
> +				ll_rw_block(REQ_OP_READ | REQ_RAHEAD, num, bha);
>  				for (i = 0; i < num; i++)
>  					brelse(bha[i]);
>  			}
> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index 73720320f0ab..a2adf6293093 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -89,7 +89,7 @@ struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
>  					brelse(tmp);
>  			}
>  			if (num) {
> -				ll_rw_block(REQ_OP_READ, REQ_RAHEAD, num, bha);
> +				ll_rw_block(REQ_OP_READ | REQ_RAHEAD, num, bha);
>  				for (i = 0; i < num; i++)
>  					brelse(bha[i]);
>  			}
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index edc88716751a..8d06daed549f 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -1214,7 +1214,7 @@ struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
>  	if (buffer_uptodate(bh))
>  		return bh;
>  
> -	ll_rw_block(REQ_OP_READ, 0, 1, &bh);
> +	ll_rw_block(REQ_OP_READ, 1, &bh);
>  
>  	wait_on_buffer(bh);
>  	if (buffer_uptodate(bh))
> diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
> index 075d3d9114c8..bd810d8239f2 100644
> --- a/fs/ufs/balloc.c
> +++ b/fs/ufs/balloc.c
> @@ -296,7 +296,7 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
>  			if (!buffer_mapped(bh))
>  					map_bh(bh, inode->i_sb, oldb + pos);
>  			if (!buffer_uptodate(bh)) {
> -				ll_rw_block(REQ_OP_READ, 0, 1, &bh);
> +				ll_rw_block(REQ_OP_READ, 1, &bh);
>  				wait_on_buffer(bh);
>  				if (!buffer_uptodate(bh)) {
>  					ufs_error(inode->i_sb, __func__,
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 9795df9400bd..bb68eb6407da 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -202,11 +202,11 @@ struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
>  void free_buffer_head(struct buffer_head * bh);
>  void unlock_buffer(struct buffer_head *bh);
>  void __lock_buffer(struct buffer_head *bh);
> -void ll_rw_block(enum req_op, blk_opf_t, int, struct buffer_head * bh[]);
> +void ll_rw_block(blk_opf_t, int, struct buffer_head * bh[]);
>  int sync_dirty_buffer(struct buffer_head *bh);
>  int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
>  void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
> -int submit_bh(enum req_op, blk_opf_t, struct buffer_head *);
> +int submit_bh(blk_opf_t, struct buffer_head *);
>  void write_boundary_block(struct block_device *bdev,
>  			sector_t bblock, unsigned blocksize);
>  int bh_uptodate_or_lock(struct buffer_head *bh);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
