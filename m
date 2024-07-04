Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34641A01DE
	for <linux-block@vger.kernel.org>; Thu,  4 Jul 2024 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720074417; cv=none; b=Ql7ymqDih7iuiQt7HZx6OooECUQgCQIDTiK2hM2f2oMcKiTR4BGKgpI4EUBPcA6vhrMcnhdQ10r3RxpmF2mx7rJdEE/NGC3fyPcIpxuVg/5zJ3IRg7PwKiEHAtv5sl9P4+ygdjZO/zw493Qx7cLQ3V8j+e47aPIlRShfGw1wDhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720074417; c=relaxed/simple;
	bh=BH8YeBmYAJyjY+TkTQ0C6X/lYJ7oR/8og870ID3mQkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfRu+t5H8AfYHmCcipw7ybriGhkDYxh9r9wg+SsPokx+/26o0WU1ct9dMJ3C73kv+JcUnnsIjZU6WXOy1w1UHAIWjT4sjJSxyEQo4clm7TAef9Jp9pU7NF2Yn3gER8KOj0z6OnYUqEAr8jpECV2a43jURSp1z2m5f3WSJ+gOfNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8C69E68AFE; Thu,  4 Jul 2024 08:26:49 +0200 (CEST)
Date: Thu, 4 Jul 2024 08:26:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: t10-pi: Return correct ref tag when queue has
 no integrity profile
Message-ID: <20240704062649.GA21024@lst.de>
References: <CGME20240704062234epcas5p1dd4ae6e7c91555b9573418d618086c1e@epcas5p1.samsung.com> <20240704061515.282343-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704061515.282343-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 04, 2024 at 11:45:15AM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Commit <c6e56cf6b2e7> (block: move integrity information into
> queue_limits) changed the ref tag calculation logic. It would break if
> there is no integrity profile. This in turn causes read/write failures
> for such cases.

Can you explain the scenario a bit better?  I guess this is for when
the drivers use PRACT to insert/strip PI because BLK_DEV_INTEGRITY
is disabled?

> 
> Fixes: <c6e56cf6b2e7> (block: move integrity information into queue_limits)

This is not the standard formatting for fixes tags.

>  
>  static inline u32 t10_pi_ref_tag(struct request *rq)
>  {
> -	unsigned int shift = rq->q->limits.integrity.interval_exp;
> +	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
>  
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
> +	    rq->q->limits.integrity.interval_exp)
> +		shift = rq->q->limits.integrity.interval_exp;
>  	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT) & 0xffffffff;

But this only works when the interval_exp equals the block size.

So I think the proper fix that not only addresses the regression, but
also the long standing buf for larger interval_exp is to make sure
interval_exp is always initialized, including for
!CONFIG_BLK_DEV_INTEGRITY.

