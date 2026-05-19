Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDBD33A9FE
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779160045; cv=none; b=nFSCFmR+UvDuFmsNiCiTQlatid+MUZy4+QS77HANNBZl2YvCO6td0R/YBPG5RfUL2WOAe95/qRHFjGv4Vd7+TFOAcMwz++x8gEnE9ApBQIOMPkY6F0FPLkmynF0f23AD04k8wdcmPeXBUcxVkLM8nPsLyeksPkDdYdRnE08zYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779160045; c=relaxed/simple;
	bh=COKGnhFmQV+Xpkjl+e7HvSRjIG32Gy1V570H/Unop9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAWMMSa0FzuQXQZS//v0d2PWgQ1xwTOqE10Dnjq2IfDoQhHn0VvUCHmmr+otRC8igNsWZVRtmNwlzGMXGwmZOA7wUrFrle2w/BTi1pLlX47ImfHiQdzqfmfuPAenZJUgUW0xmEEV7jHfrE4rE8gpgwS3kiT0DcSBAzqxWFHewTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLYRnPGO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLYRnPGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA0FC2BCB7;
	Tue, 19 May 2026 03:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779160045;
	bh=COKGnhFmQV+Xpkjl+e7HvSRjIG32Gy1V570H/Unop9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TLYRnPGOQm2IVeLOfBSuNq9wTPnzBa3g6AAU9w0u73YLUqBWiEDhN5rKiVeDoPqYW
	 ss0jaggQndWUxWZrekx8HzI+gDOgxMmog0UmFaJ3RhxKNFd9nZ9ubHIXRlsTeMAqwE
	 0PE3WcF46eZ81dd/ZSRwvXmkzTX7+r346t3lbt/IBFInHmm1A292kIZAX1xP8nbdar
	 +ZSZy0N8dxkm4w0VULcqZ6/LiR8BlKSMvJgjyfC57tMPcShelOM8764gA38zPgT1MQ
	 O5VrN/CEN47wm4u9rDZS/KM/fECnxrfOuzTJnMDiN4r50py5bpMh/F4FUys6amHFmi
	 RLsdFLKgKuU5w==
Date: Mon, 18 May 2026 21:07:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv2] blk-mq: check for stale cached request in
 blk_mq_submit_bio
Message-ID: <agvT6mMM5Tc2ABbk@kbusch-mbp>
References: <20260501174120.403960-1-kbusch@meta.com>
 <agu74lMg10kxPXrl@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agu74lMg10kxPXrl@fedora>

On Tue, May 19, 2026 at 09:24:50AM +0800, Ming Lei wrote:
> On Fri, May 01, 2026 at 10:41:19AM -0700, Keith Busch wrote:
> >  
> >  new_request:
> >  	if (rq) {
> > -		blk_mq_use_cached_rq(rq, plug, bio);
> > +		if (!blk_mq_use_cached_rq(rq, plug, bio)) {
> > +			struct bio_integrity_payload *bip = bio_integrity(bio);
> > +
> > +			if (bip && (bip->bip_flags & BIP_BLOCK_INTEGRITY))
> > +				bio_integrity_free(bio);
> > +			rq = NULL;
> > +			goto retry;
> > +		}
> 
> This way still looks fragile, given rq isn't guaranteed to be live.

Yeah. The current usage in this patch looks like it should work out, but
not necessarily by design, so yes, fragile.
 
> Just wondering why not pop it from plug->cached_rqs from beginning, and
> move it back in case of `queue_exit:`?

Not sure. I guess it's an optimization when the bio merges with a
previous request in the plug? If we popped initially, a successful merge
has to push it back. Maybe there's a better reason I'm not seeing.
