Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB237F735
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452603; cv=none; b=PvtYd2xSuGFDXcg6R2kiZcy1+kJThSBbbxfKIZaAq/IlgktwP26g0hFRa41xhZLx6A1bjoyh1GLOjb1MYS/6pRtotCdiiOKVODEA+F9onF/9X5renT7JNhVPkqbE8bs9XMq3mprRdnFlo4bZkntZYLphIL1DUxubdWsAIk2dOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452603; c=relaxed/simple;
	bh=E9qRZBWEH6S8PeXnWW6j3xVzUwDGGpc8SgjHu7gsv1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2iSl6O+AaThwPtynC8+ZBWz3OxrT23PtDTA9isoF4lQRfa5OrZlGz3D2PBfvsFh028A4L0M58EfSznwfyffhOK0696Rik3r/2YpEh+SDRktSRajx6V+nrXOk/5RouTwrrJmYAw4E/bYW8EPMQSm/xbY3ogl8nx7pIUQZxYjXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzzZD0C2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzzZD0C2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654F51F000E9;
	Fri, 22 May 2026 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452602;
	bh=OO2UMEnd45wrlNe7ZXO7SPpcXvrVkWHNHY6QDwNdD+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UzzZD0C2cclkxaydBrqmUfKDPHT+chfkYS7Xss9EdfW70L74Iyv5YCXNGBUXWqQY0
	 C0+08yYEEl6164JsqSHIqKDPJyK9Jo3+mHu8QztkMJGViREWjBtfZmY/gjZbhSrxBO
	 YD8DwWYSbyl/9cX/GPXxHFmZcXEOwbcNsXRh4Uy9Sb8/GvvYch4pYlrokwBrBQs/f4
	 4fIb4H8vMVkcONEyeu5Nx1u+SJtvbe+DsMYzKwRfnX/RvbFsIh05WDXT5c7cf73vty
	 meweBKB6zv/lXCi/+hld2oBkzx0SURRtBQteD9+YMWoWXVKwRU8W4h3+HqTrlIy2Re
	 qV5fKJiagipcg==
Date: Fri, 22 May 2026 06:23:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, tom.leiming@gmail.com
Subject: Re: [PATCHv3] blk-mq: pop cached request if it is usable
Message-ID: <ahBKuBp11OE7YTth@kbusch-mbp>
References: <20260521190253.242065-1-kbusch@meta.com>
 <20260522090340.GA7331@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522090340.GA7331@lst.de>

On Fri, May 22, 2026 at 11:03:40AM +0200, Christoph Hellwig wrote:
> > @@ -3257,12 +3243,10 @@ void blk_mq_submit_bio(struct bio *bio)
> >  	return;
> >  
> >  queue_exit:
> > -	/*
> > -	 * Don't drop the queue reference if we were trying to use a cached
> > -	 * request and thus didn't acquire one.
> > -	 */
> >  	if (!rq)
> >  		blk_queue_exit(q);
> > +	else
> > +		blk_mq_free_request(rq);
> >  }
> 
> I think keeping a comment here would be nice, a would be avoid
> the inversion of the condition for a trivial if/else.
> 
> But on a higher level, I really think you should add it back to the
> batch list here, otherwise we're doing lots of roundtrips through
> blk_mq_free_request for trivially mergable sequential I/O.

That gets compicated when we did sleep. This request may be the last
reference that's holding up a freeze. We really want to re-enter the
queue in that case because the driver is trying to change the queue
limits. Unless this is measurably harming perforamnce, it's a corner
case that's just easier to not think about.
