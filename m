Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4027459
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717561083; cv=none; b=BGSucZ3b8oEeaTFekd9vOCo27xKbB7TCQjmbgj/REqzEFPcn54VOQNfPazcUJ7naO5bg41DQ2iNw82jBV7KPOoRiNGe8fqiRHiYt1cStOWvyVfmADD6vunyhfbitDH7R+NRQCMr5xyQjm69YWIA5x0gW3sPGn8woMFJXiqGrk6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717561083; c=relaxed/simple;
	bh=q+1fjbkJc9IEsAkSs19v3AkaqJkUhHVwWXUTo/5lr2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJGdOS/I9CSeXQWKcpWPku+3J7Y+Uh917Lk70cT1n0ELx6dA9z9CtnDI6u/nMoLucdnUkKeBqS8/fzsF9lqYLTBTKph5jJ30N7RbEWnbHGZFnH8geEiqrziOHQI/bEHT2IOYEOUEz9Ps8+g5ek0P9Y23LtChrGanGaWUc+o+KIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9261D68D83; Wed,  5 Jun 2024 06:17:54 +0200 (CEST)
Date: Wed, 5 Jun 2024 06:17:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v2 1/2] block: Imporve checks on zone resource limits
Message-ID: <20240605041754.GA12183@lst.de>
References: <20240605022445.105747-1-dlemoal@kernel.org> <20240605022445.105747-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605022445.105747-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

improve is misspelled in the subject.

> @@ -80,6 +80,10 @@ static int blk_validate_zoned_limits(struct queue_limits *lim)
>  	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_BLK_DEV_ZONED)))
>  		return -EINVAL;
>  
> +	if (lim->max_active_zones &&
> +	    WARN_ON_ONCE(lim->max_open_zones > lim->max_active_zones))
> +		lim->max_open_zones = lim->max_active_zones;

Given how active zones are defined this is an error condition, and
should return -EINVAL.

> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 52abebf56027..2af4d5ca81d2 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1660,6 +1660,11 @@ static int disk_update_zone_resources(struct gendisk *disk,
>  	lim = queue_limits_start_update(q);
>  
>  	nr_seq_zones = disk->nr_zones - nr_conv_zones;
> +	if (WARN_ON_ONCE(lim.max_active_zones > nr_seq_zones))
> +		lim.max_active_zones = 0;
> +	if (WARN_ON_ONCE(lim.max_open_zones > nr_seq_zones))
> +		lim.max_open_zones = 0;

Why would you warn about this?  Offering an open/active limit larger
than the number of sequential zones is a pretty natural condition
for certain corner cases (e.g. create only a tiny namespace on a ZNS
SSD).  This could also use a code comment explaining why the limit
is adjusted.

