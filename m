Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF620B20B
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525920; cv=none; b=IETDX3DzjMMLtict2C4ImHykaECuB6dsJCPE3iafyO7b3nz/4P9CbZrxuqs46lLlJHlpF+DtLhI6VwwVjBgqHnu3hkivrgP9Sx3z5dRoDozrc4ggKljlJUEgKgrD24oJ1rMURb/hf1Zgx/9SNU5SdoFYMN8cH8Q/uJ2SIw37qx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525920; c=relaxed/simple;
	bh=Ne3ACQYAYUcYBFmSbEOxzigigxdo8XFOI/38WgX0ENM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoOF1EiLd6dPQ3P7sRUQC2bQSCyo6lDNByJA0cbRbKQ/M25tG8Jms7WDZ6JJ4Mww6dWKQ4mwjCKn56oLwgu14PkGHKbeBlTrcGyDUMQNUcay5bMG46zrVTNafaOjnQzt/XU+dP2tXprspw/GKAPyrgkT/cxqc1aZR86kBmSxKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMsN1Oka; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMsN1Oka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B5FC4CED1;
	Fri, 14 Feb 2025 09:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739525919;
	bh=Ne3ACQYAYUcYBFmSbEOxzigigxdo8XFOI/38WgX0ENM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMsN1OkaFMvcMFeNfeihDsm4ASVMka1/ZQHp+Un39DCB+aRkFifXJB5CAQUV19Xog
	 7++VQSLT+ayrJ7eRwaTnj1qrBCnycWxZlEG2Q/Q5gSJOBCUDJURmsqwkquXqhJZcv1
	 kak51bbC84bLvqopi3DKl1EM/jye3OhdebGWsO3GUHlqH0cEUIxarlco0+Tn5KfrVs
	 DmldvACEkrEcAKFpRg5H/uqFSsyFkSi0UwnmH68aG3rqksTfZrX/EB0f6Jnc3Df0r8
	 yamNSAGRIWWqBpKEz7TbiCa1wFCkHd5FXw9j34W7KMUFq9qb2e0c+XamqnTyfzR0kZ
	 0IopT/gpQ+Umw==
Date: Fri, 14 Feb 2025 10:38:36 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Yi Zhang <yi.zhang@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Bart Van Assche <bvanassche@acm.org>, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <ifgg2za26r6frfco4cky6wxywgdj3l7r6hx6sbqarizqltshfx@kccnmlr3x7nq>
References: <20250210090319.1519778-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210090319.1519778-1-ming.lei@redhat.com>

On Mon, Feb 10, 2025 at 05:03:19PM +0100, Ming Lei wrote:
> PAGE_SIZE is applied in some block device queue limits, this way is
> very fragile and is wrong:
> 
> - queue limits are read from hardware, which is often one readonly
> hardware property
> 
> - PAGE_SIZE is one config option which can be changed during build time.
> 
> In RH lab, it has been found that max segment size of some mmc card is
> less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.
> 
> Fix this issue by using BLK_MIN_SEGMENT_SIZE in related code for dealing
> with queue limits and checking if bio needn't split. Define BLK_MIN_SEGMENT_SIZE
> as 4K(minimized PAGE_SIZE).
> 
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Link: https://lore.kernel.org/linux-block/20250102015620.500754-1-ming.lei@redhat.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- cover bio_split_rw_at()
> 	- add BLK_MIN_SEGMENT_SIZE
> 
>  block/blk-merge.c      | 2 +-
>  block/blk-settings.c   | 6 +++---
>  block/blk.h            | 2 +-
>  include/linux/blkdev.h | 1 +
>  4 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 15cd231d560c..b55c52a42303 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -329,7 +329,7 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  
>  		if (nsegs < lim->max_segments &&
>  		    bytes + bv.bv_len <= max_bytes &&
> -		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
> +		    bv.bv_offset + bv.bv_len <= BLK_MIN_SEGMENT_SIZE) {
>  			nsegs++;
>  			bytes += bv.bv_len;
>  		} else {
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index c44dadc35e1e..539a64ad7989 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -303,7 +303,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
>  				lim->max_dev_sectors);
>  	if (lim->max_user_sectors) {
> -		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
> +		if (lim->max_user_sectors < BLK_MIN_SEGMENT_SIZE / SECTOR_SIZE)
>  			return -EINVAL;
>  		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
>  	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
> @@ -341,7 +341,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  	 */
>  	if (!lim->seg_boundary_mask)
>  		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> -	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
> +	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
>  		return -EINVAL;
>  
>  	/*
> @@ -362,7 +362,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  		 */
>  		if (!lim->max_segment_size)
>  			lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> -		if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> +		if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
>  			return -EINVAL;
>  	}
>  
> diff --git a/block/blk.h b/block/blk.h
> index 90fa5f28ccab..cbfa8a3d4e42 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -359,7 +359,7 @@ static inline bool bio_may_need_split(struct bio *bio,
>  		const struct queue_limits *lim)
>  {
>  	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
> -		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
> +		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > BLK_MIN_SEGMENT_SIZE;
>  }
>  
>  /**
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 248416ecd01c..32188af4051e 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1163,6 +1163,7 @@ static inline bool bdev_is_partition(struct block_device *bdev)
>  enum blk_default_limits {
>  	BLK_MAX_SEGMENTS	= 128,
>  	BLK_SAFE_MAX_SECTORS	= 255,
> +	BLK_MIN_SEGMENT_SIZE	= 4096, /* min(PAGE_SIZE) */

I think it would be useful to expose this value to the queue_limits and
sysfs (and remove it from here). We can default it to PAGE_SIZE (as it has
always been) and allow to overwrite it when the block driver initializes the
limits. This allows to see we are not anymore in the range of PAGE_SIZE -
max_segment_size 'world' but min_segment_size - max_segment_size one. Unless
there's a reason to not increase queue_limits data struct?


>  	BLK_MAX_SEGMENT_SIZE	= 65536,
>  	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
>  };
> -- 
> 2.47.1
> 
