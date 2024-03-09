Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9B16FF22
	for <linux-block@vger.kernel.org>; Sat,  9 Mar 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009189; cv=none; b=LrNUIyrkbNCiUix4DktKvMjh1YAOl8CCRmv4QjY23PiNGOWd0zbpQi+PKuS0CNVrUkZhNi4ybCrK23HYGs+w6p3dvU8aTno3w4A3NkzICBj/lkc2P3lLUdrN68UQ86Jn+SHbzIpcrMmSQ6T6u6CStdV6Cm1A2qyGgrhDLtPtxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009189; c=relaxed/simple;
	bh=1fU0pKG8/0LFLNcPep/nKVA9KiACBo4yfO2ECL0zsQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7FaJe7GfA7JUc385G4AAtTtDSaoBD50sMJk9D4yHotratUb+Y90YAjBnXabCehEL9ynNI5RRr4KLda7LT9axWvrTciaEwRxPEYL4eKLoN8ShDT4EGgEztxbsH6B1lL8+9CBVQr5M2oV874WekSrhQ1TpfVM37O6Vuwv8rm7WFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690bddc83cfso7452766d6.3
        for <linux-block@vger.kernel.org>; Sat, 09 Mar 2024 10:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710009186; x=1710613986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ekOfFtbKaJeQy59aa4hOBANuKC24c03ign7FqwJuFs=;
        b=L405uEA1r2Plt1ADIQGh6JmQTgQ3ZQcly1WaS2QpqnkWHZMrhhgFOzs9lqrviLsNAy
         8GUEcy9fdUpIVqSvODQxfoKjWVz41ygd8PUSo7n0bDucanY0qGuqrkn8eg2A+uaesUWI
         jmgykd1u1FTf1tG1fIweSw3IeTQc1d1SMdj5yKGLpQfmSR3YbWfJ+hQhxmuTdTm0cdZV
         5JKfb2OWJqGc+wjpHn6oDQxlhGVFPv8gVYTqmQwBnBYMbK+MY7gOmFPQVij2RVMU6wcs
         06NzaIjAuWLCb2JdA9lteoHLSyOSPevDZdq1PZVEjjex4GImTFyERc7fRFwB+R4Sz1vR
         L0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUU+sZM/f7Q+Yx+PaClRZHQqOCWozfpQMVyWY9sJIzc6b8meJplq5IHlkKBgqnjsc3iW0jn4f6trONSlydvIlCop/1NrxzDuciPpqc=
X-Gm-Message-State: AOJu0YxEUw8ZJXaT+ScgK38Qxs/4TPHmdwOzU6Jea0SSA/u0XRSR44kD
	8chGSFarsKBMBhqSX1ooX78SGfDTP6LVjqLNf56I8hrVa4ESImCna1X4s24t5H/S09GDnDOvLY0
	=
X-Google-Smtp-Source: AGHT+IGIDSHTMyTRxkLk6KxKccS5blwkrTouHauzSgk/zTy0xXE7hrVjqa547UsDNe+V3CdtxtBidw==
X-Received: by 2002:a0c:fac1:0:b0:690:964e:9d6e with SMTP id p1-20020a0cfac1000000b00690964e9d6emr2601486qvo.25.1710009185702;
        Sat, 09 Mar 2024 10:33:05 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id bp13-20020a05621407ed00b006903af52cbfsm1140440qvb.40.2024.03.09.10.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 10:33:05 -0800 (PST)
Date: Sat, 9 Mar 2024 13:33:04 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, agk@redhat.com, mpatocka@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: dm: set the correct discard_sectors limit
Message-ID: <ZeyrYB-XKa08P-2F@redhat.com>
References: <20240309164140.719752-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309164140.719752-1-hch@lst.de>

On Sat, Mar 09 2024 at 11:41P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Since commit 0034af036554 ("block: make
> /sys/block/<dev>/queue/discard_max_bytes writeable") there are two
> max_discard_sectors limits, one provided by the driver and one set by the
> user to optionally reduce the size below the hardware or driver limits.
> Usage of the extra hw limits has been a bit convoluted and both were
> set by the same driver API, leading to potential overrides of the user
> setting by the driver updating the limits.
> 
> With the new atomic queue limits API the driver should only set the hw
> limit, but I forgot to convert dm over to that as it was already using
> a scheme where the queue_limits are passed around.  Fix dm to update
> the max_hw_discard_sectors limits.
> 
> Note that this still leaves the non-hw update in place, which should
> be removed to not override the user settings.  As that is a behavior
> change I do not want to do it at the very end of the merge window.

That 2015 commit (0034af036554) was really ham-handed, not sure how
I've remained unaware of this duality (with soft and hard discard
limits) until now BUT there is quite a bit of DM code that only
concerns itself with max_discard_sectors and discard_granularity.

Anyway, I'm not quite sure what you're referring to, only code that is
still setting max_discard_sectors is drivers/md/dm.c:disable_discard

> This fixes a regression where dm bio poison v1 warns about exceeding
> the discard bio size when running xfstests generic/500.

Meaning max_discard_sectors > max_hw_discard_sectors? What changed to
expose this?

Also, typo in above commit message: s/dm bio poison/dm bio prison/


> Fixes: 8e0ef4128694 ("dm: use queue_limits_set")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-cache-target.c | 5 +++--
>  drivers/md/dm-clone-target.c | 3 ++-
>  drivers/md/dm-log-writes.c   | 2 +-
>  drivers/md/dm-snap.c         | 2 +-
>  drivers/md/dm-thin.c         | 5 +++--
>  drivers/md/dm.c              | 1 +
>  6 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
> index 911f73f7ebbaa0..71d7824c731862 100644
> --- a/drivers/md/dm-cache-target.c
> +++ b/drivers/md/dm-cache-target.c
> @@ -3394,8 +3394,9 @@ static void set_discard_limits(struct cache *cache, struct queue_limits *limits)
>  
>  	if (!cache->features.discard_passdown) {
>  		/* No passdown is done so setting own virtual limits */
> -		limits->max_discard_sectors = min_t(sector_t, cache->discard_block_size * 1024,
> -						    cache->origin_sectors);
> +		limits->max_hw_discard_sectors =
> +			min_t(sector_t, cache->discard_block_size * 1024,
> +					cache->origin_sectors);
>  		limits->discard_granularity = cache->discard_block_size << SECTOR_SHIFT;
>  		return;
>  	}
> diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
> index 94b2fc33f64be3..861a8ff524154f 100644
> --- a/drivers/md/dm-clone-target.c
> +++ b/drivers/md/dm-clone-target.c
> @@ -2050,7 +2050,8 @@ static void set_discard_limits(struct clone *clone, struct queue_limits *limits)
>  	if (!test_bit(DM_CLONE_DISCARD_PASSDOWN, &clone->flags)) {
>  		/* No passdown is done so we set our own virtual limits */
>  		limits->discard_granularity = clone->region_size << SECTOR_SHIFT;
> -		limits->max_discard_sectors = round_down(UINT_MAX >> SECTOR_SHIFT, clone->region_size);
> +		limits->max_hw_discard_sectors =
> +			round_down(UINT_MAX >> SECTOR_SHIFT, clone->region_size);
>  		return;
>  	}
>  
> diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
> index f17a6cf2284ecf..8d7df8303d0a18 100644
> --- a/drivers/md/dm-log-writes.c
> +++ b/drivers/md/dm-log-writes.c
> @@ -871,7 +871,7 @@ static void log_writes_io_hints(struct dm_target *ti, struct queue_limits *limit
>  	if (!bdev_max_discard_sectors(lc->dev->bdev)) {
>  		lc->device_supports_discard = false;
>  		limits->discard_granularity = lc->sectorsize;
> -		limits->max_discard_sectors = (UINT_MAX >> SECTOR_SHIFT);
> +		limits->max_hw_discard_sectors = (UINT_MAX >> SECTOR_SHIFT);
>  	}
>  	limits->logical_block_size = bdev_logical_block_size(lc->dev->bdev);
>  	limits->physical_block_size = bdev_physical_block_size(lc->dev->bdev);
> diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
> index bf7a574499a34d..07961e7e8382ab 100644
> --- a/drivers/md/dm-snap.c
> +++ b/drivers/md/dm-snap.c
> @@ -2408,7 +2408,7 @@ static void snapshot_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  
>  		/* All discards are split on chunk_size boundary */
>  		limits->discard_granularity = snap->store->chunk_size;
> -		limits->max_discard_sectors = snap->store->chunk_size;
> +		limits->max_hw_discard_sectors = snap->store->chunk_size;
>  
>  		up_read(&_origins_lock);
>  	}
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 07c7f9795b107b..d6adccda966f92 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
> @@ -4096,7 +4096,7 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  	if (pt->adjusted_pf.discard_enabled) {
>  		disable_discard_passdown_if_not_supported(pt);
>  		if (!pt->adjusted_pf.discard_passdown)
> -			limits->max_discard_sectors = 0;
> +			limits->max_hw_discard_sectors = 0;
>  		/*
>  		 * The pool uses the same discard limits as the underlying data
>  		 * device.  DM core has already set this up.
> @@ -4493,7 +4493,8 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  
>  	if (pool->pf.discard_enabled) {
>  		limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
> -		limits->max_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
> +		limits->max_hw_discard_sectors =
> +			pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
>  	}
>  }
>  
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index b5e6a10b9cfde3..de7703070905ff 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1077,6 +1077,7 @@ void disable_discard(struct mapped_device *md)
>  	struct queue_limits *limits = dm_get_queue_limits(md);
>  
>  	/* device doesn't really support DISCARD, disable it */
> +	limits->max_hw_discard_sectors = 0;
>  	limits->max_discard_sectors = 0;
>  }
>  
> -- 
> 2.39.2
> 
> 
