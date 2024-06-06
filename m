Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255D3B1BC
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 04:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649932; cv=none; b=k/ttIi+3tULtS1SePXCtZB5kLYwurUfuQrnHWvCwzmYxGUH38nPkkOCqNe25gdo/RLR+0XKU4JoFmteWLd3y518VAEMsfRR1gStxwAPWBTuRvPO2mGAX60KKV3XeMN+UQCGBM1+Mxff/6NgRfzk4kgXA9+KI5OWiTibewoCux/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649932; c=relaxed/simple;
	bh=c1pw0WJ81/bFhxklufgoLNdApKk9sRfJc9UnMJb8ARg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix5qv4KsLyIFH0RQZfZ4jaaQHonDcI7MYv/776OdKKfzFCpX+kO1ewIOmZ6KLVWzYDJdGQ7GltLvSe/M6p1eqMY1ICHpJhXJxuzNGgsvYhXCmI03DeIgYyHFFQgMCcT9zlou7q9nUngDfLSOPMdJYsUfQHuryKO/BtyzFNEirDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6209368CFE; Thu,  6 Jun 2024 06:58:47 +0200 (CEST)
Date: Thu, 6 Jun 2024 06:58:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, linux-block@vger.kernel.org, joshi.k@samsung.com,
	mcgrof@kernel.org, anuj20.g@samsung.com, nj.shetty@samsung.com,
	c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 2/2] block: unpin user pages belonging to a folio
Message-ID: <20240606045847.GG8395@lst.de>
References: <20240605092455.20435-1-kundan.kumar@samsung.com> <CGME20240605093234epcas5p151b3b39b2f2e1567c6e4ceae6130c6b9@epcas5p1.samsung.com> <20240605092455.20435-3-kundan.kumar@samsung.com> <ZmDXAxGm01XayBSn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmDXAxGm01XayBSn@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 05, 2024 at 10:22:11PM +0100, Matthew Wilcox wrote:
> Why can't we have ...
> 
> 		bio_release_folio(bio, fi.folio, nr_pages);
> 
> which is implemented as:
> 
> static inline void bio_release_page(struct bio *bio, struct folio *folio, unsigned long nr_pages)
> {
> 	if (bio_flagged(bio, BIO_PAGE_PINNED))
> 		gup_put_folio(folio, nr_pages, FOLL_PIN);
> }
> 
> Sure, we'd need to make gup_put_folio() unstatic, but this seems far
> more sensible.

Yes.  Although maybe a unpin_user_folio wrapper that hides the FOLL_PIN
which we're trying to keep private would be the slightly nicer variant.
