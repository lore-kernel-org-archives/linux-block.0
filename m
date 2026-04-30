Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D06C37C938
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554554; cv=none; b=sGHIPFi15TCPcbnX8aBYSlzanACRWvvH3rk/30rI+tW3MJsGTgEoZbkiM4vX1AqyeSeLtoA3ZoCRovYUs9ACVn1O/m5jPIIH9GEan1ZQjXI/GqolZ/UurDXv/cibtUeKscRK1R46NuT2/W1M/muTDIPCKYwzfv7cqK4in7c5YB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554554; c=relaxed/simple;
	bh=vZY5riYTlQk56+9zGOpf+b05tCgfcitu5ouwmhHdR0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSzL3Cgk9rXb0MMRgekwjtb15PCwCm8/lNtfDYhL+mg1JmyT1sYWImEw8kdg7RhXBOqvUprqjyvAN8SUfEMwh6HG4B7vPsIBRQn7ZoZj9jWEE890/HYTzmALd5tnHYWlU8lHhu8TSlQrhz2TUlmuSLCbujYh6EM0s5Q3OTivXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A32DC68AFE; Thu, 30 Apr 2026 15:09:01 +0200 (CEST)
Date: Thu, 30 Apr 2026 15:09:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-mq: recover from stale cached request in
 blk_mq_submit_bio
Message-ID: <20260430130901.GA23658@lst.de>
References: <20260424184551.1540062-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424184551.1540062-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 24, 2026 at 11:45:51AM -0700, Keith Busch wrote:
> -static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
> +static bool blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
>  		struct bio *bio)
>  {
> -	if (rq_list_pop(&plug->cached_rqs) != rq)
> -		WARN_ON_ONCE(1);
> -
>  	/*
> -	 * If any qos ->throttle() end up blocking, we will have flushed the
> -	 * plug and hence killed the cached_rq list as well. Pop this entry
> -	 * before we throttle.
> +	 * We will have flushed the plug and hence killed the cached_rq list as
> +	 * well if anything had blocked. Pop this entry before we throttle if
> +	 * the entry is still valid.
>  	 */
> +	if (rq_list_pop(&plug->cached_rqs) != rq)
> +		return false;
> +
>  	rq_qos_throttle(rq->q, bio);
>  
>  	blk_mq_rq_time_init(rq, blk_time_get_ns());
>  	rq->cmd_flags = bio->bi_opf;
>  	INIT_LIST_HEAD(&rq->queuelist);
> +	return true;
>  }
>  
>  static bool bio_unaligned(const struct bio *bio, struct request_queue *q)
> @@ -3211,8 +3212,13 @@ void blk_mq_submit_bio(struct bio *bio)
>  
>  new_request:
>  	if (rq) {
> -		blk_mq_use_cached_rq(rq, plug, bio);
> -	} else {
> +		if (!blk_mq_use_cached_rq(rq, plug, bio)) {
> +			rq = NULL;
> +			if (unlikely(bio_queue_enter(bio)))
> +				return;
> +		}

This means we now did the checks earlier in the function without
q_usage_counter protection, which looks wrong.  I think we have
to redo all of that here.
