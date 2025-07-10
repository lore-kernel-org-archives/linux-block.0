Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF7236A73
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 04:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121565; cv=none; b=G9ZZtuxiGviSbp/w0PQFiSfBtkvj2RBlBcKBBv1KyMxLoocd5yb2pV+1i90TPVcHnSh/9Y0SbvFCpsLhcjFD3ybv89C/heYPvK2PKev+LiNLn+Ip3Mf1gOGJdU/IXluPiQ7YxkdbORhtsArwRNW7EaryDzU5SPajvuzo8nQwVJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121565; c=relaxed/simple;
	bh=y7Gi26cG4Qzu6eb4vj8uE93x7dJOut6UqAr3/vZh8d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0s0AN5jDYWCR9bTTwyZp3yZg3me7jfGBfwJGBKvoRXNyOGAHikx8bdGW16h2z4o1HuCqQmlPrP2gysnomIINqhsyKhO6Ry9CdGfQwTfprWHhwDkWbA/PaFEq2oGMDY/N0qycbRRCsNtoymWpnPsfeF5AQSPmIl4ukqWx8mDPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goU0lVNE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goU0lVNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD19C4CEE3;
	Thu, 10 Jul 2025 04:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752121565;
	bh=y7Gi26cG4Qzu6eb4vj8uE93x7dJOut6UqAr3/vZh8d4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=goU0lVNEPCmdd/M0eEIs8yLwoiBLhBrKkqU69J4G4F61CzTiZ9yDE8KAzNhK7yRCQ
	 PzOtSSe/gEbaxOZgFKzrmCWrARNoZN/J7YbBdJWSIlFzmmz3YOV6/+V3xAUYUB8zSn
	 fyhqJN2TH8sInu+lf+m9kzTt67t/EjOpQrZ7Ogz+NXyufXjpXyq/iIXxjNnKEL1pV7
	 OrSTkgLRECzAw+XBHtWnlP70JSXXyXTRKujS4LUPyfjlgNDYqz/w1nDbrWtr2opO1B
	 zbMqHZr+H7Yr8AL3lHUtOlk1Mfw+cZ6TcsHmO7TGPVgX+EsdbutnCllGWGAGMlyqY6
	 QBiB/MC3zoqAA==
Message-ID: <38766c2d-eadc-4998-b07a-81c95449e091@kernel.org>
Date: Thu, 10 Jul 2025 13:23:48 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] block: add trace messages to zone write plugging
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-6-johannes.thumshirn@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250709114704.70831-6-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 8:47 PM, Johannes Thumshirn wrote:
> Add tracepoints to zone write plugging plug and unplug events.
> 
>   kworker/u9:3-162  [000] d..1. 2231.939277: disk_zone_wplug_add_bio: 8,0 zone 12, BIO 6291456 + 14
>   kworker/0:1H-59   [000] d..1. 2231.939884: blk_zone_wplug_bio: 8,0 zone 24, BIO 12775168 + 4

This is showing "+ bio->__bi_nr_segments", which is odd...
Is this intentional ? Why not the "+ bio_sectors(bio)" ?

> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  block/blk-zoned.c            |  5 ++++
>  include/trace/events/block.h | 44 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 48f75f58d05e..b881aadbe35f 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -822,6 +822,8 @@ static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
>  	 * at the tail of the list to preserve the sequential write order.
>  	 */
>  	bio_list_add(&zwplug->bio_list, bio);
> +	trace_disk_zone_wplug_add_bio(zwplug->disk->queue, zwplug->zone_no,
> +				      bio->bi_iter.bi_sector, nr_segs);
>  
>  	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
>  
> @@ -1317,6 +1319,9 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
>  		goto put_zwplug;
>  	}
>  
> +	trace_blk_zone_wplug_bio(zwplug->disk->queue, zwplug->zone_no,
> +				 bio->bi_iter.bi_sector, bio->__bi_nr_segments);
> +
>  	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
>  		blk_zone_wplug_bio_io_error(zwplug, bio);
>  		goto again;
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 9a25b686fd09..16d5a87f3030 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -633,6 +633,50 @@ TRACE_EVENT(blkdev_zone_mgmt,
>  		  (unsigned long long)__entry->sector,
>  		  __entry->nr_sectors)
>  );
> +
> +DECLARE_EVENT_CLASS(block_zwplug,
> +
> +	TP_PROTO(struct request_queue *q, unsigned int zno, sector_t sector,
> +		 unsigned int nr_segs),
> +
> +	TP_ARGS(q, zno, sector, nr_segs),
> +
> +	TP_STRUCT__entry(
> +		__field( dev_t,		dev		)
> +		__field( unsigned int,	zno		)
> +		__field( sector_t,	sector		)
> +		__field( unsigned int,	nr_segs		)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= disk_devt(q->disk);
> +		__entry->zno		= zno;
> +		__entry->sector		= sector;
> +		__entry->nr_segs	= nr_segs;
> +	),
> +
> +	TP_printk("%d,%d zone %u, BIO %llu + %u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->zno,
> +		  (unsigned long long)__entry->sector,
> +		  __entry->nr_segs)
> +);
> +
> +DEFINE_EVENT(block_zwplug, disk_zone_wplug_add_bio,
> +
> +	TP_PROTO(struct request_queue *q, unsigned int zno, sector_t sector,
> +		 unsigned int nr_segs),
> +
> +	TP_ARGS(q, zno, sector, nr_segs)
> +);
> +
> +DEFINE_EVENT(block_zwplug, blk_zone_wplug_bio,
> +
> +	TP_PROTO(struct request_queue *q, unsigned int zno, sector_t sector,
> +		 unsigned int nr_segs),
> +
> +	TP_ARGS(q, zno, sector, nr_segs)
> +);
> +
>  #endif /* _TRACE_BLOCK_H */
>  
>  /* This part must be outside protection */


-- 
Damien Le Moal
Western Digital Research
