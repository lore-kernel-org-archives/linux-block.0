Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F1F1E835B
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613241; cv=none; b=mTynb0M7pU+6vTf4hS39KhBa/DXWHwbJiM/aTnXuJeUat5YvO1VeGHdhnFkE7NVeX8iAMnHaKgsYMIPNXBxyTEOvxBPAHn/ZrXvrRDE/svHyqgjRp6PLoLH3iPzHRtfhhitZoxemDAFt1xwbyiuPoTskUafhkkkCNqn9kiOWjrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613241; c=relaxed/simple;
	bh=wvob4aRj2zs21xlqZsu1cSo43qbCuxvJ/B3mQuaowKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlSUd2AT93O1VqNVkO+v0nCPCjed05mAP0W3/4DaEquvALoknE0OdBuiI/L5vdD5IIgVDZU7KF6IKO1B++H8B+Vrr/M+wa+mib0kmlRa6zSMJJ6h3aU673VQWYy43mONxjiFMH1J5mrIwkzg/gEQHQWZCHm+56tPuqS6vxTWFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F8DC68C4E; Wed, 11 Jun 2025 05:40:32 +0200 (CEST)
Date: Wed, 11 Jun 2025 05:40:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	Ming Lei <ming.lei@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <20250611034031.GA2704@lst.de>
References: <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org> <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org> <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org> <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org> <907cf988-372c-4535-a4a8-f68011b277a3@acm.org> <20250526052434.GA11639@lst.de> <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org> <20250609035515.GA26025@lst.de> <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org> <aEi9KxqQr-pWNJHs@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEi9KxqQr-pWNJHs@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 10, 2025 at 05:18:03PM -0600, Keith Busch wrote:
> I think you could just prep the encryption at the point the bio is split
> to its queue's limits, and then all you need to do after that is ensure
> the limits don't exceed what the fallback requires (which appears to
> just be a simple segment limitation). It looks like most of the bio
> based drivers split to limits already.

I'm still a bit confused about the interaction of block-crypto and
stacking drivers.  For native support you obviously always want to pass
the crypt context down to the lowest level hardware driver, and dm
has code to support this.  But if you stacking driver is not dm, or
the algorithm is not supported by the underlying hardware it looks
like we might still be able to run the fallback for a stacking
driver.  Or am I missing something here?  Eric/Bart: any chance to
get blktests (or xfstets if that's easier to wire up) to exercise all
these corner cases?

> And if that's all okay, it simplifies quite a lot of things in this path
> because the crypto fallback doesn't need to concern itself with
> splitting anymore. Here's a quick shot a it, but compile tested only:

Exactly.  And in the next step we can significantly simply and speed
up the bio submission recursion protection if __bio_split_to_limits
is the only place that can split/reinject bios for blk-mq drivers.

> diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
> index 94a155912bf1c..2804843310cc4 100644
> --- a/block/blk-crypto-profile.c
> +++ b/block/blk-crypto-profile.c
> @@ -459,6 +459,16 @@ bool blk_crypto_register(struct blk_crypto_profile *profile,
>  		pr_warn("Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
>  		return false;
>  	}
> +
> +	if (queue_max_segments(q) > BIO_MAX_VECS) {
> +		struct queue_limits lim;
> +
> +		lim = queue_limits_start_update(q);
> +		lim.max_segments = BIO_MAX_VECS;
> +		if (queue_limits_commit_update(q, &lim))
> +			return false;
> +	}

I think this limit actually only exists when using the fallback, i.e.
when no profile is registered.  And even then only for encrypted bios.

We'll also need to ensure the queue is frozen and deal with limit
changes after the profile registration.  I suspect we should probably
integrate the queue profile with the queue limits, so things are don't
in one place, but that's out of scope for this patch.

It's also not just a segment limit, but also an overall size limit,
i.e. it must be no more than 256 * 4k.

