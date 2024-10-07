Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE113A8F0
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280621; cv=none; b=AHwCvrji179QKb+sO4NdKPf6c+8zzz+4c60p1mTx+4SEedKXsJy6JlVunPpO0x7vXVRO8wp8Sm9Qe/UYzs+1dTG81sZiYW5pBuwzQoxucRsxfDqVxvkGvJPind0lXeYLUEbGBo5f7ubCWKR2bMrOPA5HgBvnafe8pKrsTJ9X1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280621; c=relaxed/simple;
	bh=WbBTY3zd9Yx8q1ZqTqR/LS3Q6vJ2tE+bh/lMSwfADMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBdbK/fSf721wtatzJDjqpXXafxf4nuizpbVblkb1qAXz/UU6/c4hjTfzw1dgAOtvnyoI16IYx0t7q7uv6h8ZHfopvNgg3YqPCQhxi9CZzZEX7lyB6dI7LltpAXRH9w5lN42t1GaLIs6nLEHeAW6XSmm2u0GJubtwBx+kegZ0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42335227A8E; Mon,  7 Oct 2024 07:56:56 +0200 (CEST)
Date: Mon, 7 Oct 2024 07:56:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv2] block: enable passthrough command statistics
Message-ID: <20241007055656.GA510@lst.de>
References: <20241003153036.411721-1-kbusch@meta.com> <20241004053828.GA14377@lst.de> <ZwAD7RZjqpzQl43s@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwAD7RZjqpzQl43s@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 04, 2024 at 09:04:13AM -0600, Keith Busch wrote:
> Even Jens was a little surprised to find nvme passthrough sets the bio
> bi_bdev. I didn't think it was unusual, but sounds like we are doing
> something special here.

IIRC it was added to support metadata passthrough, but I'd have to do
a little research to find the details.

> > > +	/*
> > > +	 * Ensuring the size is aligned to the block size prevents observing an
> > > +	 * invalid sectors stat.
> > > +	 */
> > > +	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
> > > +		return false;
> > 
> > Now this probably won't trigger anyway for the usual workload (although
> > it might for odd NVMe command sets like KV and the SLM), but I'd expect the
> > size to be rounded (probably up?) and not entirely dropped.
> 
> This prevents commands with payload sizes that are not representative of
> sector access. Examples from NVMe include Copy, Dataset Management, and
> all the Reservation commands. The transfer size of those commands are
> unlikely to be a block aligned, so it's a simple way to filter them out.
> Rounding the payload size up will produce misleading stats, so I think
> it's better if they don't get to use the feature.

True.  Please put this into the comments!

> 
> > > +	ret = queue_var_store(&ios, page, count);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (ios)
> > > +		blk_queue_flag_set(QUEUE_FLAG_IOSTATS_PASSTHROUGH,
> > > +				   disk->queue);
> > > +	else
> > > +		blk_queue_flag_clear(QUEUE_FLAG_IOSTATS_PASSTHROUGH,
> > > +				     disk->queue);
> > 
> > Why is this using queue flags now?  This isn't really blk-mq internal,
> > so it should be using queue_limits->flag as pointed out last round.
> 
> So many flags... The atomic limit update seemed overkill for just this
> flag, but okay.

I've been slowly working on making q->flags entirely limited to
blk-mq internal state.  We're not quite there yet, but I'd like to
keep up the direction rather than having to fix it up later.
