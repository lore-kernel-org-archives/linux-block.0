Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278986;
	b=SpHA7L8RasaMFWQ6X/KaPSmWSdgq9ey9uOptNgwXy6l7t86nSd3kWjMPaEMUfIMA3EWc
	 YO4txDwgBJYhrUn7155v9zmGbJtud3m+aK0ILRlZKMROAMdPKePYo0NORT1H3B335RfeL
	 /ta6X5spoOhWuG7uAQKdrpm2RdA+DsWJaNxA5JOFpBZ5CuDGPyihRaM+BYhn2BcMHWEyJ
	 iGCFqNfANYVEGi1169YKw9taWCABWsipAYbuxxaVYZfiWF154K+fswVfYxghhSM48f8ep
	 QGuxZjuYJu6UOIUifq9ZmRQXfIb9ddaljocQd6S+rTf0NUqfiqgb8VLNn2BywTrbSnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278986;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=HVVdzMaKrC0BVlk6uBpWGwHAUZ1F5kcqyTGpJeaqD0U=;
	b=CqxNlqkJD7qQCEjFTJZJhd8Txs4Q/EK338uXw/XZF5igU7yxMr1Djn7qbErhgvog+Mep
	 xyXkqzeNzdU/97TKd1m4dE//naoQKvp9bZ6rHYiYPvsUNsDp5EYxYRzYbZIoa7NWL8iYj
	 2IPAWNq6Q/8g3WlMARkK2uCHZzLADlsj/UMvvOSWqTCx2C2jADnNwx+xL9se7XNkAXmCx
	 RYEhILcCuaWdpHNBCl/Z36eOGwVRXBnnRpreznlEOtOedQxA0DUgv0UcxkM4OvBAhsvh5
	 NOthE1r+GDyqF0y226AUo/UCt5TYIwQTkZTdMug6mM/rv9+lYHVokhANBNLskk5Z7Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1OINFdYC;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E985606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E985606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1OINFdYC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HVVdzMaKrC0BVlk6uBpWGwHAUZ1F5kcqyTGpJeaqD0U=; b=1OINFdYCEpoQY3+oakRhTNlZAu
	hI2EvLgWD0usmw2VNH5UvaTXRpqyixs9Iew1xxMKf+jq2f00xpBKaZkaZnFmFOHDjXYb2slMFyBY2
	YsEP2/tMgUzUFC6POtfWOkwnpkdZ+2JLMHhgTDp1qcM7fOiMQbobkZzZCF0oyBCjJ4o5vgc/kVMBq
	Y2RV8vOw54AtxEuC12uEtHNczqDXKWHXpocGfZTtWhqHah8Z6AzkZCwi3M63cB7/ffsj87ySb8bsO
	X8FFRW614NX5nVw5V0lMYQGrZ5ftjfpxNQxPh5HIEOqGLXNidHDe7X9b5IQP//ZvvgaqhDCRitZTH
	B6wRXHwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPmb-00000009Goq-3z4m;
	Thu, 29 Oct 2026 13:03:05 +0000
Date: Thu, 29 Oct 2026 06:03:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 32/98] blk-mq-dma: initialize the dma state for P2P, too
Message-ID: <auNECTehTtOYGbTB@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-33-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-33-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:35AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> blk_rq_dma_map_iter_start() promises that the caller need not initialize
> the dma_iova_state, but the P2P bus address path returns before it does
> so. The state then holds what the last request with that tag left, and
> blk_rq_dma_map_coalesce() describes a transfer as one IOVA range that it
> isn't. Clear it on that path too.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
