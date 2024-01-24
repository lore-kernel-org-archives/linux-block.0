Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F633FBEC
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076543; cv=none; b=lt6KB08ZIs5c9lzi5dtuEA6TNljgNB55uR0gs0QdWixzhpMGqvJizw5NDD9OQiox/GV+WeA2+2X/fihPb+QBQzJ0EbEXpfbffQmLLN5yHY4fAD7uaJFWIGp9Nrh5jAfa6BEpjh7x71uaVkEM6ZOWloh+ap2aBLdRQeuZI2NQX8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076543; c=relaxed/simple;
	bh=KrcWZ9z/Em0Hjx2MCq2aIlvvImEntjeE6FtPypUi1Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCT+6O+046NNRk8Asbr+4kq2I5WV33m1rX1hQtxiClckPr1/eJbHvDX58o8u5hCtjVeZW7kerwE9AYosv4clcod9Jrq9qkB2Q2C6cqrcMUh0LARxsE6CJFjyXutgBC5EeB5er6HABuv5DDe/NS05ujTj7wupxSeGOavy1DSZnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hWBneXBr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qDbLlLPf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hWBneXBr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qDbLlLPf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hWBneXBr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qDbLlLPf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hWBneXBr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qDbLlLPf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A59101F7DA;
	Wed, 24 Jan 2024 06:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Maze6WjJphqg70LfBykxhaOml+iH7aM3EWuOG6TYaM=;
	b=hWBneXBrz6FU0OINGHUt+sFi4wrLuFsgf1gkBRt9eFDco8GCp6WIa4dn+W+9Q87lDp9Vnk
	ccQ+u7LTABhfZZvaanla7XuAjIa8WxiCncpf+dio0mNTCAFGXsbbXRNsYhFZZ6U8aesr4F
	Pcq5O9UJLNKWPL8uWzeN1alnajKnRLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Maze6WjJphqg70LfBykxhaOml+iH7aM3EWuOG6TYaM=;
	b=qDbLlLPfvC3PuCaSgkVtwBpWYZZwCEoEwMnodUD6hUeHnaqYZFVHC4CDLl4MRGSC7l1pnx
	pq+cZXGSn9HgrJAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706076539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Maze6WjJphqg70LfBykxhaOml+iH7aM3EWuOG6TYaM=;
	b=hWBneXBrz6FU0OINGHUt+sFi4wrLuFsgf1gkBRt9eFDco8GCp6WIa4dn+W+9Q87lDp9Vnk
	ccQ+u7LTABhfZZvaanla7XuAjIa8WxiCncpf+dio0mNTCAFGXsbbXRNsYhFZZ6U8aesr4F
	Pcq5O9UJLNKWPL8uWzeN1alnajKnRLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706076539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Maze6WjJphqg70LfBykxhaOml+iH7aM3EWuOG6TYaM=;
	b=qDbLlLPfvC3PuCaSgkVtwBpWYZZwCEoEwMnodUD6hUeHnaqYZFVHC4CDLl4MRGSC7l1pnx
	pq+cZXGSn9HgrJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 141DA1333E;
	Wed, 24 Jan 2024 06:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v82lAXupsGVVRwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 24 Jan 2024 06:08:59 +0000
Message-ID: <de3cd926-c78c-4e68-bee0-2f571ccdaf8d@suse.de>
Date: Wed, 24 Jan 2024 07:08:58 +0100
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
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240122173645.1686078-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.09

On 1/22/24 18:36, Christoph Hellwig wrote:
> Add a new queue_limits_{start,commit}_update pair of functions that
> allows taking an atomic snapshot of queue limits, update it, and
> commit it if it passes validity checking.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c       |   1 +
>   block/blk-settings.c   | 140 +++++++++++++++++++++++++++++++++++++++++
>   block/blk.h            |   1 +
>   include/linux/blkdev.h |  23 +++++++
>   4 files changed, 165 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 11342af420d0c4..09f4a44a4aa3cc 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -424,6 +424,7 @@ struct request_queue *blk_alloc_queue(int node_id)
>   	mutex_init(&q->debugfs_mutex);
>   	mutex_init(&q->sysfs_lock);
>   	mutex_init(&q->sysfs_dir_lock);
> +	mutex_init(&q->limits_lock);
>   	mutex_init(&q->rq_qos_mutex);
>   	spin_lock_init(&q->queue_lock);
>   
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index e872b0e168525e..b6692143ccf034 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -96,6 +96,146 @@ static void blk_apply_bdi_limits(struct backing_dev_info *bdi,
>   	bdi->io_pages = lim->max_sectors >> (PAGE_SHIFT - 9);
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
> +		if (WARN_ON_ONCE(!lim->chunk_sectors))
> +			return -EINVAL;
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
> +	if (lim->io_min < lim->physical_block_size)
> +		lim->io_min = lim->physical_block_size;
> +
> +	if (!lim->max_hw_sectors)
> +		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
> +	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SIZE / SECTOR_SIZE))
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
>   /**
>    * blk_queue_bounce_limit - set bounce buffer limit for queue
>    * @q: the request queue for the device
> diff --git a/block/blk.h b/block/blk.h
> index 1ef920f72e0f87..58b5dbac2a487d 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -447,6 +447,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
>   		unpin_user_page(page);
>   }
>   
> +int blk_validate_limits(struct queue_limits *lim);
>   struct request_queue *blk_alloc_queue(int node_id);
>   
>   int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 4a2e82c7971c86..5b5d3b238de1e7 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -473,6 +473,7 @@ struct request_queue {
>   
>   	struct mutex		sysfs_lock;
>   	struct mutex		sysfs_dir_lock;
> +	struct mutex		limits_lock;
>   
>   	/*
>   	 * for reusing dead hctx instance in case of updating
> @@ -861,6 +862,28 @@ static inline unsigned int blk_chunk_sectors_left(sector_t offset,
>   	return chunk_sectors - (offset & (chunk_sectors - 1));
>   }
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

I'm slightly confused about the lifetime of the returned structure.
By my understanding, the returned 'struct queue_limit' is allocated
on the stack of the caller, right?
Shouldn't we note this somewhere such that people don't start passing
the structure around, or, worse, calling 'kfree()' on it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich

