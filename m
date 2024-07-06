Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786B20DD2
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720252911; cv=none; b=QQj/mmkApubo41d32V8+xA7xt1dh6QpebwbxNyO12AxNM9rCLHQKzA7NJD2jMQK5tbMm5DyE5Ixo+8L4LuTmjEPwvAB7L9HDQNXcxOq9hakfOKisDaUtSWz0tYkmGnNjosySPaJWGBH/juAtPO3rlcm9FRzqI1RMo6u4lqKVDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720252911; c=relaxed/simple;
	bh=uP2dxLh0OvzJd0bDu6Cgr8w8/SiLvSqHT1jrYbATKuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+11tpfCHJ6eYtcnIZVnBrbxpOQ7nx46lPhac3z5LK/yeEPzPVoFnGysoeuq/VCAs3ce4OIy15lRyDK7bz3jMF7cUmZFs6/1rblOVlTKfpDLmD0iV+SBG3AsUYhqd9xcY+/0YC2B4N62ikexMedW1qv60UqNS27gIfdbiFWfFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 04B9068AA6; Sat,  6 Jul 2024 10:01:46 +0200 (CEST)
Date: Sat, 6 Jul 2024 10:01:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v7 1/4] block: Added folio-lized version of
 bvec_try_merge_hw_page()
Message-ID: <20240706080145.GA15451@lst.de>
References: <20240704070357.1993-1-kundan.kumar@samsung.com> <CGME20240704071122epcas5p12a52967e486a69375ee77db86f2594a0@epcas5p1.samsung.com> <20240704070357.1993-2-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704070357.1993-2-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I'd say folio-ized, in the subject (also for the next patch), but I'm not
a native speaker and this is all pretty odd terminology anyway..

> index e9e809a63c59..c10f5fa0ba27 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -952,6 +952,23 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
>  		struct page *page, unsigned len, unsigned offset,
>  		bool *same_page)
>  {
> +	struct folio *folio = page_folio(page);
> +
> +	return bvec_try_merge_hw_folio(q, bv, folio, len,
> +			((size_t)folio_page_idx(folio, page) << PAGE_SHIFT) +
> +			offset, same_page);
> +}
> +
> +/*
> + * Try to merge a folio into a segment, while obeying the hardware segment
> + * size limit.  This is not for normal read/write bios, but for passthrough
> + * or Zone Append operations that we can't split.
> + */
> +bool bvec_try_merge_hw_folio(struct request_queue *q, struct bio_vec *bv,
> +		struct folio *folio, size_t len, size_t offset,
> +		bool *same_page)

Placing the wrapper above the guts of the implementation is a bit odd.
Can you reorder these?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
