Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B272147E5
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299039; cv=none; b=F2zJZea2kFYIdKspWcQJPxgkio0Q3mnEtcFpg83umBK0iaKKjYkLGwYMxkpB16pn4VXG7ODyvyeuSd0H2l72TGBYmuULB8p+l5AQGU4JLaxHE1F9FL50YY4JKhNIw8l0wd3t/XJyTyoKDmAg9+NbvYFxN4Z7Vm6tN08daDoUBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299039; c=relaxed/simple;
	bh=sQDFIEpPCk9nv5tsvv0u1xHmqyf3Jd31JUz+qNtUQac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtm8kBNyzvIz2sePOvAbaAxRQZxQLDi13K9Wm+tcAXKYpFILPJlSFuHxMkDW++aQOb1nXMNSBSuRZ7B3KXnPMoofviBcEd6KzXg8mxMkqpuQofKIZaAcw2prILiX3r3fq1s/pgfadhJhma6uJuuzjxAEqkLz3VsdnJA8i3GQLQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 938CC68BEB; Mon,  1 Jun 2026 09:30:33 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:30:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v5 06/12] block/cgroup: Inline
 blkg_conf_{open,close}_bdev_frozen()
Message-ID: <20260601073032.GC7799@lst.de>
References: <cover.1779997063.git.bvanassche@acm.org> <f7be976e5a79afc88970ea16158d0a64bbf8f25e.1779997063.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7be976e5a79afc88970ea16158d0a64bbf8f25e.1779997063.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 28, 2026 at 12:45:43PM -0700, Bart Van Assche wrote:
> The blkg_conf_open_bdev_frozen() calling convention is not compatible
> with lock context annotations. Inline both blkg_conf_open_bdev_frozen()

Maybe say fold into the only caller here?  Inline to me implies turning
it into an inline function.
> +	q = ctx.bdev->bd_queue;
> +	blkg_conf_close_bdev(&ctx);
> +	blk_mq_unfreeze_queue(q, memflags);
> +
>  	return nbytes;

[...]

> +	q = ctx.bdev->bd_queue;
> +	blkg_conf_close_bdev(&ctx);
> +	blk_mq_unfreeze_queue(q, memflags);
>  	return ret;

It looks like this could be easily shared into a single label
if you check for a non-zero ret and return that and else nbytes.

Otherwise this looks good.

