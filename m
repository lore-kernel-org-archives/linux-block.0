Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845F4D8C3
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556806; cv=none; b=Jx1L0RhNr4lRpP8hSZv/AXpv7Gf/UGKaMp6kOYHQkIowe05NQHizhzL1dHBJuIcYao42NpCOhrLazowJK7b/+ws1nQCcdJOdG/moOwXSRxHpA+T1UdtaTMKJTnLhHCJzuH6rO/ERT8jS0ORWi+CzrBDM+sPIGW1uzW8zOmg7yi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556806; c=relaxed/simple;
	bh=GEf0iKA6Brq4IvXPicxKc6sBxd1oGn1ERYyWhIrj0I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cquO3E7OG/3YgmCSOSNprs7PqQWPIBj2xCtrbuFKrZq5Pwe8eHVw3KcOtTQSNzA4kvLr8+Aje234LReYcJkTvOf5FFFW0qa+5b6Fvs77DhcCIJP939DXaZkZF+qJh6J9kpiFiEesR1Xy3ICmiyoey8QFDYuaaZxFRBP7ThXcPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 34FCF68BFE; Fri, 28 Jun 2024 08:40:00 +0200 (CEST)
Date: Fri, 28 Jun 2024 08:40:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v6 1/3] block: Added folio-lized version of
 bio_add_hw_page()
Message-ID: <20240628064000.GA27279@lst.de>
References: <20240627104552.11177-1-kundan.kumar@samsung.com> <CGME20240627105404epcas5p334c7c5bd3aee98b58e60ac1008c863be@epcas5p3.samsung.com> <20240627104552.11177-2-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627104552.11177-2-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 27, 2024 at 04:15:50PM +0530, Kundan Kumar wrote:
> Added new bio_add_hw_folio() function. This is a prep patch.
> 
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> ---
>  block/bio.c | 33 ++++++++++++++++++++++++++++-----
>  block/blk.h |  4 ++++
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index e9e809a63c59..6c2db8317ae5 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -979,6 +979,31 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
>  int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>  		struct page *page, unsigned int len, unsigned int offset,
>  		unsigned int max_sectors, bool *same_page)
> +{
> +	struct folio *folio = page_folio(page);
> +	size_t folio_offset = (folio_page_idx(folio, page) << PAGE_SHIFT) +
> +			       offset;

Probably purely subjective, but I find this more readable:

	size_t folio_offset =
		(folio_page_idx(folio, page) << PAGE_SHIFT) + offset;

> +	return bio_add_hw_folio(q, bio, folio, len, folio_offset, max_sectors,
> +				same_page);

... or just open code it here:

	return bio_add_hw_folio(q, bio, folio, len,
			(folio_page_idx(folio, page) << PAGE_SHIFT) + offset,
			max_sectors, same_page);

> +		if (bvec_try_merge_hw_page(q, bv, folio_page(folio, 0), len,
> +					   offset, same_page)) {

Eventually bvec_try_merge_hw_page should be folio-ized as well.  But
we can do this separately if you don't want to take it on.
