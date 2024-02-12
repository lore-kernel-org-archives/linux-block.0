Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF9C135
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707723109; cv=none; b=JI5qLo+a11gJeBmn+qCbr+4fQE8tDz8F/2ePCzlmL5oreQ8+1e6hH2RNQ+QxLfcedKzkY/bA1HtuGDSqZ3zpCZmCzcNHVqIGlWvZGV/PL9zeSeHPU4fFhrLzF4r/bp2xdiNX171Y1M3DcgEa8X6yJJF4TLCHAxPGoFMpdQpmGsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707723109; c=relaxed/simple;
	bh=nZr71kxqEP7X6+6XEYDzHqw+e4q0G5P33rlKx/YoK+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGYnENUhfBjSqqXm5fTZMkBpQvd7UTDa/vlYvYlPq1J7S4SaKRSxIVSZPavbwa73WjHYrw4iN7yvq2dhLgccbz0PPeIGJHPr2iLg6bLbNi99KOfvpe9Sww9Gh+Zl5bx+gw2BKXf4hCDcNk57G19gO+W06MkijjBZzsd3VIzGT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lem7RU4o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wW0lc8nc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lem7RU4o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wW0lc8nc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lem7RU4o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wW0lc8nc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lem7RU4o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wW0lc8nc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7EAE022049;
	Mon, 12 Feb 2024 07:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707723105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpXvt5A6jT2LoBnEui3+WkXVosntLZ9XqJL77DkPHwA=;
	b=lem7RU4o1ipgMXIc71Z466Y98ore2tk+5fW0y0kMHRrw1lAzdLJgETvHjkG4scVzvPe0U2
	9XnoqhI6lXeARHx+C0+QFoWOD0DwfcA6EbTuRRyzh3JMAcqAYJpq2cTUqbBGIwZOLlbbQx
	dpz1Pn9/a9WtsLOtrii4EGltkilZFXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707723105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpXvt5A6jT2LoBnEui3+WkXVosntLZ9XqJL77DkPHwA=;
	b=wW0lc8nc3vekOTVcTGX7k9hUhQVlzfF7rWSKgU5uGcMFxDDIamc8YLYKuiEj7sx3+GsfZW
	5nib8mT1JcqsHkCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707723105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpXvt5A6jT2LoBnEui3+WkXVosntLZ9XqJL77DkPHwA=;
	b=lem7RU4o1ipgMXIc71Z466Y98ore2tk+5fW0y0kMHRrw1lAzdLJgETvHjkG4scVzvPe0U2
	9XnoqhI6lXeARHx+C0+QFoWOD0DwfcA6EbTuRRyzh3JMAcqAYJpq2cTUqbBGIwZOLlbbQx
	dpz1Pn9/a9WtsLOtrii4EGltkilZFXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707723105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpXvt5A6jT2LoBnEui3+WkXVosntLZ9XqJL77DkPHwA=;
	b=wW0lc8nc3vekOTVcTGX7k9hUhQVlzfF7rWSKgU5uGcMFxDDIamc8YLYKuiEj7sx3+GsfZW
	5nib8mT1JcqsHkCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 057D313985;
	Mon, 12 Feb 2024 07:31:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wPJVN1/JyWWoZAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Feb 2024 07:31:43 +0000
Message-ID: <afcc0635-87b3-4dea-84fa-0920a4fab5a4@suse.de>
Date: Mon, 12 Feb 2024 08:31:43 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] block: add an API to atomically update queue limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240212064609.1327143-1-hch@lst.de>
 <20240212064609.1327143-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240212064609.1327143-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/12/24 14:45, Christoph Hellwig wrote:
> Add a new queue_limits_{start,commit}_update pair of functions that
> allows taking an atomic snapshot of queue limits, update it, and
> commit it if it passes validity checking.  Also use the low-level
> validation helper to implement blk_set_default_limits instead of
> duplicating the initialization.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c       |   1 +
>   block/blk-settings.c   | 228 ++++++++++++++++++++++++++++++++++-------
>   block/blk.h            |   4 +-
>   include/linux/blkdev.h |  23 +++++
>   4 files changed, 218 insertions(+), 38 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 2b11d8325fde68..cb56724a8dfb25 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -425,6 +425,7 @@ struct request_queue *blk_alloc_queue(int node_id)
>   	mutex_init(&q->debugfs_mutex);
>   	mutex_init(&q->sysfs_lock);
>   	mutex_init(&q->sysfs_dir_lock);
> +	mutex_init(&q->limits_lock);
>   	mutex_init(&q->rq_qos_mutex);
>   	spin_lock_init(&q->queue_lock);
>   
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 1cae2db41490d2..27b9b4a2a85395 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -25,42 +25,6 @@ void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
>   }
>   EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
>   
> -/**
> - * blk_set_default_limits - reset limits to default values
> - * @lim:  the queue_limits structure to reset
> - *
> - * Description:
> - *   Returns a queue_limit struct to its default state.
> - */
> -void blk_set_default_limits(struct queue_limits *lim)
> -{
> -	lim->max_segments = BLK_MAX_SEGMENTS;
> -	lim->max_discard_segments = 1;
> -	lim->max_integrity_segments = 0;
> -	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> -	lim->virt_boundary_mask = 0;
> -	lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> -	lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
> -	lim->max_user_sectors = lim->max_dev_sectors = 0;
> -	lim->chunk_sectors = 0;
> -	lim->max_write_zeroes_sectors = 0;
> -	lim->max_zone_append_sectors = 0;
> -	lim->max_discard_sectors = 0;
> -	lim->max_hw_discard_sectors = 0;
> -	lim->max_secure_erase_sectors = 0;
> -	lim->discard_granularity = 512;
> -	lim->discard_alignment = 0;
> -	lim->discard_misaligned = 0;
> -	lim->logical_block_size = lim->physical_block_size = lim->io_min = 512;
> -	lim->bounce = BLK_BOUNCE_NONE;
> -	lim->alignment_offset = 0;
> -	lim->io_opt = 0;
> -	lim->misaligned = 0;
> -	lim->zoned = false;
> -	lim->zone_write_granularity = 0;
> -	lim->dma_alignment = 511;
> -}
> -
>   /**
>    * blk_set_stacking_limits - set default limits for stacking devices
>    * @lim:  the queue_limits structure to reset
> @@ -99,6 +63,198 @@ static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
>   	bdi->io_pages = lim->max_sectors >> PAGE_SECTORS_SHIFT;
>   }
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
> +
> +	if (lim->max_zone_append_sectors) {
> +		/*
> +		 * The Zone Append size is limited by the maximum I/O size
> +		 * and the zone size given that it can't span zones.
> +		 */
> +		lim->max_zone_append_sectors =
> +			min3(lim->max_hw_sectors,
> +			     lim->max_zone_append_sectors,
> +			     lim->chunk_sectors);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Check that the limits in lim are valid, initialize defaults for unset
> + * values, and cap values based on others where needed.
> + */
> +static int blk_validate_limits(struct queue_limits *lim)
> +{
> +	unsigned int max_hw_sectors;
> +
> +	/*
> +	 * Unless otherwise specified, default to 512 byte logical blocks and a
> +	 * physical block size equal to the logical block size.
> +	 */
> +	if (!lim->logical_block_size)
> +		lim->logical_block_size = SECTOR_SIZE;
> +	if (lim->physical_block_size < lim->logical_block_size)
> +		lim->physical_block_size = lim->logical_block_size;
> +
> +	/*
> +	 * The minimum I/O size defaults to the physical block size unless
> +	 * explicitly overridden.
> +	 */
> +	if (lim->io_min < lim->physical_block_size)
> +		lim->io_min = lim->physical_block_size;
> +
> +	/*
> +	 * max_hw_sectors has a somewhat weird default for historical reason,
> +	 * but driver really should set their own instead of relying on this
> +	 * value.
> +	 *
> +	 * The block layer relies on the fact that every driver can
> +	 * handle at lest a page worth of data per I/O, and needs the value
> +	 * aligned to the logical block size.
> +	 */
> +	if (!lim->max_hw_sectors)
> +		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
> +	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SECTORS))
> +		return -EINVAL;
> +	lim->max_hw_sectors = round_down(lim->max_hw_sectors,
> +			lim->logical_block_size >> SECTOR_SHIFT);
> +
> +	/*
> +	 * The actual max_sectors value is a complex beast and also takes the
> +	 * max_dev_sectors value (set by SCSI ULPs) and a user configurable
> +	 * value into account.  The ->max_sectors value is always calculated
> +	 * from these, so directly setting it won't have any effect.
> +	 */
> +	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
> +				lim->max_dev_sectors);
> +	if (lim->max_user_sectors) {
> +		if (lim->max_user_sectors > max_hw_sectors ||
> +		    lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
> +			return -EINVAL;
> +		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
> +	} else {
> +		lim->max_sectors = min(max_hw_sectors, BLK_DEF_MAX_SECTORS_CAP);
> +	}
> +	lim->max_sectors = round_down(lim->max_sectors,
> +			lim->logical_block_size >> SECTOR_SHIFT);
> +
> +	/*
> +	 * Random default for the maximum number of sectors.  Driver should not
> +	 * rely on this and set their own.
> +	 */
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
> +	/*
> +	 * By default there is no limit on the segment boundary alignment,
> +	 * but if there is one it can't be smaller than the page size as
> +	 * that would break all the normal I/O patterns.
> +	 */
> +	if (!lim->seg_boundary_mask)
> +		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> +	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	/*
> +	 * The maximum segment size has an odd historic 64k default that
> +	 * drivers probably should override.  Just like the I/O size we
> +	 * require drivers to at least handle a full page per segment.
> +	 */
> +	if (!lim->max_segment_size)
> +		lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> +	if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
> +		return -EINVAL;
> +
> +	/*
> +	 * Devices that require a virtual boundary do not support scatter/gather
> +	 * I/O natively, but instead require a descriptor list entry for each
> +	 * page (which might not be identical to the Linux PAGE_SIZE).  Because
> +	 * of that they are not limited by our notion of "segment size".
> +	 */
> +	if (lim->virt_boundary_mask) {
> +		if (WARN_ON_ONCE(lim->max_segment_size &&
> +				 lim->max_segment_size != UINT_MAX))
> +			return -EINVAL;
> +		lim->max_segment_size = UINT_MAX;
> +	}
> +
> +	/*
> +	 * We require drivers to at least do logical block aligned I/O, but
> +	 * historically could not check for that due to the separate calls
> +	 * to set the limits.  Once the transition is finished the check
> +	 * below should be narrowed down to check the logical block size.
> +	 */
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
> +/*
> + * Set the default limits for a newly allocated queue.  @lim contains the
> + * initial limits set by the driver, which could be no limit in which case
> + * all fields are cleared to zero.
> + */
> +int blk_set_default_limits(struct queue_limits *lim)
> +{
> +	return blk_validate_limits(lim);
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
>   /**
>    * blk_queue_bounce_limit - set bounce buffer limit for queue
>    * @q: the request queue for the device
> diff --git a/block/blk.h b/block/blk.h
> index 913c93838a01bf..7c30e2ac8ebcd3 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -330,7 +330,7 @@ void blk_rq_set_mixed_merge(struct request *rq);
>   bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
>   enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
>   
> -void blk_set_default_limits(struct queue_limits *lim);
> +int blk_set_default_limits(struct queue_limits *lim);
>   int blk_dev_init(void);
>   
>   /*
> @@ -448,7 +448,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
>   		unpin_user_page(page);
>   }
>   
> -struct request_queue *blk_alloc_queue(int node_id);
> +struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
>   
What is that doing here?
If you change the calling convention, shouldn't you modify the callers, too?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich

