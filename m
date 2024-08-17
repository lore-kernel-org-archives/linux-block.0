Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847E63D
	for <linux-block@vger.kernel.org>; Sat, 17 Aug 2024 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723868602; cv=none; b=k+oHYSztqy4utgp0O7mRY3t9D3euM6qYQ6NwXMFTXchkbDI/D4+Nr6nXZk/Lt4mfV4beNWwt0Fey/J8u7O7yG3Rb13V682s0d5Kvy2YhHLPPicn6DjCawWoAJmqXNEUTCCUQyDQ2y1ZrrnCVxYL9XF7I2VvQ98dcuKruDc1g2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723868602; c=relaxed/simple;
	bh=pro5b5evHIHbIp1CwOnK0gkdnPJrXWqWtB68oNqffAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8w9KM8z67N+LP5YYzgGpvSsabdF8r/4E0DQG3jxY5wap+P/OfL28ybKMGMrvDYEC+HKXP1N6GqyWcPrCJJmqKMqWYgZU1JIIuSC5UF8diN998KReVJ/koV5Hw+2XmR9+DjtLFgUY3aWr7mIbB0hx/dQ5FTGA/D5SQByqTT9JVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EMzyzSPn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EMzyzSPn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xWrN7vg31b7LfTSJaFZpAZiJcYO5xql6YZydvTJSxsw=; b=EMzyzSPnllTpRs9fp2lGHyGurn
	NpmAjSHN4BAsfV+OvI7s7Sks6XTk0+/djsE6QQqjYFrrQ24Q8VVW4Ckn3TghWpZ4wmjPbg+LtYRKE
	2ObXBkyqG5JO5p9othyrwLqRoIIz79QiodQ+VYWp6q0DA1D4rbZIbLD9o4Fj3gLy/kdXrYsSOykJn
	ikCr5lfcLKS9xc5VgYxBeMJJYcMMUtgpiq9HwppNVQ4X37S56+4GY2JDftvNXmp6wR4AbsEcpEuNZ
	5TPVJ/B95v6Xxrj7RZVgAPDAw15GFjWxOZvp0QIblYedI+WadDNbDYYZYjHp++aBaPNEh52+4H62g
	Y98Yn/mQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sfAyA-00000004QhH-1gWE;
	Sat, 17 Aug 2024 04:23:14 +0000
Date: Sat, 17 Aug 2024 05:23:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v8 1/5] block: Added folio-ized version of
 bvec_try_merge_hw_page()
Message-ID: <ZsAlsjZeNmsBI6J0@casper.infradead.org>
References: <20240711050750.17792-1-kundan.kumar@samsung.com>
 <CGME20240711051529epcas5p1aaf694dfa65859b8a32bdffce5239bf6@epcas5p1.samsung.com>
 <20240711050750.17792-2-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711050750.17792-2-kundan.kumar@samsung.com>

On Thu, Jul 11, 2024 at 10:37:46AM +0530, Kundan Kumar wrote:
> -bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
> -		struct page *page, unsigned len, unsigned offset,
> +bool bvec_try_merge_hw_folio(struct request_queue *q, struct bio_vec *bv,
> +		struct folio *folio, size_t len, size_t offset,
>  		bool *same_page)
>  {
> +	struct page *page = folio_page(folio, 0);
>  	unsigned long mask = queue_segment_boundary(q);
>  	phys_addr_t addr1 = bvec_phys(bv);
>  	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
[...]
> +bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
> +		struct page *page, unsigned int len, unsigned int offset,
> +		bool *same_page)
> +{
> +	struct folio *folio = page_folio(page);
> +
> +	return bvec_try_merge_hw_folio(q, bv, folio, len,
> +			((size_t)folio_page_idx(folio, page) << PAGE_SHIFT) +
> +			offset, same_page);
> +}

This is the wrong way to do it.  bio_add_folio() does it correctly
by being a wrapper around bio_add_page().

The reason is that in the future, not all pages will belong to folios.
For those pages, page_folio() will return NULL, and this will crash.
