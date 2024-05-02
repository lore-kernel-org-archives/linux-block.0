Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952101C2AF
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714628159; cv=none; b=ACP7pcwyNmITGN2TI1NqaFFwlvJZfn/m+WHjMmoORqGlDhv7WC4JXRmIQ/85cA/2cAghA7HhoccOvoW7BqC8ByaEi4dVvDJsdVKAPcnByUwzgj91TI29xzIptNkV5lPuIaBMLqaZBRU6eMivI6x924yTtQegUZ9IRzNd8Y5KWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714628159; c=relaxed/simple;
	bh=dzw1G3tIrOcNsqpmcJf+tbWvBcZ6wi1yDl0ASZVfZzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAzLuWP8tVLw5HnNeQJylC/59dLHYbmZ016RLFHyvLCxcUwb9rL/Bc19hpmLejthd3RUHsX3Bsu1zNucFTz7JGR6tP4bxm8CbQLHb3zH7g7r2DnJE1uk1tIIqHK2A776MgbWDtzifuwUe6hXGl5bK29C6YInv5rafrFgI091q60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 659E2227A87; Thu,  2 May 2024 07:35:53 +0200 (CEST)
Date: Thu, 2 May 2024 07:35:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v2] block : add larger order folio size instead of pages
Message-ID: <20240502053553.GA27922@lst.de>
References: <CGME20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff@epcas5p1.samsung.com> <20240430175014.8276-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430175014.8276-1-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> - Changed functions bio_iov_add_page() and bio_iov_add_zone_append_page() to
>   accept a folio

Those should be separate prep patches.

> - Added change in NVMe driver to use nvme_setup_prp_simple() by ignoring
>   multiples of NVME_CTRL_PAGE_SIZE in offset

This should also be a prep patch.

> - Added change to unpin_user_pages which were added as folios. Also stopped
>   the unpin of pages one by one from __bio_release_pages()(Suggested by
>   Keith)

and this as well.

> @@ -1289,16 +1285,30 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  
>  	for (left = size, i = 0; left > 0; left -= len, i++) {
>  		struct page *page = pages[i];
> +		folio = page_folio(page);

Please keep an empty line after declarations.  But I think you can also
just move the folio declaration here and combine the lines, i.e.

		struct page *page = pages[i];
		struct folio *folio = page_folio(page);

		...

> +		/* See the offset in folio and the size */
> +		folio_offset = (folio_page_idx(folio, page)
> +				<< PAGE_SHIFT) + offset;

Kernel coding style keeps the operators on the previous line, i.e.

		folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
				offset;

> +		size_folio = folio_size(folio);
> +
> +		/* Calculate the length of folio to be added */
> +		len = min_t(size_t, (size_folio - folio_offset), left);

size_folio is only used in this expression, so we can simplify the code
by just removing the variable:

		/* Calculate how much of the folio we're going to add: */
		len = min_t(size_t, folio_size(folio) - folio_offset, left);

> +		/* Skip the pages which got added */
> +		if (bio_flagged(bio, BIO_PAGE_PINNED) && num_pages > 1)
> +			unpin_user_pages(pages + i, num_pages - 1);

The comment doesn't sound quite correct to me: we're not really skipping
the pages, but we are dropping the extra references early here.

>  		if (!is_pci_p2pdma_page(bv.bv_page)) {
> -			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
> +			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1))
> +				+ bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)

Sme comment about overator placement as above.

