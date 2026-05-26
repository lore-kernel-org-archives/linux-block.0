Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368FF3C8C7C;
	Tue, 26 May 2026 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806229; cv=none; b=W/Y2iKQ1Qi7cMrvXuf2LLsP+amFAWDzosaS7zGdOrH6WB2KJha1273B2BsnuqMFVVm+3H3iSJ/haT9JL5un6R7xbgj1SbTdkj9WxUBPcr1euvZBX6zIiyiEJaUb27EqGuoflaKxPdoUbfB6TzdRN+Hh0VSqnC+jY2CNQ3CHv4Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806229; c=relaxed/simple;
	bh=YxMbe5ZIG97R6Ntn+iqfOvfn6906Aw7Dic06DcGIIqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9Vf/bW/9rgf/nWIaQRQWTm3QzcOWk2dGkhnfnqOy5BJ7Vb2VgYLq/plUhKVFba/xMUkHrqFDn+EkhG/B5kw8WCyDiRuG4QKttCxsW/ITZ1gCgyD/viot+hm4gVNDlPc9KNKbdeEkm1+T1cAw+mLcdErBr0V61B6q41D842tHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gOI0vew9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gOI0vew9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bJaZ+OE0ZGmNTJCjsYLk6Pu4+0UCvjIDTJFLwXjyNL4=; b=gOI0vew9WF6yswl1zd53yvsYHt
	D3Vjm3LzNUc9byMS603ZNDkea548xyV8Oz9LZUAtwQJwZgExb8792DXfNFAhIZlANzn5/uD+kCyHM
	E+zqVWUXXH3K4s3oGjQ39g2kSndqH9z8xchUaZu2yxxOKjaDIW1JBBe2ln+SqSEcLZj1uflWbhL0m
	Av2QyEngm71fvI+SKwsmcttdl/T5m/bYU9ZDFz2llYcWOKgh7OedO+2vwvqLePzRzizjboxGu9ac5
	H44X8bfjfLaR8feSgjAxM+ph90jTnlmWkdDH9fCT5dS8h4qKj1X68fDf9Fa3W7f2pkiJSmwf3V1Qw
	kd8Qz7QQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRstz-00000001AVM-15vB;
	Tue, 26 May 2026 14:37:03 +0000
Date: Tue, 26 May 2026 15:37:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
Message-ID: <ahWwD0eqj3cUgaKn@casper.infradead.org>
References: <20260520-block-v1-1-6463dc2cf042@kernel.org>
 <ahPnX-CwVgK-9chp@infradead.org>
 <ahPxmSqT4Y4jcAbQ@kernel.org>
 <ahP3R2nH8-bHMVf0@infradead.org>
 <ahQX_JCgS9JWIhY-@kernel.org>
 <1dea9df9-18c2-46f5-bf47-abb3f088574b@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dea9df9-18c2-46f5-bf47-abb3f088574b@suse.com>

On Tue, May 26, 2026 at 02:07:36PM +0200, Vlastimil Babka wrote:
> The main reasons for switching AFAIU would be related with the
> folio/memdesc conversions? If one needs just a kernel memory buffer,
> kmalloc() it is, even if it happens to be page size. Page allocator
> should be only used if you need e.g. the refcounting or anything else
> that struct page provides. But then in some cases the memdesc conversion
> would need adjustments at some point. With kmalloc() we can forget about
> this user.

No, I think this is unrelated to memdescs.

I've seen a few people say slightly wrong things about
folios/pages/memdescs recently, so let me try to clarify the end state.

I do not intend to get rid of the ability to allocate a bare page of
memory with something like alloc_pages() or get_free_page().  It's
just that the struct page associated with it will contain far less
information (because it's smaller).

https://kernelnewbies.org/MatthewWilcox/Memdescs has a bit more
information, but to distill it:

You get a u64 worth of data (technically one per page, but if you
allocate multiple pages, they're all going to be the same).
Bits 0-3 will be type 0 (to indicate that it has no memdesc).  
Bits 4-10 will be subtype 2 (to indicate no information about owner).
Bit 11 will be clear to indicate that this page should not be mappable
to userspace.
Bits 12-17 will store the allocation order.
The top few bits will encode zone/node/section like page->flags
do today.

That doesn't leave many free bits for the user, but that's OK because
most allocations don't actually need any bits in struct page.  If you do
want something like a refcount or list_head, see the "Managed memory"
section on that page.  If you actually want a full-fat folio, well,
allocate a folio, not a page.
