Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B66241E7
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 04:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649803; cv=none; b=QpMzqhCWUUEDdvqnVrTo0RsroopM5HISb1ryVNH7RxrqzeXmo9t0vkO/Q6eOr+FAbSi/tbQ7c+McFRDMd0UqlKU/dvwt8ckOpdDueyIpwQsofTM8R9eJKP4mtF12vuELg04PxWpKOALk0iqdyiozDmsQ25RPrGlc1GDG7J2TA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649803; c=relaxed/simple;
	bh=oBRMxqJanFEj6+hS8KBUn+cfSmGAVUzuQyaadmU8254=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2NodPxtraUM/5vMBXOT4oN6NIBZVKVf3W80TYmfzyrslZl4Xi+U1YmabjDmzOZnArXNwaN+cdKv6XuzC3GrAVoWY+KaJlTNb9dgFwIOGJGvKLZRE5tJ+RT+nEzR2pl9Ljh58mKLLnCTqpa8EiPl7DYfxSojMOhajGhkCk2REJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7870368CFE; Thu,  6 Jun 2024 06:56:38 +0200 (CEST)
Date: Thu, 6 Jun 2024 06:56:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] block: add folio awareness instead of looping
 through pages
Message-ID: <20240606045638.GF8395@lst.de>
References: <20240605092455.20435-1-kundan.kumar@samsung.com> <CGME20240605093225epcas5p335664b9185c99a8fe1d661227d3f4f1a@epcas5p3.samsung.com> <20240605092455.20435-2-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605092455.20435-2-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> @@ -1301,15 +1301,49 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  
>  	for (left = size, i = 0; left > 0; left -= len, i++) {
>  		struct page *page = pages[i];
> +		struct folio *folio = page_folio(page);
> +
> +		/* Calculate the offset of page in folio */
> +		folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
> +				offset;
> +
> +		len = min_t(size_t, (folio_size(folio) - folio_offset), left);
> +
> +		num_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
> +
> +		if (num_pages > 1) {

I still hate having this logic in the block layer.  Even if it is just
a dumb wrapper with the same logic as here I'd much prefer to have
a iov_iter_extract_folios, which can then shift down into a
pin_user_folios_fast and into the MM slowly rather than adding this
logic to the caller.

