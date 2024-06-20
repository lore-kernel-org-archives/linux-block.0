Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB03639
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 03:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718855263; cv=none; b=M9jm4MKWG4Uy8a/6WEapooDaNKQmwMJK3H4FMCtZ5OvP3MQ0t8K3GRMd2NaDAuLDRfpFNKvL6N9b+g86LRN26jRlSFCnXs+5jl2iNicCHdSlej2eGNMHX6arZSwjCOGdgp/MK8dVvlGLGfLS8cJxo6o2L9Z7l7HdI53BpJ9LL+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718855263; c=relaxed/simple;
	bh=+YUp07J2DYCdj3ruz4guYSLwb+lqC6NAEd1FcCpdvFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5osVm6mz0jR+QAhoD3aG/VeoMtpUC9oDOGawpRkpwpzmeFpxM3BIy3AlxXgbh0qu2IsOXb+BVlSErMbQo9J+VDD7ELTajdHSwm11ZJ+YycE4TK1W6J69buN7AeeFr0ZaXxgmotfZfMjhy+TX9QtkwIZxLhsgYCQJD/+PEQV2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sdzUsGI5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sdzUsGI5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gUwGlgxiCPDT8MYzK6rxluGFfBSAzZkplULLRijn/x0=; b=sdzUsGI5atlro0MHcQFGapEFJu
	1PLgBeNT+WRGIEAZMddbSscHGsttxLHUSB1yquRndN6z8YUvmbw37VRTsYz0WL8qOjfbvFbPGHeTL
	SpgB24JBOJfKwsBgNWmLGvJ4WSd5M66/woPrDcX3WE24O6YcAfjnB8Mvy8ZV/GoqqIOxDh0hbHlIe
	nH3ntaE/bSstrHVjql7ZUdgOk0Gb4pQrZD+tYoGxP904S8Lq6puxXZAwBsNW/2Z/vzzO2b83M1Iia
	uVqHv/3YzhpZ+UEoajtP/HZaroi3QOqXBHOqjw+AyqwLud0UJSngGX9NDJrffdOYJUEYvQ7bCnQmI
	buGiTwmg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK8lq-00000005Ywa-1Nwj;
	Thu, 20 Jun 2024 03:47:34 +0000
Date: Thu, 20 Jun 2024 04:47:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v5 1/3] block: Added folio-lized version of
 bio_add_hw_page()
Message-ID: <ZnOmVn6S2RNLDFWz@casper.infradead.org>
References: <20240619023420.34527-1-kundan.kumar@samsung.com>
 <CGME20240619024146epcas5p15357534fb7410c212743162b351e27e8@epcas5p1.samsung.com>
 <20240619023420.34527-2-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619023420.34527-2-kundan.kumar@samsung.com>

On Wed, Jun 19, 2024 at 08:04:18AM +0530, Kundan Kumar wrote:
>  /**
> - * bio_add_hw_page - attempt to add a page to a bio with hw constraints
> + * bio_add_hw_page - a wrapper around function bio_add_hw_folio

No.  You haven't changed what this function does, merely how it is
implemented.  The reader of the API documentation doesn't care about the
implementation, they just need to know what it does.

>   * @q: the target queue
>   * @bio: destination bio
>   * @page: page to add
> @@ -972,13 +972,35 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
>   * @offset: vec entry offset
>   * @max_sectors: maximum number of sectors that can be added
>   * @same_page: return if the segment has been merged inside the same page
> - *
> - * Add a page to a bio while respecting the hardware max_sectors, max_segment
> - * and gap limitations.

Likewise.

> +/**
> + * bio_add_hw_folio - attempt to add a folio to a bio with hw constraints
> + * @q: the target queue
> + * @bio: destination bio
> + * @folio: folio to add
> + * @len: vec entry length
> + * @offset: vec entry offset in the folio
> + * @max_sectors: maximum number of sectors that can be added
> + * @same_page: return if the segment has been merged inside the same page

... page?

> + * Add a folio to a bio while respecting the hardware max_sectors, max_segment
> + * and gap limitations.
> + */
> +int bio_add_hw_folio(struct request_queue *q, struct bio *bio,
> +               struct folio *folio, unsigned int len, unsigned int offset,

size_t for both of these parameters.  We're dangerously close to
overflowing unsigned int (arm64 gets to 512MB folios, which is only 3
bits from 4GB).

