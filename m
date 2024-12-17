Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A35157A46
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734479237; cv=none; b=qI+k863tfE/Ua6wkINpLYDzzSRJtrdHRfa46jmSFi93B0gxbchGWWkPgTCrrRm9165u0aOMQZpgEsai9Rn9YE+eJN557mLR71e2TAUwO8gGRSc/FkMdEzByB6x1LS3TtdNdWuSvc+TP5yjNmKQRIx/4vZEI3abV5DEf401mLGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734479237; c=relaxed/simple;
	bh=Hzpr3VEKq2Pc8XySCShbMi4a52RhqdAmm28SGfcxz5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQOX1+sUa1//3g/4nySKy8CvaEzpSEEkRWPH8wMuHAqVuA1scfG+fu/pR4D0p/FBMRfdfDHClVAWM/pPXjQYw2I3ORO6qxvhfnS6JFvk2cO8h4yxGVRbbQ8iJ2CLRk9kn/fzPBulpP0k3bObPyIGjZcEcwXxsevL+lM+6/JG8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQdy5SoG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQdy5SoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6199C4CED3;
	Tue, 17 Dec 2024 23:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734479234;
	bh=Hzpr3VEKq2Pc8XySCShbMi4a52RhqdAmm28SGfcxz5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gQdy5SoGEa2QRmIlgYmvqkpvCad1k3T48AzSv/RiUh4rSG3zZ1tpgj4Q49/CQYbJE
	 zox/dCpHvHGFFWVsNP0OtoK7Hw3xwUcMLEJYdHc28pIG6c2ERR6RBo1hLHfBsSv47r
	 ktMuq1dgbs3s+Rl6sXBDEJiMITci4CE1npaaCNGmH+IrbJTyoBMnpP6GfOy9bkUV6M
	 fadVau5VHgKu27FenmpNeuUoRpVCooG0c3CQOYDex4InJ8WVlLFwggE0JUtg7KHFQj
	 f/8nH7KRy/alYPU6cLDQH6xheyvhnyozVSSdgKzzhFh1hZf4WSI6qZ/VqYHJeLh/gU
	 Ymuvnkhc1zUhQ==
Message-ID: <49e2abf5-5c3f-4f0d-bf06-d382a79da393@kernel.org>
Date: Tue, 17 Dec 2024 15:47:14 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] blk-zoned: Move more error handling into
 blk_mq_submit_bio()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20241217223809.683035-1-bvanassche@acm.org>
 <20241217223809.683035-4-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241217223809.683035-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 14:38, Bart Van Assche wrote:
> The error handling code in blk_zone_plug_bio() and in the functions
> called by blk_zone_plug_bio() cannot be understood without knowing
> that these functions are only called by blk_mq_submit_bio(). Move
> the error handling code in blk_mq_submit_bio() such that all error
> handling code for blk_mq_submit_bio() occurs inside blk_mq_submit_bio()
> itself.

I am not a big fan of this. Furthermore, blk_zone_plug_bio() is also called from
drivers/md/dm.c, which would need to have the same amount of additional code.
Not nice.

> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c         | 16 ++++++++--
>  block/blk-zoned.c      | 67 +++++++++++++++++++-----------------------
>  include/linux/blkdev.h | 13 ++++++--
>  3 files changed, 56 insertions(+), 40 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f4300e608ed8..2449f412dd00 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3095,8 +3095,20 @@ void blk_mq_submit_bio(struct bio *bio)
>  	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
>  		goto queue_exit;
>  
> -	if (blk_queue_is_zoned(q) && blk_zone_plug_bio(bio, nr_segs))
> -		goto queue_exit;
> +	if (blk_queue_is_zoned(q)) {
> +		switch (blk_zone_plug_bio(bio, nr_segs)) {
> +		case bzp_not_plugged:
> +			break;
> +		case bzp_plugged:
> +			goto queue_exit;
> +		case bzp_wouldblock:
> +			bio_wouldblock_error(bio);
> +			goto queue_exit;
> +		case bzp_failed:
> +			bio_io_error(bio);
> +			goto queue_exit;
> +		}
> +	}
>  
>  new_request:
>  	if (rq) {
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 4b0be40a8ea7..cb2c05d8b1eb 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -675,8 +675,8 @@ static int disk_zone_sync_wp_offset(struct gendisk *disk, sector_t sector)
>  					disk_report_zones_cb, &args);
>  }
>  
> -static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
> -						  unsigned int wp_offset)
> +static enum blk_zone_plug_status
> +blk_zone_wplug_handle_reset_or_finish(struct bio *bio, unsigned int wp_offset)
>  {
>  	struct gendisk *disk = bio->bi_bdev->bd_disk;
>  	sector_t sector = bio->bi_iter.bi_sector;
> @@ -684,10 +684,8 @@ static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
>  	unsigned long flags;
>  
>  	/* Conventional zones cannot be reset nor finished. */
> -	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
> -		bio_io_error(bio);
> -		return true;
> -	}
> +	if (!bdev_zone_is_seq(bio->bi_bdev, sector))
> +		return bzp_failed;
>  
>  	/*
>  	 * No-wait reset or finish BIOs do not make much sense as the callers
> @@ -713,10 +711,11 @@ static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
>  		disk_put_zone_wplug(zwplug);
>  	}
>  
> -	return false;
> +	return bzp_not_plugged;
>  }
>  
> -static bool blk_zone_wplug_handle_reset_all(struct bio *bio)
> +static enum blk_zone_plug_status
> +blk_zone_wplug_handle_reset_all(struct bio *bio)
>  {
>  	struct gendisk *disk = bio->bi_bdev->bd_disk;
>  	struct blk_zone_wplug *zwplug;
> @@ -739,7 +738,7 @@ static bool blk_zone_wplug_handle_reset_all(struct bio *bio)
>  		}
>  	}
>  
> -	return false;
> +	return bzp_not_plugged;
>  }
>  
>  static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
> @@ -964,7 +963,8 @@ static bool blk_zone_wplug_prepare_bio(struct blk_zone_wplug *zwplug,
>  	return true;
>  }
>  
> -static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
> +static enum blk_zone_plug_status
> +blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>  {
>  	struct gendisk *disk = bio->bi_bdev->bd_disk;
>  	sector_t sector = bio->bi_iter.bi_sector;
> @@ -980,19 +980,15 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>  	 * BIO-based devices, it is the responsibility of the driver to split
>  	 * the bio before submitting it.
>  	 */
> -	if (WARN_ON_ONCE(bio_straddles_zones(bio))) {
> -		bio_io_error(bio);
> -		return true;
> -	}
> +	if (WARN_ON_ONCE(bio_straddles_zones(bio)))
> +		return bzp_failed;
>  
>  	/* Conventional zones do not need write plugging. */
>  	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
>  		/* Zone append to conventional zones is not allowed. */
> -		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> -			bio_io_error(bio);
> -			return true;
> -		}
> -		return false;
> +		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
> +			return bzp_failed;
> +		return bzp_not_plugged;
>  	}
>  
>  	if (bio->bi_opf & REQ_NOWAIT)
> @@ -1001,10 +997,9 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>  	zwplug = disk_get_and_lock_zone_wplug(disk, sector, gfp_mask, &flags);
>  	if (!zwplug) {
>  		if (bio->bi_opf & REQ_NOWAIT)
> -			bio_wouldblock_error(bio);
> +			return bzp_wouldblock;
>  		else
> -			bio_io_error(bio);
> -		return true;
> +			return bzp_failed;
>  	}
>  
>  	/* Indicate that this BIO is being handled using zone write plugging. */
> @@ -1022,22 +1017,21 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>  
>  	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
>  		spin_unlock_irqrestore(&zwplug->lock, flags);
> -		bio_io_error(bio);
> -		return true;
> +		return bzp_failed;
>  	}
>  
>  	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
>  
>  	spin_unlock_irqrestore(&zwplug->lock, flags);
>  
> -	return false;
> +	return bzp_not_plugged;
>  
>  plug:
>  	disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
>  
>  	spin_unlock_irqrestore(&zwplug->lock, flags);
>  
> -	return true;
> +	return bzp_plugged;
>  }
>  
>  /**
> @@ -1048,16 +1042,17 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>   * Handle write, write zeroes and zone append operations requiring emulation
>   * using zone write plugging.
>   *
> - * Return true whenever @bio execution needs to be delayed through the zone
> - * write plug. Otherwise, return false to let the submission path process
> - * @bio normally.
> + * Return %bzp_plugged if the @bio has been scheduled for delayed execution by
> + * adding it to zwplug->bio_list; %bzp_failed if the caller should fail @bio or
> + * %bzp_not_plugged to let the submission path process @bio normally.
>   */
> -bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
> +enum blk_zone_plug_status blk_zone_plug_bio(struct bio *bio,
> +					    unsigned int nr_segs)
>  {
>  	struct block_device *bdev = bio->bi_bdev;
>  
>  	if (!bdev->bd_disk->zone_wplugs_hash)
> -		return false;
> +		return bzp_not_plugged;
>  
>  	/*
>  	 * If the BIO already has the plugging flag set, then it was already
> @@ -1065,7 +1060,7 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
>  	 * plug bio submit work.
>  	 */
>  	if (bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING))
> -		return false;
> +		return bzp_not_plugged;
>  
>  	/*
>  	 * We do not need to do anything special for empty flush BIOs, e.g
> @@ -1075,7 +1070,7 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
>  	 * the written data.
>  	 */
>  	if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
> -		return false;
> +		return bzp_not_plugged;
>  
>  	/*
>  	 * Regular writes and write zeroes need to be handled through the target
> @@ -1097,7 +1092,7 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
>  	switch (bio_op(bio)) {
>  	case REQ_OP_ZONE_APPEND:
>  		if (!bdev_emulates_zone_append(bdev))
> -			return false;
> +			return bzp_not_plugged;
>  		fallthrough;
>  	case REQ_OP_WRITE:
>  	case REQ_OP_WRITE_ZEROES:
> @@ -1110,10 +1105,10 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
>  	case REQ_OP_ZONE_RESET_ALL:
>  		return blk_zone_wplug_handle_reset_all(bio);
>  	default:
> -		return false;
> +		return bzp_not_plugged;
>  	}
>  
> -	return false;
> +	return bzp_not_plugged;
>  }
>  EXPORT_SYMBOL_GPL(blk_zone_plug_bio);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 39e5ffbf6d31..22f3ca58522d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -690,18 +690,27 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
>  		(q->limits.features & BLK_FEAT_ZONED);
>  }
>  
> +enum blk_zone_plug_status {
> +	bzp_not_plugged,
> +	bzp_plugged,
> +	bzp_wouldblock,
> +	bzp_failed,
> +};
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline unsigned int disk_nr_zones(struct gendisk *disk)
>  {
>  	return disk->nr_zones;
>  }
> -bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
> +enum blk_zone_plug_status blk_zone_plug_bio(struct bio *bio,
> +					    unsigned int nr_segs);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline unsigned int disk_nr_zones(struct gendisk *disk)
>  {
>  	return 0;
>  }
> -static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
> +static inline enum blk_zone_plug_status blk_zone_plug_bio(struct bio *bio,
> +							  unsigned int nr_segs)
>  {
>  	return false;
>  }


-- 
Damien Le Moal
Western Digital Research
