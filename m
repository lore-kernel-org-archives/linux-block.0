Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279259;
	b=JBCYXzw6hSXyiaLyXl6orMH16AVgU8a6gpgFN4zuG53p0s07bafFMwyrdwwXQQh+xQ9H
	 fRmsgJiQNWsMsEjj+gkthsYkG+6s3on23/5Syl9XST4bb7BVvLeIMPdlQUXKYz97e4cZa
	 u6W404Tv+cyknD85nJLYVkzEeOAYSPU9VMt9WtdcjK7rNhyqmrJGWYmAER9XL9ua5t2xz
	 1LPQtSTUrSYPWKSp6WfhUqNpyeep0znQxLOhzYuuJ0zTpYLC7UodB5GYy3VNX/2JIrt1C
	 IoRy4BUyYd5/yZu/fC/Vz6thkENKvbsSre1yNMrKr6wK+zHaXWlI4F+OXSRynomCd0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279259;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=XzrBePQffe/oGU0jUC0u82fIpel/lzLOGj8hLDEf1w0=;
	b=1u9qwYsIHOg5GsHtXxazoUAgqCeYTaJNWGvAbSMOYhBewOQXfSmetRV8sj7MYr74Y4Pu
	 +KPsz7SVdjzjXrH6xE8nYFG/zveqSTHWYTAg983iTiqiWcEmMOQZ2YkPF1u7vEa/Clhpm
	 2kkg6S/+xpaSyAcjYUwj30vbI7a9UP4zN455R4M0IzIVJe8BJyLZggiNHPwJEJmKHRMXw
	 S4BHGXJMDb4Jaa/NCYDpLcSOyKgkJ1heqwabkg7CumIEEdJZBy1hUK5Kzykv23la4/k9g
	 wI0yE8xnWxqbgXcJZZxESa+2bHCCZhEbZNUU4f5LdNZzOODZbSRVtEguR7WnxzmffCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zhFrZ44R;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3A606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CC3A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zhFrZ44R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XzrBePQffe/oGU0jUC0u82fIpel/lzLOGj8hLDEf1w0=; b=zhFrZ44RApkvaTSX2fdOJ8O0cI
	3NHgH2s+A7oEAWL5B/Fpl3gxh1xODqvrQU168POVXY5uu4uJtJZjwGwBp7vsWPduR66dChUel8Vyo
	B9/TG7xzaV7rgPIXQDklqBfFHE6582lqMsPpoQ3saPdJi1cSX6BnkYFyfFzDutlivK/rlCvZiL4fc
	iTlO3wTb8AJUW4xrD7f8IcAOeRfDR+PNKKFYXtDMNsOcnAKe03kzSgHi6r4xESf+FK0Phr2jadVZ3
	mwHnLa9c0rmND5JKHAzALeTPfUtFFUUy1JslOGeMLGR77W98L4EyvuUCAQY4g63Tghz2tUyvMcnAq
	KbWCXujQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPr1-00000009HIW-0DYL;
	Thu, 29 Oct 2026 13:07:39 +0000
Date: Thu, 29 Oct 2026 06:07:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 33/98] blk-mq-dma: map the metadata a passthrough request
 has
Message-ID: <auNFG5HMI5zaPX5c@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-34-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-34-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The subject line does not parse. 

> index e0e7a18790b5..5df704bbd98a 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -13,6 +13,10 @@ static bool __blk_map_iter_next(struct blk_map_iter *iter)
>  	if (!iter->bio || !iter->bio->bi_next)
>  		return false;
>  
> +	/* All the metadata of a passthrough request is in its first bio */
> +	if (iter->is_integrity && !bio_integrity(iter->bio->bi_next))

The comment does not make sense.  We're at a layer where we don't know
if this is passthrough or not.  And the block layer should make sure we
never merge integrity vs non-integrity requests into a single requests.
If the passthrough code breaks that somehow it needs to be fixed there.

> +		return false;
> +
>  	iter->bio = iter->bio->bi_next;
>  	if (iter->is_integrity) {
>  		iter->iter = bio_integrity(iter->bio)->bip_iter;
> @@ -348,6 +352,10 @@ bool blk_rq_integrity_dma_map_iter_start(struct request *req,
>  					   blk_rq_sectors(req));
>  	struct bio *bio = req->bio;
>  
> +	/* User space decides how much metadata a passthrough request has */
> +	if (blk_rq_is_passthrough(req))
> +		len = bio_integrity(bio)->bip_iter.bi_size;

DMA mapping helpers don't have any business looking at the passthrough
flag.  But this should work for kernel-generated I/O just fine as far
as I can tell.

