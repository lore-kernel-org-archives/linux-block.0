Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645B223DF9;
	Thu, 24 Apr 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494701; cv=none; b=eVOTnrM49miPPikLDPRh9M2f9ixCX/MED3x7fIFE80I0nNj1VrtfTlNWT59XG+mAwIjVncdTwD2rcK4+2lkajLs15AZp3F3lkbu9S8l4zCzyb3UWdYHn3ST28+jHyRJox2qApAguBsAqzXvRL2g7+W9p4JdjiUYo5XVEPordS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494701; c=relaxed/simple;
	bh=8kAW3azTvQ3wTRLJEl/2C0kREX99xZi13pA/UOSxPtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HT1Xyu0TlXEMyrwOj69Cge42QmYLj5YWb0GHPFpid9fkoQhllbK9Orw2scnlHLFf7rGcO9H9f1MVKGVDx2+mmnVxtORjsZI54/hRN9Ube8Xuh5TikJPn/RYT1HdYqXmnaahls9/bPbIWIJajE19p1ksrEq7npMUuzHy6j+E+vRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pd+ay/gH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pd+ay/gH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pNbO8WPypc/MomTtjMKRl+jdj9wSKdOc5ZgIbTWg7Yk=; b=Pd+ay/gHiNWOdH/+lO5Xsp/is7
	oBsdg/RZy6QiBPQZIGYJPhNcW0MzwXfCkxcEJwbtaZo+D+bBeQ0PNdDeaqPaHnIrYMm24ypH6hgE9
	nEQ26LHGpxoipBHhoGHCuVBAOv4nJbDWpDMLBow1YAaPnobvqMsjy6RLY1NZdQ6Df1/xk/UW0xFAx
	BujAeW3phiUqcMBabya+/XdSmsNpAzDikKO83228K/VgNC3TrtHL1RuP0NOelJfmXQ5GBktV90u+V
	omk69bL1UJH2oOhjRHAfp3tBcWTXd1SbNZgyl9FHY3mx0+FoQCHuznvwxg/ypZSyi1d6AJeHrh3gv
	CA+JwxuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7uuJ-0000000DtHH-3OGA;
	Thu, 24 Apr 2025 11:38:19 +0000
Date: Thu, 24 Apr 2025 04:38:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] block: avoid hctx spinlock for plug with multiple
 queues
Message-ID: <aAoiq1AsoD-k_kp3@infradead.org>
References: <20250423205127.2976981-1-csander@purestorage.com>
 <20250423205127.2976981-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423205127.2976981-4-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +static void blk_mq_extract_queue_requests(struct rq_list *rqs,
> +					  struct rq_list *queue_rqs,
> +					  unsigned *queue_depth)
> +{
> +	struct rq_list matched_rqs = {}, unmatched_rqs = {};
> +	struct request *rq = rq_list_pop(rqs);
> +	struct request_queue *this_q = rq->q;
> +	unsigned depth = 1;
> +
> +	rq_list_add_tail(&matched_rqs, rq);
> +	while ((rq = rq_list_pop(rqs))) {
> +		if (rq->q == this_q) {
> +			rq_list_add_tail(&matched_rqs, rq);
> +			depth++;
> +		} else {
> +			rq_list_add_tail(&unmatched_rqs, rq);
> +		}

This might be moe efficient if you keep an extra iterator and never
mode the request for another queue.

> +	}
> +
> +	*queue_rqs = matched_rqs;
> +	*rqs = unmatched_rqs;
> +	*queue_depth = depth;

.. and I'd return the queue depth here instead of making it another
output argument.

> +static void blk_mq_dispatch_multiple_queue_requests(struct rq_list *rqs)
> +{
> +	do {
> +		struct rq_list queue_rqs;
> +		unsigned depth;
> +
> +		blk_mq_extract_queue_requests(rqs, &queue_rqs, &depth);
> +		blk_mq_dispatch_queue_requests(&queue_rqs, depth);
> +		while (!rq_list_empty(&queue_rqs)) {
> +			blk_mq_dispatch_list(&queue_rqs, false);
> +		}

No need for the braces in the inner while loop here.

The other caller of blk_mq_dispatch_list loops until the list is empty,
why don't we need that here?

