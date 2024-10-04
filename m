Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBCE1D9A47
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054256; cv=none; b=JrBrxP9YA4uZw0ER8crgNmDkcpVxreI6mDN4l5+Mv6K4Fls7vier9/78DbLkVfGPyYZBCpNBdzChJlO/10e6iAi93khFt40+tR3OCt9nUqWGO9hGVua74IzzA93kotR4oRM99rpwrMZWJ7ztShtMHGUZMspztIv8g0D3/R9rhI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054256; c=relaxed/simple;
	bh=0Mvf8g0y/IetiNf9TuF7nLsheo7/DratM5IF+Ugx0M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETvT3jT0pbj/lOk6Bj1NKFyyyiAxf7kq81hKOZw5vu6JQ6jjQkFFuWDmIv3ilZQdAHo8mHzi4QusAqDyOZU+zqyPSWKGMgVeIE9lwR/c+VvM0KIwbkkyTkpifGwIe6T8+1re2sc/QC6FcA8mNLPLWevfBW3c+3ybaxmbSTw4GMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg3RCbtL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg3RCbtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9EBC4CEC6;
	Fri,  4 Oct 2024 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728054255;
	bh=0Mvf8g0y/IetiNf9TuF7nLsheo7/DratM5IF+Ugx0M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lg3RCbtLVm+YVVxm5s0AfTybLJu01G/6mZpS9n7hqn/zSd0ZZLLC491mDoB+pLT8H
	 JVWfnHIuD5eGv/U4kRn4UUNmBo/Zt0zp4M+DnEDerpGq3D0lkGIHMPfGZfuPW+YZBW
	 XIdecAdBeaCURpJ0vv3xke4zUnxtVhk30as6zXB9wBNAcDqsCT68hnRPeAyJ/crUkx
	 Cwa38U8mTN2nGhrE/9PX212/WMwXPz7ALmUueRCiMpB/kXJ7xoBKkg5Dmy1A6gbdZr
	 TtJPhqZ/Cm8jTZR4Deul75mVKMimnvep5Vnr0GQwKKiMuWl1OiX+PVzjfhnQKq6G1/
	 T3hr0oiq6X5ug==
Date: Fri, 4 Oct 2024 09:04:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCHv2] block: enable passthrough command statistics
Message-ID: <ZwAD7RZjqpzQl43s@kbusch-mbp>
References: <20241003153036.411721-1-kbusch@meta.com>
 <20241004053828.GA14377@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004053828.GA14377@lst.de>

On Fri, Oct 04, 2024 at 07:38:28AM +0200, Christoph Hellwig wrote: > 
> Missing. At the end of the sentence.  But even then this doesn't
> explain why not accouting these requests is fine.
> 
>  - requests without a bio are all those that don't transfer data
>  - requests with a bio but not bdev are almost all passthrough requests
>    as far as I can tell, with the only exception of nvme I/O command
>    passthrough.
> 
> I.e. what we have here is a special casing for nvme I/O commands.  Maybe
> that's fine, but the comments and commit log should leave a clearly
> visible trace of that and not confuse the hell out of people trying to
> understand the logic later.

Even Jens was a little surprised to find nvme passthrough sets the bio
bi_bdev. I didn't think it was unusual, but sounds like we are doing
something special here.
 
> > +	/*
> > +	 * Ensuring the size is aligned to the block size prevents observing an
> > +	 * invalid sectors stat.
> > +	 */
> > +	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
> > +		return false;
> 
> Now this probably won't trigger anyway for the usual workload (although
> it might for odd NVMe command sets like KV and the SLM), but I'd expect the
> size to be rounded (probably up?) and not entirely dropped.

This prevents commands with payload sizes that are not representative of
sector access. Examples from NVMe include Copy, Dataset Management, and
all the Reservation commands. The transfer size of those commands are
unlikely to be a block aligned, so it's a simple way to filter them out.
Rounding the payload size up will produce misleading stats, so I think
it's better if they don't get to use the feature.

> > +	ret = queue_var_store(&ios, page, count);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (ios)
> > +		blk_queue_flag_set(QUEUE_FLAG_IOSTATS_PASSTHROUGH,
> > +				   disk->queue);
> > +	else
> > +		blk_queue_flag_clear(QUEUE_FLAG_IOSTATS_PASSTHROUGH,
> > +				     disk->queue);
> 
> Why is this using queue flags now?  This isn't really blk-mq internal,
> so it should be using queue_limits->flag as pointed out last round.

So many flags... The atomic limit update seemed overkill for just this
flag, but okay.
