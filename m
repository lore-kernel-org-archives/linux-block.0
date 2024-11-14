Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2DB8F62;
	Thu, 14 Nov 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601070; cv=none; b=n+VzuEj0J+HI5JQ6kXbCwjhC1EM8klpqJjpIUnyVi2Vf983mt7uG08NSMFQtInw7odgDKMtCA4y5jCk7HJlU1CTM8WBwHrOVDSqHDxxjM3dg7I6A9V/H6YjD7AZoRNlPrjvIb+o84kjX4+RNDW8rtyUbVTsoTDkMlLiHrcYDNjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601070; c=relaxed/simple;
	bh=nUKrRMu6CcbBi+AMOmL7j4x3/rE3yGGOQCRBTH468IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPvfLrmVzOZaUPDrQgp40E7ATao+uTTIWiuUCT2wwIwCAfhc0wI09tNaX2WFKRxHWy/u4ZHk6AZIHjyUkwpuPD/GKQoXO7Rynmgi2T5w1LjnYoYBUnLUfIhIzwtW7LpwhsiusquxkNscrNesadulExYixzFHQBRq6PidsbcIpSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 94F7068C7B; Thu, 14 Nov 2024 17:17:44 +0100 (CET)
Date: Thu, 14 Nov 2024 17:17:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chinmay Gameti <c.gameti@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	joshi.k@samsung.com, anuj20.g@samsung.com, nj.shetty@samsung.com,
	kundan.kumar@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH] block: add larger order folio instead of pages for
 passthrough I/O
Message-ID: <20241114161744.GA2078@lst.de>
References: <CGME20241114140134epcas5p3474e82266c4c117919a920d1dd4ed410@epcas5p3.samsung.com> <20241114135335.21327-1-c.gameti@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114135335.21327-1-c.gameti@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 14, 2024 at 07:23:35PM +0530, Chinmay Gameti wrote:
> +unsigned int get_contig_folio_len(unsigned int *num_pages,
> +				  struct page **pages, unsigned int i,
> +				  struct folio *folio, size_t left,
> +				  size_t offset)

Not a good name for a non-static function (not even for a stic
one to be honest).

> @@ -313,21 +314,35 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  		if (unlikely(offs & queue_dma_alignment(rq->q)))
>  			j = 0;
>  		else {
> -			for (j = 0; j < npages; j++) {
> +			for (j = 0; j < npages; j += num_pages) {
>  				struct page *page = pages[j];
> -				unsigned int n = PAGE_SIZE - offs;
> +				struct folio *folio = page_folio(page);
>  				bool same_page = false;
>  
> -				if (n > bytes)
> -					n = bytes;
>  
> -				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
> -						     max_sectors, &same_page))
> +				folio_offset = ((size_t)folio_page_idx(folio,
> +						page) << PAGE_SHIFT) + offs;

I'm not sure if Jens want to rush something like this in for 6.13, but if
we're aiming for the next merge window I actually have a 3/4 done series
that rips out bio_add_hw_page and all the passthrough special casing by
simply running the 'do we need to split the bio' helper on the free-form
bio and return an error if we do.  That means all this code will go away,
and you'll automatically get all the work done for the normal path for
passthrough as well.

> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 60830a6a5939..1e5fbc875ecc 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -422,6 +422,10 @@ void __bio_add_page(struct bio *bio, struct page *page,
>  		unsigned int len, unsigned int off);
>  void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
>  			  size_t off);
> +unsigned int get_contig_folio_len(unsigned int *num_pages,
> +				  struct page **pages, unsigned int i,
> +				  struct folio *folio, size_t left,
> +				  size_t offset);

And this really should bot be in a public header.

