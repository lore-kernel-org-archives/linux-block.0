Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2081FBCB9
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168764; cv=none; b=XVtjdTVbpJdyZqzpcMmDrZz2NOKAkTYs2VYVn8TKTNiSoHwbQwKmHByTsDZbTIKlG5+uoDCS0tU56RHSEBGAgO36vulbxQSrKWeVELzLQGxaQQptB1Q8O5AoN57NKRZ+5hq3p6HJk/XOiSypMqJ+KET119nH5fI46RAS+BMZyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168764; c=relaxed/simple;
	bh=ClauqscQZc6uFxID1QZHfzCv3g9MUFMdEtlZL9bIgJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhi7gJyMapMQR2/V5aIQaYh/i/BUoyGf+Ua3jRWWTgdnYvGf3sdNjU+ABdMjCkfKL2oJizeF82KaYkXd+3KtbYqkRtZUg/pdYWyk1twrbukwwJsTo1j8UxSZXSkGP07iykT0rzBO8Ld+9Dq+m/k2enW2Z62OE5FN/UbpNrh9ONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTqxwLte; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTqxwLte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B1BC4CED6;
	Fri, 21 Feb 2025 20:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740168764;
	bh=ClauqscQZc6uFxID1QZHfzCv3g9MUFMdEtlZL9bIgJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTqxwLteSg0hXQC5Z1IYVEoskT96N8c2Rsf13HZM8Dy/Qbq8X6GxNJXDpsx3AQ/a9
	 wscYI5DVIDQBF1I1CGtAQ4dEMpUqF9mvRL0RDFsEeQgqCkWsL3mcAIkwt2gZNfW0q6
	 3pkP06aQJqLDwWaJJ7/HdT9jor3lVSxvm0ikdn4EjdYigcLzstI3fYSB7wqLRYpPJ9
	 ZOHOlUyyhoUBFk2juTihyqTyIQc/6YdV7fNoI06A5TpPBk6ztoiiDns35OyrGvqOl1
	 xBQ8aCgThE2HbcWWwp7MNJ1kb0rWbQ2LdlfriGdoxaywy9N4OBxfjsDXIBSDmCsj3T
	 /CeXqaIAf/R1w==
Date: Fri, 21 Feb 2025 12:12:42 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Paul Bunyan <pbunyan@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z7jeOpW882Old2Eh@bombadil.infradead.org>
References: <20250219024409.901186-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219024409.901186-1-ming.lei@redhat.com>

On Wed, Feb 19, 2025 at 10:44:09AM +0800, Ming Lei wrote:
> PAGE_SIZE is applied in validating block device queue limits, this way is
> very fragile and is wrong:
> 
> - queue limits are read from hardware, which is often one readonly hardware
> property
> 
> - PAGE_SIZE is one config option which can be changed during build time.
> 
> In RH lab, it has been found that max segment size of some mmc card is
> less than 64K, then this kind of card can't be probed successfully when
> same kernel is re-built with 64K PAGE_SIZE.
> 
> Fix this issue by adding BLK_MIN_SEGMENT_SIZE and lim->min_segment_size:
> 
> - validate segment limits by BLK_MIN_SEGMENT_SIZE which is 4K(minimized PAGE_SIZE)
> 
> - checking if one bvec can be one segment quickly by lim->min_segment_size
> 
> commit 6aeb4f836480 ("block: remove bio_add_pc_page")
> commit 02ee5d69e3ba ("block: remove blk_rq_bio_prep")
> commit b7175e24d6ac ("block: add a dma mapping iterator")

Let me try to help with this commit log message a bit, how about:

Using PAGE_SIZE as a minimum expected DMA segment size in consideration
of devices which have a max DMA segment size of 4k when used on 64k
PAGE_SIZE systems leads to devices not being able to probe such as
eMMC and Exynos UFS controller [0] [1] you can end up with a probe failure
as follows:

WARNING: CPU: 2 PID: 397 at block/blk-settings.c:339 blk_validate_limits+0x364/0x3c0                                                                                           
Modules linked in: mmc_block(+) rpmb_core crct10dif_ce ghash_ce sha2_ce dw_mmc_bluefield sha256_arm64 dw_mmc_pltfm sha1_ce dw_mmc mmc_core nfit i2c_mlxbf sbsa_gwdt gpio_mlxbf2
f_tmfifo dm_mirror dm_region_hash dm_log dm_mod
CPU: 2 UID: 0 PID: 397 Comm: (udev-worker) Not tainted 6.12.0-39.el10.aarch64+64k #1
Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS BlueField:3.5.1-1-g4078432 Jan 28 2021
ng pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)                                                                                                          
pc : blk_validate_limits+0x364/0x3c0                                                                                                                                           
p.service                                                                                                                                                                      
lr : blk_set_default_limits+0x20/0x40                                                                                                                                      
Setup...                                                                                                                                                                       
sp : ffff80008688f2d0                                                                                                                                                          
x29: ffff80008688f2d0 x28: ffff000082acb600 x27: ffff80007bef02a8                                                                                                              
x26: ffff80007bef0000 x25: ffff80008688f58e x24: ffff80008688f450                                                                                                              
x23: ffff80008301b000 x22: 00000000ffffffff x21: ffff800082c39950                                                                                                              
x20: 0000000000000000 x19: ffff0000930169e0 x18: 0000000000000014                                                                                                              
x17: 00000000767472b1 x16: 0000000005a697e6 x15: 0000000002f42ca4                                                                                                              
x11: 00000000de7f0111 x10: 000000005285b53a x9 : ffff800080752908                                                                                                              
x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000200                                                                                                              
x5 : 0000000000000000 x4 : 000000000000ffff x3 : 0000000000004000                                                                                                              
x2 : 0000000000000200 x1 : 0000000000001000 x0 : ffff80008688f450                                                                                                              
Call trace:                                                                                                                                                                    
 blk_validate_limits+0x364/0x3c0                                                                                                                                               
 blk_set_default_limits+0x20/0x40                                                                                                                                              
 blk_alloc_queue+0x84/0x240                                                                                                                                                    
 blk_mq_alloc_queue+0x80/0x118                                                                                                                                                 
 __blk_mq_alloc_disk+0x28/0x198                                                                                                                                                
 mmc_alloc_disk+0xe0/0x260 [mmc_block]                                                                                                                                         
...                                                                                                                                                                                           
mmcblk mmc0:0001: probe with driver mmcblk failed with error -22  

To fix this provide a block sanity check to ensure we use the min of the
block device's segment size and PAGE_SIZE.

Link: https://lore.kernel.org/linux-block/20230612203314.17820-1-bvanassche@acm.org/ # [0]
Link: https://lore.kernel.org/linux-block/1d55e942-5150-de4c-3a02-c3d066f87028@acm.org/ # [1]

> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 15cd231d560c..4fe2dfabfc9d 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -329,7 +329,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  
>  		if (nsegs < lim->max_segments &&
>  		    bytes + bv.bv_len <= max_bytes &&
> -		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
> +		    bv.bv_offset + bv.bv_len <= lim->min_segment_size) {
>  			nsegs++;
>  			bytes += bv.bv_len;
>  		} else {

Now that's certainly more in line with what I expected.

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 248416ecd01c..1f7d492975c1 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -367,6 +367,7 @@ struct queue_limits {
>  	unsigned int		max_sectors;
>  	unsigned int		max_user_sectors;
>  	unsigned int		max_segment_size;
> +	unsigned int		min_segment_size;
>  	unsigned int		physical_block_size;
>  	unsigned int		logical_block_size;
>  	unsigned int		alignment_offset;
> @@ -1163,6 +1164,8 @@ static inline bool bdev_is_partition(struct block_device *bdev)
>  enum blk_default_limits {
>  	BLK_MAX_SEGMENTS	= 128,
>  	BLK_SAFE_MAX_SECTORS	= 255,
> +	/* use minimized PAGE_SIZE as min segment size hint */
> +	BLK_MIN_SEGMENT_SIZE	= 4096,
>  	BLK_MAX_SEGMENT_SIZE	= 65536,
>  	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,

I think Bart provided a more sensible comment:

Use 4 KiB as the smallest default supported DMA segment size limit instead of
PAGE_SIZE. This is important if the page size is larger than 4 KiB since
the maximum DMA segment size for some storage controllers is only 4 KiB.

With that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
