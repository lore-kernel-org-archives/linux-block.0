Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF884D04
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967438; cv=none; b=b4a2bAeGeY/1hEZULR4oMrRNXmGA4HX+AvukmoWdttYFHPW3QMGRhf03qj4xOua4IhqpFvPG6lC5bTS4OuxFtJA7EKzqygN6EP2ZfxP8MbxoHhTcUUtT1wOneUw++mYBTY0DKkm0jMm6y+KoYt7xH6Eab2gX0NM+eJNqv7kSjfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967438; c=relaxed/simple;
	bh=DfXOWEEf2UYPMJlGbpwe+5iOZHYqcvgnPyjwZIDGUPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vk+UtN2EwaXmPbnSQ5kVCnIdmyH4z5johBb54ZOh5l5Gr81b+U0uToupnH+TnhNoE+Wpe3Y+3k8hE+b/LNOIlZM0zDK+zeD4ZUJOfSEbLVGIyjnoc9tNDXSgeGvnzyU51IaEZw4T3MQf9tcp4+7deG1TSqN7n5RRprhF0zsNU70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G73PSfe1; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G73PSfe1"
X-Envelope-To: dlemoal@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718967432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kq9N13LmzX0mKGBceY5cNlj7KHKe9+sTKblELZBApSY=;
	b=G73PSfe1SDwLGtvrG439OGDuf3lWn68iHECg18Xy+mOjdFlxMS7WsPUrzZ5ETpMMNBYS2G
	1UAyr45l6ypI0KH2Um0vQl9N9YsZODDa15D1L7mwnf34faozjLD3vzongyW2x/FMuoOFNv
	bt17/FvUNkVWrp2ogZSzuxvDu6wlv1I=
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: linux-block@vger.kernel.org
Message-ID: <a3c84f43-f301-414b-88a9-046d6a62390e@linux.dev>
Date: Fri, 21 Jun 2024 18:57:01 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] null_blk: Do not set disk->nr_zones
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20240621031506.759397-1-dlemoal@kernel.org>
 <20240621031506.759397-4-dlemoal@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240621031506.759397-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/21 13:14, Christoph Hellwig 写道:
> There is no need to conditionally define on CONFIG_BLK_DEV_ZONED the
> inline helper functions bdev_nr_zones(), bdev_max_open_zones(),
> bdev_max_active_zones() and disk_zone_no() as these function will return
> the correct valu in all cases (zoned device or not, including when

s/valu/value ?

Zhu Yanjun

> CONFIG_BLK_DEV_ZONED is not set). Furthermore, disk_nr_zones()
> definition can be simplified as disk->nr_zones is always 0 for regular
> block devices.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   include/linux/blkdev.h | 44 ++++++++++++------------------------------
>   1 file changed, 12 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1078a7d51295..e89003360c17 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -673,11 +673,21 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
>   }
>   
>   #ifdef CONFIG_BLK_DEV_ZONED
> -
>   static inline unsigned int disk_nr_zones(struct gendisk *disk)
>   {
> -	return blk_queue_is_zoned(disk->queue) ? disk->nr_zones : 0;
> +	return disk->nr_zones;
> +}
> +bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
> +#else /* CONFIG_BLK_DEV_ZONED */
> +static inline unsigned int disk_nr_zones(struct gendisk *disk)
> +{
> +	return 0;
> +}
> +static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
> +{
> +	return false;
>   }
> +#endif /* CONFIG_BLK_DEV_ZONED */
>   
>   static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
>   {
> @@ -701,36 +711,6 @@ static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
>   	return bdev->bd_disk->queue->limits.max_active_zones;
>   }
>   
> -bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
> -#else /* CONFIG_BLK_DEV_ZONED */
> -static inline unsigned int bdev_nr_zones(struct block_device *bdev)
> -{
> -	return 0;
> -}
> -
> -static inline unsigned int disk_nr_zones(struct gendisk *disk)
> -{
> -	return 0;
> -}
> -static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
> -{
> -	return 0;
> -}
> -static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
> -{
> -	return 0;
> -}
> -
> -static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
> -{
> -	return 0;
> -}
> -static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_BLK_DEV_ZONED */
> -
>   static inline unsigned int blk_queue_depth(struct request_queue *q)
>   {
>   	if (q->queue_depth)

