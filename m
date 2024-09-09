Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089F17085C
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916662; cv=none; b=jqjSvxYJAlFYNHbmkkxLJCY1ETE55Fkhvl2KdEu3FVFLEg/wtZUsNSABA+s4KAiiIzisaL5iJwNjwfA5VS4I/sCOLe2YkqGtjoJ1natL91DzLrTss6tToCGJOEHcml7CIzy96RzRVhR9BCoJ+fF/Cz1ZSdpYjnCEqZsVWy5dcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916662; c=relaxed/simple;
	bh=ln8mAwOEnCccY2B/9CO/Ksy/6rK+J39QiCf8CUVUSO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKxAcF/rfN1gTCQ3vuyV47oLkRY20GDuIi37CbNZ7wawjGr7Lbn+fB2gk3GBPl8bG7RHR/FWf0i9jh15Nw60TLp2p8tfqGK5RMM5UVBDaFIFjAP9CaNG/eAS6XOaeaJTfPZP6GX7u/9yuX3caex2DM3fZ5/zJGRYPO0mtvH9Guw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b8cPnNn1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b8cPnNn1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UsFCgaS3gZuqrsxC745VNVBEW5smIe2x/ph3GLgDcFs=; b=b8cPnNn1bEIi422t75KNu3b6tM
	0UiSy5B4io+LxFkmS0R8ZKgMDyLTqgy6i7MSJ5P9hFoC+8OCZTFgwak3nIF2xZEKnIS8cinxwX1Ds
	uiuGP/0wM3jmoP9ToSRoC8NVdnjjZDZXM1Apft5YaM+ObwMrvKa4minX1CPtnIAUMl4B4E5zDf8qp
	IxSVwqJu4M+74jYA0y7M36p9DY2I/zVPaNmE0+sLG3eY45qdqnZmK7e7+Fhd5SrwqLCnwrBG0tE3S
	m+3i8S9uqH1O3rh5RQSzQQRF+XcCYW5EzUEYsi9ZTo2GQxZq+Gn/GqR3aKvQaMWx1nGIfClm/BrdX
	O64Z+SWg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1snllR-000000001vS-3xog;
	Mon, 09 Sep 2024 21:17:37 +0000
Date: Mon, 9 Sep 2024 22:17:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v9 2/4] block: introduce folio awareness and add a bigger
 size from folio
Message-ID: <Zt9l8fnnx5_vgEop@casper.infradead.org>
References: <20240830075257.186834-1-kundan.kumar@samsung.com>
 <CGME20240830080052epcas5p459f462c6a2cd2b68c1c28dcfe1ec3ac2@epcas5p4.samsung.com>
 <20240830075257.186834-3-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830075257.186834-3-kundan.kumar@samsung.com>

On Fri, Aug 30, 2024 at 01:22:55PM +0530, Kundan Kumar wrote:
> +++ b/block/bio.c
> @@ -931,7 +931,8 @@ static bool bvec_try_merge_page(struct bio_vec *bv, struct page *page,
>  	if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
>  		return false;
>  
> -	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
> +	*same_page = ((vec_end_addr & PAGE_MASK) == ((page_addr + off) &
> +		     PAGE_MASK));
>  	if (!*same_page) {
>  		if (IS_ENABLED(CONFIG_KMSAN))
>  			return false;

This seems like a completely independent change, which has presumably
only now been noticed as a problem, but really should be in a separate
commit and marked for backporting?

> @@ -1280,9 +1312,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
>  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>  	struct page **pages = (struct page **)bv;
> -	ssize_t size, left;
> -	unsigned len, i = 0;
> -	size_t offset;
> +	ssize_t size;
> +	unsigned int i = 0, num_pages;

I prefer

	unsigned int num_pages, i = 0;

but that's a mild preference.

> @@ -1322,17 +1354,28 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		goto out;
>  	}
>  
> -	for (left = size, i = 0; left > 0; left -= len, i++) {
> +	for (left = size, i = 0; left > 0; left -= len, i += num_pages) {
>  		struct page *page = pages[i];
> +		struct folio *folio = page_folio(page);
> +
> +		folio_offset = ((size_t)folio_page_idx(folio, page) <<
> +			       PAGE_SHIFT) + offset;
> +
> +		len = min_t(size_t, (folio_size(folio) - folio_offset), left);

Does this need to be min_t?  afaict these are all already size_t.

Other than that last one, looks good.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
