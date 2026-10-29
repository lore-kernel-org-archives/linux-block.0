Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278731;
	b=YibUGX4mHEGUPm3CKmogR6HVovddVyPQ9f9fL6elsxzByJ/0GhYFGV/lpSXSHl2y+L60
	 sTP432YQqz9LOXvijx2NFkwaaP3hBxvSmaAczke1vxJDHo+v0dcmtPbWhuyvBiz99g+pa
	 9q1nCVuShA9pJn7G2bR7bT3qYzP89UOz+BfaLltqT3pfYgDB38irXerQxQVZk/KTqA64o
	 0gAB8cfObuAZHkO7VVV08feaWsGOJEdFAsxrV7ZBJnyHjxdeHrQwQfDMSxgkfagsJh4b1
	 BazTcy4OoiItCVjWGdXyCvHBRQoritBk64JsTMFOF6Kjrl1GQXAeny4iQeiv/VV/qmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278731;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=QPJR/r6KfX7jGpeFmd91wn7gkE+4z3IDoY3KLE0G/Bs=;
	b=SMYGsSQcGftL3koT6F08hPxQCrSEpC6NXP3G30jiKx7oBOE4h3E7fwIU5UNNLe+oLpY8
	 P0pne6ySNy3ta1FXlG5EnsnkzThntDPZpzWBmiDQaOObeD0ZK0M5cMhm2/ok5g8POQHwu
	 88KgSxDCM8chj802rvUCHSQVToPUJ9yBCbNdWzXDcwwfzr9RAPU4wG+Vhf+d9+1Yqg8LB
	 HNlQx80XlhWUMqmZyjfafqUtQt1TY8IbZqEoFFTyvmZU+blD64gnbulE9T151H//RJcUz
	 hC58H/W7cpdgFnNmwCfy8eOXrJWItwKY5QN7XfJC6a2cTAY6NRvslwdQG+oSbfV2iRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R7wd3GJE;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE463606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE463606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R7wd3GJE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QPJR/r6KfX7jGpeFmd91wn7gkE+4z3IDoY3KLE0G/Bs=; b=R7wd3GJEymFWHBWtALVI17AgnC
	L3TjIammXWPqdOedxRl8WdMaIoB6kfcdl2tFpLlq326T3b+FyrDJSqhasDJwFnbUvZZMwAL0V9hw/
	ncpyvtrk8AX7ZH6fMhciSQKP5dV3+i2ROyjQ/8jVzeqBI70I0sSM4bz8SfBV2lxF6HLnMAh8iljnl
	GXqLWuRCdGNUjsimQ1JIzuR+q+dmplaear83YrlwncK1xGB6kGx6XigW+XYWdawhYp1qUVi8ce3l3
	DxU0B9fd3QxhM/RuKnG5deqgZsRH/h6gQ+k2sA5UsQcAuuVmeJPTS0LGGbsWi3K78Y77NZ0SCv/yU
	VmJJ0cpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPiU-00000009GIk-22jk;
	Thu, 29 Oct 2026 12:58:50 +0000
Date: Thu, 29 Oct 2026 05:58:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 30/98] blk-mq: don't bring back flags of a completed
 request
Message-ID: <auNDCvO8iWaiBvXR@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-31-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-31-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:33AM -0600, Jens Axboe wrote:
> +static inline void blk_rq_change_timed_out(struct request *rq, bool set)
> +{
> +	req_flags_t old = READ_ONCE(rq->rq_flags), new;
> +
> +	do {
> +		new = set ? old | RQF_TIMED_OUT : old & ~RQF_TIMED_OUT;
> +	} while (!try_cmpxchg(&rq->rq_flags, &old, new));
> +}

I've seen this pattern so often lately that a generic helper might be
in order.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
