Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980B541760
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 06:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589233; cv=none; b=KXWKJNfunVqt6MkchDZ4P+HiLzLzdNLncF0btCaSeMZpHzA+HEuAEhZQtoBhCLD/3RI68vbNtQyYyflqjGQZxBUMNMN9B8oyOq9E9+zoey8yO7NQEjToIEU6O6bqBKh/7mPPGNKcYfMn5DqxqzdaEzX1gX7jl3Du+SEU6I2mkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589233; c=relaxed/simple;
	bh=ime3f91EUIZ5bd/5/10R4eQDC/Fs9LGVRaWfp+9vcHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITv7E8Wgn7e0B5gUr71qyMDKLkzecMVkRJf94W99CkSymc56wDkncUIoDy+SfVQRVMnqGCqhlGh3Uq09bQIIlTtpy/6UIntVtFdDqDgsMB5anx2rISMKYBidE3tQVEC9FGNgQtstLgw1/W9vpBadVhckPxQnwIR89xQGx4jM7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F62168AFE; Thu, 19 Dec 2024 07:20:27 +0100 (CET)
Date: Thu, 19 Dec 2024 07:20:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs
 for atomic update queue limits
Message-ID: <20241219062026.GC19575@lst.de>
References: <20241217044056.GA15764@lst.de> <Z2EizLh58zjrGUOw@fedora> <20241217071928.GA19884@lst.de> <Z2Eog2mRqhDKjyC6@fedora> <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org> <Z2Iu1CAAC-nE-5Av@fedora> <f34f179a-4eaf-4f73-93ff-efb1ff9fe482@linux.ibm.com> <Z2LQ0PYmt3DYBCi0@fedora> <0fdf7af6-9401-4853-8536-4295a614e6d2@linux.ibm.com> <9e2ad956-4d20-456f-9676-8ea88dfd116e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e2ad956-4d20-456f-9676-8ea88dfd116e@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 18, 2024 at 06:57:45AM -0800, Damien Le Moal wrote:
> > Yeah agreed but I see sd_revalidate_disk() is probably the only exception 
> > which allocates the blk-mq request. Can't we fix it? 
> 
> If we change where limits_lock is taken now, we will again introduce races
> between user config and discovery/revalidation, which is what
> queue_limits_start_update() and queue_limits_commit_update() intended to fix in
> the first place.
> 
> So changing sd_revalidate_disk() is not the right approach.

Well, sd_revalidate_disk is a bit special in that it needs a command
on the same queue to query the information.  So it needs to be able
to issue commands without the queue frozen.  Freezing the queue inside
the limits lock support that, sd just can't use the convenience helpers
that lock and freeze.

> This is overly complicated ... As I suggested, I think that a simpler approach
> is to call blk_mq_freeze_queue() and blk_mq_unfreeze_queue() inside
> queue_limits_commit_update(). Doing so, no driver should need to directly call
> freeze/unfreeze. But that would be a cleanup. Let's first fix the few instances
> that have the update/freeze order wrong. As mentioned, the pattern simply needs

Yes, the queue only needs to be frozen for the actual update,
which would remove the need for the locking.  The big question for both
variants is if we can get rid of all the callers that have the queue
already frozen and then start an update.

