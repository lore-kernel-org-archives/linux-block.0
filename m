Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889051531E8
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299147; cv=none; b=fKyDbUfQLS9kv5H5yKt8lCnhj9ipx2f4O5yBiF4hDxdD59GrVPZOMzZjdhBHD1UJzYdSnYJXm2a06qycQn4Q1ERKvorhNRH3Z1puw3o+lglZd5g/9o6heDjI45rXTfBTbfkTYxIxyiJOdanLSKNsdYL8MEJ4WV6/x+kmqJpViH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299147; c=relaxed/simple;
	bh=V2bWI1S0krajEeGQJuWrBBzP2Kohxnc+1j313RTjtaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N8zKK3qa3BWrLAJsph5cMRKpIZN6vWNIbXiWyih3Ha4LxOOuCkkE382yC6F/b2nsw4pOgLC/NEPeZoQbkhqZOADFa4UVOiNS5dtn0CDHOhavl8qYjfRo6aD4Mh1a6i2ePV9/RsJcvgOlIjZ+allxWy9Om9p0P1KBIQe313MUmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A62E268B05; Mon,  1 Jun 2026 09:32:21 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:32:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH v5 08/12] block/blk-iocost: Add lock context annotations
Message-ID: <20260601073220.GD7799@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <669c0e4dd3a8e8e038dff8c19aa61f0359df2bd8.1779997063.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 28, 2026 at 12:45:45PM -0700, Bart Van Assche wrote:
> Since iocg_lock() and iocg_unlock() both use conditional locking,
> annotate both with __no_context_analysis and use token_context_lock() to
> introduce a new lock context.

Both of these are only called from two funtions.  Have you looked into
merging the locking logic into these helpers to see if this improves
the situation?  __no_context_analysis just seems like a big hammer
for something relatively simple like this.

> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-iocost.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 353c165c5cd4..3bb8ce50af42 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -727,7 +727,11 @@ static void iocg_commit_bio(struct ioc_gq *iocg, struct bio *bio,
>  	put_cpu_ptr(gcs);
>  }
>  
> +token_context_lock(ioc_lock);
> +
>  static void iocg_lock(struct ioc_gq *iocg, bool lock_ioc, unsigned long *flags)
> +	__acquires(ioc_lock)
> +	__context_unsafe(conditional locking)
>  {
>  	if (lock_ioc) {
>  		spin_lock_irqsave(&iocg->ioc->lock, *flags);
> @@ -738,6 +742,8 @@ static void iocg_lock(struct ioc_gq *iocg, bool lock_ioc, unsigned long *flags)
>  }
>  
>  static void iocg_unlock(struct ioc_gq *iocg, bool unlock_ioc, unsigned long *flags)
> +	__releases(ioc_lock)
> +	__context_unsafe(conditional locking)
>  {
>  	if (unlock_ioc) {
>  		spin_unlock(&iocg->waitq.lock);
---end quoted text---
