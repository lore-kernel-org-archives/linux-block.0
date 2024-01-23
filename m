Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8AA1FA5;
	Tue, 23 Jan 2024 04:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705985435; cv=none; b=RNDGuLmOrBIRGoAN6rl2UDg786FtoWcSwGIdqBM002aStVqfNo1BfqjbW4caxBuiRvDCtGCkztrPylT0og1mCBzByvFV3UzDFOPOPtNTgBECtUmrxzJj+ac74uIxSlaGXcJ+qDSPLvGnnkEVvh1yy5OnTt6IZA830K/0Mzvk9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705985435; c=relaxed/simple;
	bh=Rl6LeplYwooldBMtzv7oz1ncnzpGGxmkwrEw7i1Ll48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxHHJskyAdInemSXGJ7UUn3F4iuec14w+N8+1XoKtAnntlrD+nVbsXb9IK9p5vssc39rsmPfnoVNhDHiR3g5rsCKQB+mcrySX8ovg4g19IktWlAks5awloyvhShbbSEYLxIQ9MRUtbsKtgmth6C3tEkDw1VPquTDghBw0SVRGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv2oLhqT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv2oLhqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A50FC433F1;
	Tue, 23 Jan 2024 04:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705985435;
	bh=Rl6LeplYwooldBMtzv7oz1ncnzpGGxmkwrEw7i1Ll48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jv2oLhqTB78sqaWu4sCVtFP/uBV+rNqQxEI60qfYDXVlN2PNKEcbTwRnp4R4fj3WN
	 ULN8UTpCQrxNY0ymHbqcMMHj2qIiABcFlPBZKq+mJM5m+7R3L3N+ctm1y/7z3+qrRI
	 5b8yr093ZDPT12GrLlVP/XSpiu+h8Va5UFcuBBM8I6ccJnsqolOvu6JKKnMN7It/Xe
	 PdJ1Q5hha4QZ8lZtGgEJmKvvmdtrVBgjtdvw/l5pJ56/WW7ritCoLktzhEQHejOirR
	 +GZVRf/QaGOBBKxUCr6GlpRzu5cgpMcZY9pLL72INj2cA29AMZYE1KkCudYrv9wF2l
	 W/Er/VEXx1utg==
Message-ID: <01765807-d010-422b-97a6-3171265f36be@kernel.org>
Date: Tue, 23 Jan 2024 13:50:32 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] block: add an API to atomically update queue limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Add a new queue_limits_{start,commit}_update pair of functions that
> allows taking an atomic snapshot of queue limits, update it, and
> commit it if it passes validity checking.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c       |   1 +
>  block/blk-settings.c   | 140 +++++++++++++++++++++++++++++++++++++++++
>  block/blk.h            |   1 +
>  include/linux/blkdev.h |  23 +++++++
>  4 files changed, 165 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 11342af420d0c4..09f4a44a4aa3cc 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -424,6 +424,7 @@ struct request_queue *blk_alloc_queue(int node_id)
>  	mutex_init(&q->debugfs_mutex);
>  	mutex_init(&q->sysfs_lock);
>  	mutex_init(&q->sysfs_dir_lock);
> +	mutex_init(&q->limits_lock);
>  	mutex_init(&q->rq_qos_mutex);
>  	spin_lock_init(&q->queue_lock);
>  
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index e872b0e168525e..b6692143ccf034 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -96,6 +96,146 @@ static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
>  	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
>  }
>  
> +static int blk_validate_zoned_limits(struct queue_limits *lim)
> +{
> +	if (!lim->zoned) {
> +		if (WARN_ON_ONCE(lim->max_open_zones) ||
> +		    WARN_ON_ONCE(lim->max_active_zones) ||
> +		    WARN_ON_ONCE(lim->zone_write_granularity) ||
> +		    WARN_ON_ONCE(lim->max_zone_append_sectors))
> +			return -EINVAL;
> +		return 0;
> +	}
> +
> +	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_BLK_DEV_ZONED)))
> +		return -EINVAL;
> +
> +	if (lim->zone_write_granularity < lim->logical_block_size)
> +		lim->zone_write_granularity = lim->logical_block_size;

This check and change needs to be against the physical block size. Otherwise,
SMR drives will choke on it.

> +
> +	if (lim->max_zone_append_sectors) {
> +		if (WARN_ON_ONCE(!lim->chunk_sectors))
> +			return -EINVAL;

chunk_sectors is the zone size. So we should probably check that it is set after
the IS_ENABLED() check earlier in the function, no ?

> +		lim->max_zone_append_sectors =
> +			min3(lim->max_hw_sectors,
> +			     lim->max_zone_append_sectors,
> +			     lim->chunk_sectors);
> +	}
> +
> +	return 0;
> +}
> +
> +int blk_validate_limits(struct queue_limits *lim)
> +{
> +	unsigned int max_hw_sectors;
> +
> +	if (!lim->logical_block_size)
> +		lim->logical_block_size = SECTOR_SIZE;
> +
> +	if (!lim->physical_block_size)
> +		lim->physical_block_size = SECTOR_SIZE;
> +	if (lim->physical_block_size < lim->logical_block_size)
> +		lim->physical_block_size = lim->physical_block_size;
> +
> +	if (!lim->io_min)
> +		lim->io_min = SECTOR_SIZE;

This should be lim->logical_block_size, no ?

> +	if (lim->io_min < lim->physical_block_size)
> +		lim->io_min = lim->physical_block_size;

But then given that log <= phys, you could set io_min to physical_block_size if
it is not set.

> +
> +	if (!lim->max_hw_sectors)
> +		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
> +	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SIZE / SECTOR_SIZE))

You can use PAGE_SECTORS here.

> +		return -EINVAL;
> +
> +	lim->max_hw_sectors = round_down(lim->max_hw_sectors,
> +			lim->logical_block_size >> SECTOR_SHIFT);
> +
> +	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
> +				lim->max_dev_sectors);
> +	if (lim->max_user_sectors) {
> +		if (lim->max_user_sectors > max_hw_sectors ||
> +		    lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)

same here.

> +			return -EINVAL;
> +		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
> +	} else {
> +		lim->max_sectors = min(max_hw_sectors, BLK_DEF_MAX_SECTORS_CAP);
> +	}
> +
> +	lim->max_sectors = round_down(lim->max_sectors,
> +			lim->logical_block_size >> SECTOR_SHIFT);
> +
> +	if (!lim->max_segments)
> +		lim->max_segments = BLK_MAX_SEGMENTS;
> +
> +	lim->max_discard_sectors = lim->max_hw_discard_sectors;
> +	if (!lim->max_discard_segments)
> +		lim->max_discard_segments = 1;
> +
> +	if (lim->discard_granularity < lim->physical_block_size)
> +		lim->discard_granularity = lim->physical_block_size;
> +
> +	if (!lim->seg_boundary_mask)
> +		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> +	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	if (!lim->max_segment_size)
> +		lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> +	if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> +		return -EINVAL;
> +
> +	/*
> +	 * Devices that require a virtual boundary do not support scatter/gather
> +	 * I/O natively, but instead require a descriptor list entry for each
> +	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
> +	 * of that they are not limited by our notion of "segment size".
> +	 */
> +	if (lim->virt_boundary_mask) {
> +		if (WARN_ON_ONCE(lim->max_segment_size &&
> +				 lim->max_segment_size != UINT_MAX))
> +			return -EINVAL;
> +		lim->max_segment_size = UINT_MAX;
> +	}
> +
> +	if (!lim->dma_alignment)
> +		lim->dma_alignment = SECTOR_SIZE - 1;
> +	if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
> +		return -EINVAL;
> +
> +	if (lim->alignment_offset) {
> +		lim->alignment_offset &= (lim->physical_block_size - 1);
> +		lim->misaligned = 0;
> +	}
> +
> +	return blk_validate_zoned_limits(lim);
> +}
> +
> +/**
> + * queue_limits_commit_update - commit an atomic update of queue limits
> + * @q:		queue to update
> + * @lim:	limits to apply
> + *
> + * Apply the limits in @lim that were obtained from queue_limits_start_update()
> + * and updated by the caller to @q.
> + *
> + * Returns 0 if successful, else a negative error code.
> + */
> +int queue_limits_commit_update(struct request_queue *q,
> +		struct queue_limits *lim)
> +	__releases(q->limits_lock)
> +{
> +	int error = blk_validate_limits(lim);
> +
> +	if (!error) {
> +		q->limits = *lim;
> +		if (q->disk)
> +			blk_apply_bdi_limits(q->disk->bdi, lim);
> +	}
> +	mutex_unlock(&q->limits_lock);
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(queue_limits_commit_update);
> +
>  /**
>   * blk_queue_bounce_limit - set bounce buffer limit for queue
>   * @q: the request queue for the device
> diff --git a/block/blk.h b/block/blk.h
> index 1ef920f72e0f87..58b5dbac2a487d 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -447,6 +447,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
>  		unpin_user_page(page);
>  }
>  
> +int blk_validate_limits(struct queue_limits *lim);
>  struct request_queue *blk_alloc_queue(int node_id);
>  
>  int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 4a2e82c7971c86..5b5d3b238de1e7 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -473,6 +473,7 @@ struct request_queue {
>  
>  	struct mutex		sysfs_lock;
>  	struct mutex		sysfs_dir_lock;
> +	struct mutex		limits_lock;
>  
>  	/*
>  	 * for reusing dead hctx instance in case of updating
> @@ -861,6 +862,28 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
>  	return chunk_sectors - (offset & (chunk_sectors - 1));
>  }
>  
> +/**
> + * queue_limits_start_update - start an atomic update of queue limits
> + * @q:		queue to update
> + *
> + * This functions starts an atomic update of the queue limits.  It takes a lock
> + * to prevent other updates and returns a snapshot of the current limits that
> + * the caller can modify.  The caller must call queue_limits_commit_update()
> + * to finish the update.
> + *
> + * Context: process context.  The caller must have frozen the queue or ensured
> + * that there is outstanding I/O by other means.
> + */
> +static inline struct queue_limits
> +queue_limits_start_update(struct request_queue *q)
> +	__acquires(q->limits_lock)
> +{
> +	mutex_lock(&q->limits_lock);
> +	return q->limits;
> +}
> +int queue_limits_commit_update(struct request_queue *q,
> +		struct queue_limits *lim);
> +
>  /*
>   * Access functions for manipulating queue properties
>   */

-- 
Damien Le Moal
Western Digital Research

