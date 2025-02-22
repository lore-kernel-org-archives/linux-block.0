Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C791EDA17
	for <linux-block@vger.kernel.org>; Sat, 22 Feb 2025 21:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740261161; cv=none; b=GTueMiPvb/ty15hUwdZUHdbgxm5H/kwRNxGF5oI+C/TNjSunP2DRpp2iJXsPiwVsm4gOEbi0k36C5lQitN9BEifEu5IR408SBj87gGk3AXWn4H1OO/RX7+vD8Q92XbJAkoJNlYFu+M0jT5yoaTuSraihDK4ZBSNPx39UMdt2cUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740261161; c=relaxed/simple;
	bh=xCVi61ithFPbNIet1KhwJOyUoTfb1SE3lK337yqFg9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbTecbWXspM291Rf/UAQKWbwPRz5PxHX5ovZv+HWzda/UNJqXqMg+0t9ARDFXEb46CsGgHWcYjpgLbMuFyqrxFy5qDIBXxAaNnaKND78ZyGoh+6PdY0MWHYpKalBHrvyEat5b8hcEfMR9ZRlxscKKwetDa2maPncq5/SSHlVHok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiCb19+t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiCb19+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5743AC4CED1;
	Sat, 22 Feb 2025 21:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740261159;
	bh=xCVi61ithFPbNIet1KhwJOyUoTfb1SE3lK337yqFg9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YiCb19+tljy6BG0z18oOOgCD9XFa6/gPIRYyASmwEGwaUCNU4nTXn7Lhoa9tcqbDv
	 GkFmUbDiz3THFZLuF3/yCmmkoTJ91hnmXNzSTk/t7MofPA2qoOBD/fESDbglPfh1WE
	 oTMZ8gEoq5I9HY0FG+XhvilHSbV351rvDeTJblw49m2fR409AeVkcpEdM76iNrXFcj
	 FOeHtDG808uS/DLvbUd0a7/wgkiiEVGIZh1MBGKBsv7AwegGrG5NweRAQiTAwyvzDL
	 zb/GllY6SC49ouTPPEFJ420MB6tIeOIANAjL+pUOX5cjdC6i+zNfdEE8KXE/eotBtE
	 Adxc0ltC36+sA==
Date: Sat, 22 Feb 2025 22:52:37 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Paul Bunyan <pbunyan@redhat.com>, Yi Zhang <yi.zhang@redhat.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, John Garry <john.g.garry@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <k5chvcua4zff6bmuqosccqp3rzbpjjpnzqgna6c2fdov3wm5ny@pjc4tztceccl>
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

On Wed, Feb 19, 2025 at 10:44:09AM +0100, Ming Lei wrote:
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
> 
> Cc: Daniel Gomez <da.gomez@kernel.org>
> Cc: Paul Bunyan <pbunyan@redhat.com>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

> ---
> V4:
> 	- take Daniel's suggestion to add min_segment_size limit
>     for avoiding to call into split code in case that max_seg_size
>     is > PAGE_SIZE
> 
> V3:
> 	- rephrase commit log & fix patch style(Christoph)
> 	- more comment log(Christoph)
> V2:
> 	- cover bio_split_rw_at()
> 	- add BLK_MIN_SEGMENT_SIZE
> 
> 
>  block/blk-merge.c      |  2 +-
>  block/blk-settings.c   | 14 +++++++++++---
>  block/blk.h            |  8 ++++++--
>  include/linux/blkdev.h |  3 +++
>  4 files changed, 21 insertions(+), 6 deletions(-)
> 
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
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index c44dadc35e1e..703a9217414e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -246,6 +246,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  {
>  	unsigned int max_hw_sectors;
>  	unsigned int logical_block_sectors;
> +	unsigned long seg_size;
>  	int err;
>  
>  	/*
> @@ -303,7 +304,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
>  				lim->max_dev_sectors);
>  	if (lim->max_user_sectors) {
> -		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
> +		if (lim->max_user_sectors < BLK_MIN_SEGMENT_SIZE / SECTOR_SIZE)
>  			return -EINVAL;
>  		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
>  	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
> @@ -341,7 +342,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  	 */
>  	if (!lim->seg_boundary_mask)
>  		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> -	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
> +	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
>  		return -EINVAL;
>  
>  	/*
> @@ -362,10 +363,17 @@ int blk_validate_limits(struct queue_limits *lim)
>  		 */
>  		if (!lim->max_segment_size)
>  			lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> -		if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> +		if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
>  			return -EINVAL;
>  	}
>  
> +	/* setup min segment size for building new segment in fast path */
> +	if (lim->seg_boundary_mask > lim->max_segment_size - 1)
> +		seg_size = lim->max_segment_size;
> +	else
> +		seg_size = lim->seg_boundary_mask + 1;
> +	lim->min_segment_size = min_t(unsigned, seg_size, PAGE_SIZE);
> +
>  	/*
>  	 * We require drivers to at least do logical block aligned I/O, but
>  	 * historically could not check for that due to the separate calls
> diff --git a/block/blk.h b/block/blk.h
> index 90fa5f28ccab..57fe8261e09f 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -358,8 +358,12 @@ struct bio *bio_split_zone_append(struct bio *bio,
>  static inline bool bio_may_need_split(struct bio *bio,
>  		const struct queue_limits *lim)
>  {
> -	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
> -		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
> +	if (lim->chunk_sectors)
> +		return true;
> +	if (bio->bi_vcnt != 1)
> +		return true;
> +	return bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset >
> +		lim->min_segment_size;
>  }
>  
>  /**
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

Is this needed? I think I would not add any comment at all.

> +	BLK_MIN_SEGMENT_SIZE	= 4096,

Now, this is no longer a default so perhaps it can be moved along with
BLK_DEV_MAX_SECTORS in block/blk.h.

>  	BLK_MAX_SEGMENT_SIZE	= 65536,
>  	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
>  };
> -- 
> 2.47.1
> 
