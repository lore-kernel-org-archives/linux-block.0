Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A162218C326
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916988; cv=none; b=dNgoVtWWXnVSGLEL1Pe+wby/4lo8dQdWnLXscu3GzBnMVYXVuC3TzHt8JXqmCbkbQCUcX4lUKVDoZqwXidIn2R6g268X+2nGGa5s5jpZsCb+Fg2DMZHBs7KxvNCDhiQi9WH6X1mM1g8HQ2R0TDKcpObcg5KOppNoN8wLqGzd/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916988; c=relaxed/simple;
	bh=g4/32dm7EE0ZTs3TpOXozSqoVXNsUZUGIBXAVEI+T7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk8FRKMTXdtwpODU1hZLuXjZNeTllW2UFFkAxebSG9f0LIAzATknttKOunRLL5NV1eTGCx970nO+FF7Ss1dw82c95p+p4pMkwd+UJEIkJBNy8MKdw9AarKTV/35c7Ow4LGDl3BomPnc5iUiJ27BP5pWF/mBhJlDP72sKIQ54Kgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SVKD1wtz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SVKD1wtz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kwnVVTE0AjDywWHzVpGP2m1oH4N2GOZjtHnQZFX8np4=; b=SVKD1wtzmXRhoFCV4gDGfxMrhM
	bQkxhHUx7GL1nAXzzVZwQj3m2jydcc+PAxD2KkFyCmXw5pbInI/636LkNxF5r2HSKuXtHDEzu/1V/
	9MXRL9qeEWSWK/x7UYKs/4MevN4AOtrAniZWwl2YxCDW4Y6d0Rn2teMLgUZZZ9ks9aQWazIMo+FvP
	BO/T4ZQLkqM5ALT80tE8XLAHnQ9uP+eZgsdPNlBEVn5pkGba/2FdURmMOi5cLixFBc9LxOYhwdpCR
	7vP858J9Ooa8NUw8HKGc1wmZ6ra+GotjvnOKuKCVdm1Vka21b64ySHFBiEgVYK+AnA0ZHX7s7SQx3
	ETIMpKAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1snlqh-000000005DC-3HBA;
	Mon, 09 Sep 2024 21:23:03 +0000
Date: Mon, 9 Sep 2024 22:23:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v9 2/4] block: introduce folio awareness and add a bigger
 size from folio
Message-ID: <Zt9nN3geJKjFfZAH@casper.infradead.org>
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
> @@ -1237,30 +1238,61 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
>  
>  	if (bio->bi_vcnt > 0 &&
>  	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
> -				page, len, offset, &same_page)) {
> +				folio_page(folio, 0), len, offset,
> +				&same_page)) {
>  		bio->bi_iter.bi_size += len;
>  		if (same_page)
> -			bio_release_page(bio, page);
> +			bio_release_page(bio, folio_page(folio, 0));

Shouldn't there be a subsequent patch that converts this to
		if (same_page && bio_flagged(bio, BIO_PAGE_PINNED))
			unpin_user_folio(folio, 1)

... also does this mean that 'same_page' is misnamed and it should
really be 'same_folio', in which case, is the bugfix in patch 1 correct?

