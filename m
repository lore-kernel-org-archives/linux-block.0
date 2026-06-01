Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03403E172F
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333823; cv=none; b=CmywRadelyuteBHm4Ry7aOHFqWpk2vEhLYpvx9j0T08SIhtDIY5JtJyPnM6D6XypcMR3E3DDGH/LFSEox34XdbIKjifnM1lvK1kjRdbcit1c/sc5xg5VUwxQOWVw3DEzt0OgRuMyY6hrxWdxvf+wh5Ex4GiS1mDX1fiBSM2ZpKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333823; c=relaxed/simple;
	bh=b6egYJT4oZVxlemiFQImQn69udxJzInQv9n8wbEyHTU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eE+OlHBcPgeNiccrkc/7R88qx5BJKKl3jC9Z2Z8HkWs3+focFrTJ5oIp1elNdff6WWGs8ULurkIZCGcW5fe5ARTsWpPEQlWWkH9pLMQEsqLHLQBzCvHEmTWtJBf4aEJdlTrk+AYHzhbDD1AUFSPWJxLPcw2o4TfD9cHgcsss5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VsRMuo1T; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VsRMuo1T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=wuwhtsZvxtY5jXpZxPPq8x6oexBxcLSzun5iMte6UC4=; b=VsRMuo1TXRsso3tGC20B7I5bar
	jMyxtqAf6qUA/bNZVxS8Yg6Te4ld5t8rkP6VBTkdf51pUySHwOG7LOssV3Bv7mVJX2vW2SuBMjIF2
	FDnvG2bjaskpH1SXWPVDVgKEc5SckpIShTFo7WW/WKtbAIYwmG6FC2cdUpKNYR3O5RxcceG8JXavr
	/loluxgqrYXS+Ao/Y6pJ5FEYZyJ8mkxwPqhCTLpS1EoaPrGGnZzMJPWExd5nQyu6Oqe0BawEF4JZH
	3Y/WSFR6Q0qFYVCXMnbniio52UZhB70FEIHIbhxtu9BPh5O5jrCP/wpXkfZLNEx1bleMmjYSXS/0P
	y/LUJKsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU69a-00000000Se3-2HZZ;
	Mon, 01 Jun 2026 17:10:18 +0000
Date: Mon, 1 Jun 2026 18:10:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: bio_copy_from_iter
Message-ID: <ah28-oyillEaOrm1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'd like to remove copy_page_to_iter() (and only have
copy_folio_to_iter()).  That led me to looking at bio_copy_to_iter().
At first glance, switching it to bio_for_each_folio_all() makes a lot of
sense -- if there are large folios involved, then we can copy an entire
folio at a time instead of a page.

But what I can't prove to my satisfaction is that every bio passed to
bio_copy_to_iter() necessarily contains folios.  That's not currently
necessary, but will become necessary in the future. [1].

But I started thinking about what we could/should do in the future
when bvecs refer only to physical addresses and not pages.  What we'll
have is a list of (phys, len) tuples and need to copy that to an iter.
We don't have an API for that today.  Should we add:

copy_phys_to_iter(phys_addr_t phys, size_t len, struct iov_iter *i);

We arguably get even more benefit by doing this as we'd no longer break the
bio up into pages or folios, but can keep the contiguous chunks.  Not that
optimising bio_uncopy_user() is going to be a particularly big win,
but this API might be useful in places that are more performance sensitive.

[1] I believe all these bvecs are constructed using
blk_rq_map_user_iov() which can end up calling bio_add_vmalloc(),
and vmalloc pages will not be folios.
