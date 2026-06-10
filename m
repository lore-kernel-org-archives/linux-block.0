Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197CE36A341
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069130; cv=none; b=RO6axHnemh3UuWfKAirckJ2945AXC0wdVqlvwJRHXQxQhV5lZd3b38sdZTVc8lQEm5JaGaGlBT9X0Do/0UYnP47jaNVoFlWZyPSAkL4aPtoluahT6q9DkEUz2wpZgVNeoSe+ItPsvbHo23LGLhXG/t2jCNyCU3VaBDN1lqFyyFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069130; c=relaxed/simple;
	bh=PUf6i4/Gi085iB446MooEKYKH9HalRRuA+3HKq7/J2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7/dKH013bGhSAXJxdiiFJr43VeaWTktcB4H5L9iiP3dCRkcT4th/mW8rLWNzmckibKqRgFi80VPVgva/R643kX4NyeA5wDcm+bb7rj9+fZGWHd0znFndFxRVfI4vMqkvsj0ktEe40UreLYCchKesFDsCNVT8zZKTDSpAPtLRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cTXn+A53; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cTXn+A53"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zzKX7DVXvmZioR4C7KaRdk3e3EE4o1gVYRfNWbbkIiE=; b=cTXn+A53O4RUzAc2SaiCTSbftj
	Tbh6eiE21Mod9rHr+VFcw2Mc4Fafba9pFUYKxfIeSglU6Hwlznh02fOXqvBvlwRpnMjuCe53npECo
	HIJUU2TwR4Ermkr8/UiDaunIbAG0d3r74bx+oebLc1H9NPf7XMpb/STUAysL1peW8S5o6vdRPdmUW
	W7GJ2aeBfyirHRvcgn4I9+eYFG8lCBkQSE8wLw2nPCnDtvrk8HLBuUigMa3yw4FI06NAjFc2AX22O
	p61e/iBIU/K6L6Onp5DRdpYK0ahw7Wwj2xgfl2UZtD7CsH1Y2iv/tQs/37HgoMF9nTyaQ9MnFJyVB
	5J8vIXPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBRN-00000006owK-2mzV;
	Wed, 10 Jun 2026 05:25:25 +0000
Date: Tue, 9 Jun 2026 22:25:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 12/27] drbd: Convert drbd_req_state() to unconditional
 locking
Message-ID: <aij1Rd0cjZCwKgY3@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <f3f53e2c6d01b92091bfce447c9010b03a7debef.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3f53e2c6d01b92091bfce447c9010b03a7debef.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 09, 2026 at 03:04:59PM -0700, Bart Van Assche wrote:
> Prepare for enabling lock context analysis.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/drbd/drbd_state.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
> index 5aa4b1889144..171c6488283d 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -639,11 +639,12 @@ static enum drbd_state_rv drbd_req_state(struct drbd_device *device,
>  {
>  	enum drbd_state_rv rv;
>  
> -	if (f & CS_SERIALIZE)
> -		mutex_lock(device->state_mutex);
> +	if (!(f & CS_SERIALIZE))
> +		return __drbd_req_state(device, mask, val, f);
> +
> +	mutex_lock(device->state_mutex);
>  	rv = __drbd_req_state(device, mask, val, f & ~CS_SERIALIZE);
> -	if (f & CS_SERIALIZE)
> -		mutex_unlock(device->state_mutex);
> +	mutex_unlock(device->state_mutex);

It's not really unconditional, just different conditions.  And really
belongs into the previous patch.

