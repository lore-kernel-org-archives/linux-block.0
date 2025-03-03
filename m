Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD323F36F
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016377; cv=none; b=beT5KGoj5q4g0octiomZwo5dXQh2PACuPR2fFGSIw70+chLmRBtdYt92A0N8OF5PZ9PFFoyp/lqcM+ZcaE2Rk7XOLodG3yHuDUne3BBc/qgbDIOWzSZrnvykQpZuMXmToHYiewaBj+ImbJ81XCDZtDbxU6pgPjtuqZWI2LDGyIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016377; c=relaxed/simple;
	bh=O5nIK6p7Yl4P0FkUllhs/mkBN05J1hYDpXBjCHY/DIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSmm+ras1apY1DdV6Nsv6Y419mXB79H/tOSErVYrgLS2UJfjLPTWWb9D/Sa4gOdatkbDOYGl8qYW0nrJg2jeyVhhmGfBMUaKfChWNHGWQpyRCT5d+1J0SyoDLknEQz52JXmiuS6UyL2Uq0znYWOY/uckfavo+MFOcgsA+rqgDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qjNijpQt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qjNijpQt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y7Rh9/vXL6M5I738TTDeLmvLS5UjbzojIQRklzuDKEI=; b=qjNijpQtIFWzgriYd9RYSd8tT6
	4Ddxzi/7LGRMb/jEgXCtOpdVaFUl7wZ9y+RozDroKhb70f9Wli1AUQ7AqHV6gLMkFkD8zMstoqIqR
	bZFP0h7d3pX0aIcGBz7mx7rjbGp2c55sMQ7Ra3nzF42rYB1dssl6vQAJ5lwx8LWIYm6BYGuNeh2dE
	azcdaHNUgaQlzrlWpjC9nE/lToLg9yZQ9Jak3ham8saGIPPQHd2+nzif4AYmLpbVbGZFQSeCo3jYx
	OHX5KEdjjV6jiDvuy+ZlgxgoM77ANiMtMDyLTHah0BAYHLQnFeyeMRkkdR/H1HruDiP4uSqfHeHFr
	gUqytxlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp7tG-00000001M9U-2vns;
	Mon, 03 Mar 2025 15:39:34 +0000
Date: Mon, 3 Mar 2025 07:39:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Guangwu Zhang <guazhang@redhat.com>
Subject: Re: [PATCH] block: fix 'kmem_cache of name 'bio-108' already exists'
Message-ID: <Z8XNNosGwI8wGJ0x@infradead.org>
References: <20250228132656.2838008-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228132656.2838008-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Feb 28, 2025 at 09:26:56PM +0800, Ming Lei wrote:
> Device mapper bioset often has big bio_slab size, which can be more than
> 1000, then 8byte can't hold the slab name any more, cause the kmem_cache
> allocation warning of 'kmem_cache of name 'bio-108' already exists'.
> 
> Fix the warning by extending bio_slab->name to 12 bytes, but fix output
> of /proc/slabinfo
> 
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/bio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index f0c416e5931d..6ac5983ba51e 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -77,7 +77,7 @@ struct bio_slab {
>  	struct kmem_cache *slab;
>  	unsigned int slab_ref;
>  	unsigned int slab_size;
> -	char name[8];
> +	char name[12];

Can you please turn this into a pointer and use kasprintf to fill
it?  That way we fix the string overflow problem for real and don't
need to doctor around it the next time someone uses names with a
longer name.

