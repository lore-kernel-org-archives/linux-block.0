Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD542BE86;
	Mon, 10 Aug 2026 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786382484; cv=none; b=VSiSmpn1N7RUXI2kD9EQW384cQ35dSqAXW7H471a3TZg0aa9mLnsaA39/Tss1JxEtQ3shL9C3TjOhwEEbCgX3jjGabi9EUl6kwmMmG7Kw5AN8MNGZoWuuNqbfWW7pDln0JrxzAVrJkaFTieOIbIYQ7+7mf9Hk55xQpK6Yv2+KH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786382484; c=relaxed/simple;
	bh=JhpdVEbfz/21zcyUV3J8BF/mD6Jj6WsaUyzmLRX0Sfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZh084FGZpsvtHx9WWNByCE4tT1SnTYETv5wRT8Lw1loKfNBPJxrjZS+JNf35Bf2jSEVLaGzNLTnDef9LPOta0CGfAm5mQYY7SsKQfeVpv3I48pk8I9rxwAv4h2r2Sz+xxm52FW9f2ezwpZA1AW4hodNeoOZqeHvbTB4VES9ldY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w4/MCNU5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w4/MCNU5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cy7OYoW3PJUmnKukrwcZFQ3hLQc7isy+xcCx8NMp1l8=; b=w4/MCNU5K681S4PdttIQArlltd
	aplhwsp6XCU4p2gSmBzQF63vxrK4SGZ9xboYcrehjzg4Zr3lNxMHnAh0pJ0dg4kHYPhyd2NSBYLJD
	lZ8DB176sohHR4/o2j152C12lB5eVjKKA8KsNzmqLL2eOpSYJ36jGbd2dNJB9CE5puTWOt1qH+lc9
	YarURFLhH+UEkLQ/d1iU53sByUUn4us6p3VCMUzCh6/mtbn9U6LFvLJpg/+TJu9+BmsC04586zYRK
	WOakoINSy5YfcXOZ/OZP6tDomANg7HvVvbMmQNq0UDAaig+srKF/YjsKaSG2KN9JJbYYYdGZXa4XG
	JMbvD+IQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTgZ-0000000CVLf-1MO6;
	Mon, 10 Aug 2026 17:21:15 +0000
Date: Mon, 10 Aug 2026 10:21:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 2/3] mm: support fallible mempool_alloc_bulk()
Message-ID: <anoIiy0V-m-05yZc@infradead.org>
References: <20260806221031.79050-1-ebiggers@kernel.org>
 <20260806221031.79050-3-ebiggers@kernel.org>
 <ann1i5VjTmgChjs7@infradead.org>
 <20260810161404.GA1930@sol>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810161404.GA1930@sol>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 10, 2026 at 09:14:04AM -0700, Eric Biggers wrote:
> On Mon, Aug 10, 2026 at 09:00:11AM -0700, Christoph Hellwig wrote:
> > On Thu, Aug 06, 2026 at 03:10:30PM -0700, Eric Biggers wrote:
> > > To fix a deadlock, blk-crypto-fallback needs to be able to make fallible
> > > mempool_alloc_bulk() allocations.
> > 
> > It doesn't.  fallible mempool allocations are a concept that doesn't
> > make much sense.  Please just go straight to the backing page allocator
> > instead for callers that do not need the mempool guarantees.
> 
> It does make sense.  When alloc_pages_bulk() doesn't completely succeed,
> there still might be pages available in the mempool.

But they should not go to a caller that does not need the mempool.

> blk_crypto_alloc_enc_bio() should try to take them before falling back
> to scheduling the rescuer kworker.  The rescuer encounters scheduling
> overhead and is single-threaded, so it's slow and should be used only
> when absolutely necessary.

No, it should just try a regular non-bulk alloc_pages (and eventually
alloc_pages_bulk should do that fallback for the callers, but that's
a separate discussion).

