Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53186197A7A
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743659074; cv=none; b=ssxqhtnYDVhGd5ww7JmcynT+to6ans37wT1+G0TB5lU3M63mWd6ZoCdTHLxeaTV05QuZAgUpSSXEEYNX3XB2rqhQURU3oVgXCmXBsCghXMkXSZ1WYbWt424UUp61EhVFLmQbC9uj1XipOK0DGRVNU+i7JubIUR9QiTcEPZkBng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743659074; c=relaxed/simple;
	bh=PLWy+NGIyJuvCkdQJQnwEsJzjoUzKKDOyXpltF2raJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LidPzIJvODP+1wndUUWewMwJpC/KvzfvC8qx/3cIf9yx6aOrTefM4OTKF8R7xARAnOYcq0VFkJ9LOFganuz16OhXbNdWAl8uWOW5P8wRZ4jA1Uj474B1SfmtbqSAJxOIVtnYCz8WRgsG5ghvL3NlWHCfJdvf71N43AhfOWuDPlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B327A68C7B; Thu,  3 Apr 2025 07:44:27 +0200 (CEST)
Date: Thu, 3 Apr 2025 07:44:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 1/3] block: add blk_mq_enter_no_io() and
 blk_mq_exit_no_io()
Message-ID: <20250403054427.GB24133@lst.de>
References: <20250403025214.1274650-1-ming.lei@redhat.com> <20250403025214.1274650-2-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403025214.1274650-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 03, 2025 at 10:52:08AM +0800, Ming Lei wrote:
> Add blk_mq_enter_no_io() and blk_mq_exit_no_io() for preventing queue
> from handling any FS or passthrough IO, meantime the queue is kept in
> non-freeze state.

How does that differ from the actual freeze?  Please document that
clearly in the commit log and in kerneldoc comments, and do an analysis
of which callers should do the full freeze and which the limited I/O
freeze.

Also the name is really unfortunate - no_io has a very clear connotation
for memory allocations, so this should be using something else.

> Also add two variants of memsave version, since no fs_reclaim is allowed
> in case of blk_mq_enter_no_io().

Please explain why.



> index ae8494d88897..d117fa18b394 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -222,8 +222,7 @@ bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic)
>  	bool unfreeze;
>  
>  	mutex_lock(&q->mq_freeze_lock);
> -	if (force_atomic)
> -		q->q_usage_counter.data->force_atomic = true;
> +	q->q_usage_counter.data->force_atomic = force_atomic;
>  	q->mq_freeze_depth--;
>  	WARN_ON_ONCE(q->mq_freeze_depth < 0);
>  	if (!q->mq_freeze_depth) {

This is a completely unrelated cleanup.

> +void blk_mq_enter_no_io(struct request_queue *q)
> +{
> +	blk_mq_freeze_queue_nomemsave(q);
> +	q->no_io = true;
> +	if (__blk_mq_unfreeze_queue(q, true))
> +		blk_unfreeze_release_lock(q);

So this freezes the queue, sets a flag to not do I/O then unfreezes
it.   So AFAIK it just is a freeze without the automatic recursion.

But maybe I'm missing something?

> +	if ((blk_queue_pm_only(q) &&
> +	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED)) ||
> +			blk_queue_no_io(q))

The indentation is very inconsistent here.  This would looks
more reasonable:

	if (blk_queue_no_io(q) ||
	    (blk_queue_pm_only(q) &&
	     (!pm || queue_rpm_status(q) == RPM_SUSPENDED))) {

Also as this logic is duplicated it might make sense to de-dup it.

