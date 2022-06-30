Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E33C43334
	for <linux-block@archiver.kernel.org>; Thu, 30 Jun 2022 08:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiF3Ieg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jun 2022 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiF3Ief (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 04:34:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C301F2252D
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 01:34:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7CAE51F9DC;
        Thu, 30 Jun 2022 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656578072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVIsZ8Orktq2gYRd9xfni6qDmSFabiL1jchYMv8NRAI=;
        b=GSFrj8VLncPrbRP/BZh8z959dUU+ub8B0tGGQU30WhacNQ8nWjJcRXeFlag75VZ/Ae8pmh
        YxPsjqQqJDzG3hcXwHZGYF4723Sm2ZIdQJdt6wW4VJ6jXH+3o+Uf1Q7uSs6GR3jwuM8ZLt
        wn70VqdFzomvt04qVgR7oZoHjHsdM4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656578072;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVIsZ8Orktq2gYRd9xfni6qDmSFabiL1jchYMv8NRAI=;
        b=7XgOqn+v0b3egDpUVkbkKiSu+nwzajpl25xnlDX1ljo8ER0Nwh0FTsfPUmuoiGuGSD1rcp
        5e+i1MJscjzRg6Dg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5C0482C141;
        Thu, 30 Jun 2022 08:34:32 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1F764A061F; Thu, 30 Jun 2022 10:34:32 +0200 (CEST)
Date:   Thu, 30 Jun 2022 10:34:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 46/63] fs/buffer: Use the new blk_opf_t type
Message-ID: <20220630083432.244d5rgdzxe72eru@quack3.lan>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-47-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629233145.2779494-47-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 29-06-22 16:31:28, Bart Van Assche wrote:
> Improve static type checking by using the new blk_opf_t type for block layer
> request flags. Change WRITE into REQ_OP_WRITE. This patch does not change
> any functionality since REQ_OP_WRITE == WRITE == 1.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 21 +++++++++++----------
>  include/linux/buffer_head.h |  9 +++++----
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 898c7f301b1b..4a00b61f35ec 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -52,8 +52,8 @@
>  #include "internal.h"
>  
>  static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
> -static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
> -			 struct writeback_control *wbc);
> +static int submit_bh_wbc(enum req_op op, blk_opf_t op_flags,
> +			 struct buffer_head *bh, struct writeback_control *wbc);
>  
>  #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
>  
> @@ -1716,7 +1716,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
>  	struct buffer_head *bh, *head;
>  	unsigned int blocksize, bbits;
>  	int nr_underway = 0;
> -	int write_flags = wbc_to_write_flags(wbc);
> +	blk_opf_t write_flags = wbc_to_write_flags(wbc);
>  
>  	head = create_page_buffers(page, inode,
>  					(1 << BH_Dirty)|(1 << BH_Uptodate));
> @@ -2994,8 +2994,8 @@ static void end_bio_bh_io_sync(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> -static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
> -			 struct writeback_control *wbc)
> +static int submit_bh_wbc(enum req_op op, blk_opf_t op_flags,
> +			 struct buffer_head *bh, struct writeback_control *wbc)
>  {
>  	struct bio *bio;
>  
> @@ -3040,7 +3040,7 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
>  	return 0;
>  }
>  
> -int submit_bh(int op, int op_flags, struct buffer_head *bh)
> +int submit_bh(enum req_op op, blk_opf_t op_flags, struct buffer_head *bh)
>  {
>  	return submit_bh_wbc(op, op_flags, bh, NULL);
>  }
> @@ -3072,7 +3072,8 @@ EXPORT_SYMBOL(submit_bh);
>   * All of the buffers must be for the same device, and must also be a
>   * multiple of the current approved size for the device.
>   */
> -void ll_rw_block(int op, int op_flags,  int nr, struct buffer_head *bhs[])
> +void ll_rw_block(enum req_op op, blk_opf_t op_flags, int nr,
> +		 struct buffer_head *bhs[])
>  {
>  	int i;
>  
> @@ -3081,7 +3082,7 @@ void ll_rw_block(int op, int op_flags,  int nr, struct buffer_head *bhs[])
>  
>  		if (!trylock_buffer(bh))
>  			continue;
> -		if (op == WRITE) {
> +		if (op == REQ_OP_WRITE) {
>  			if (test_clear_buffer_dirty(bh)) {
>  				bh->b_end_io = end_buffer_write_sync;
>  				get_bh(bh);
> @@ -3101,7 +3102,7 @@ void ll_rw_block(int op, int op_flags,  int nr, struct buffer_head *bhs[])
>  }
>  EXPORT_SYMBOL(ll_rw_block);
>  
> -void write_dirty_buffer(struct buffer_head *bh, int op_flags)
> +void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
>  {
>  	lock_buffer(bh);
>  	if (!test_clear_buffer_dirty(bh)) {
> @@ -3119,7 +3120,7 @@ EXPORT_SYMBOL(write_dirty_buffer);
>   * and then start new I/O and then wait upon it.  The caller must have a ref on
>   * the buffer_head.
>   */
> -int __sync_dirty_buffer(struct buffer_head *bh, int op_flags)
> +int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
>  {
>  	int ret = 0;
>  
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index c9d1463bb20f..9795df9400bd 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -9,6 +9,7 @@
>  #define _LINUX_BUFFER_HEAD_H
>  
>  #include <linux/types.h>
> +#include <linux/blk_types.h>
>  #include <linux/fs.h>
>  #include <linux/linkage.h>
>  #include <linux/pagemap.h>
> @@ -201,11 +202,11 @@ struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
>  void free_buffer_head(struct buffer_head * bh);
>  void unlock_buffer(struct buffer_head *bh);
>  void __lock_buffer(struct buffer_head *bh);
> -void ll_rw_block(int, int, int, struct buffer_head * bh[]);
> +void ll_rw_block(enum req_op, blk_opf_t, int, struct buffer_head * bh[]);
>  int sync_dirty_buffer(struct buffer_head *bh);
> -int __sync_dirty_buffer(struct buffer_head *bh, int op_flags);
> -void write_dirty_buffer(struct buffer_head *bh, int op_flags);
> -int submit_bh(int, int, struct buffer_head *);
> +int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
> +void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
> +int submit_bh(enum req_op, blk_opf_t, struct buffer_head *);
>  void write_boundary_block(struct block_device *bdev,
>  			sector_t bblock, unsigned blocksize);
>  int bh_uptodate_or_lock(struct buffer_head *bh);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
