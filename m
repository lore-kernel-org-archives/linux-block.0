Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA2442883D;
	Mon, 10 Aug 2026 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386139; cv=none; b=OJ5S2jpNqNdf2GCBWHTVRTzOl6aj4Azqs0jOCQWYX6DApJqOGDkq/iLsttpZb03/5qlmIo5STunjtOT4HOUY1ran6IpwrZV+8SjH0tECJcR7iEB22ltzlHoMgDx7DpLx2EKeeBKR5ZxqnAL+uHkdm594jyJ97b8tSkNYzqP/6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386139; c=relaxed/simple;
	bh=FSFgJW040iHvIE2Lxmb5vpi9No/WXEOZRwGy2/M5yAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY2qKDBSaZWRv5IRQIESEZVleW+rKjesCYxYCvqTRVRHJOsj/JP22Yezd3yjCrKnj6Qyvw/xczQqtkbfW9LKFrU0WmPPH4gAVBrwjCO1mxkvPWBozelJQWl1bRyDk6N8USEvi8HWXyLzOC0+RxA6Bp+an7GlO4+zlj9AlNdZmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/81SzEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/81SzEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABF91F000E9;
	Mon, 10 Aug 2026 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786386137;
	bh=idH41Udq/zUejz1xnxNcUng7Sk0U5FMVLyHKXUD83Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a/81SzEubaTt/dIFO2hAwaZS5EZOaqle/2CQj/skmyX8V6jGvrKP834iCaiDLMUXK
	 GlkecvwKjqnyPY+XdZw7a05hhUJ1o2DmZ10/gXhnwS9e9LYWjvV6l52qeIUHEvPIJN
	 BFZtTFTqSEjuni/b1afAbm+Aep2GMrMPQSoRmZtpuZ/YP8kDj2DiOKXgNjx7ikxlbU
	 rZX/agd/GK8Wl7VKMkmx+zC05A8NQZuKuQ5EciWcqpk3nyucOXVdeQ2gOLoXhlCoxy
	 TgtAWhHIYkPWmE5oS3wLamysaekGTDQXxepiD8SjCm4skpbcC3ceZti0k9keVX0yjr
	 1RD3i4HIH2lPg==
Date: Mon, 10 Aug 2026 18:22:15 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 2/3] mm: support fallible mempool_alloc_bulk()
Message-ID: <20260810182215.GA270444@google.com>
References: <20260806221031.79050-1-ebiggers@kernel.org>
 <20260806221031.79050-3-ebiggers@kernel.org>
 <ann1i5VjTmgChjs7@infradead.org>
 <20260810161404.GA1930@sol>
 <anoIiy0V-m-05yZc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anoIiy0V-m-05yZc@infradead.org>

On Mon, Aug 10, 2026 at 10:21:15AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 10, 2026 at 09:14:04AM -0700, Eric Biggers wrote:
> > On Mon, Aug 10, 2026 at 09:00:11AM -0700, Christoph Hellwig wrote:
> > > On Thu, Aug 06, 2026 at 03:10:30PM -0700, Eric Biggers wrote:
> > > > To fix a deadlock, blk-crypto-fallback needs to be able to make fallible
> > > > mempool_alloc_bulk() allocations.
> > > 
> > > It doesn't.  fallible mempool allocations are a concept that doesn't
> > > make much sense.  Please just go straight to the backing page allocator
> > > instead for callers that do not need the mempool guarantees.
> > 
> > It does make sense.  When alloc_pages_bulk() doesn't completely succeed,
> > there still might be pages available in the mempool.
> 
> But they should not go to a caller that does not need the mempool.

The caller does need the mempool.

> > blk_crypto_alloc_enc_bio() should try to take them before falling back
> > to scheduling the rescuer kworker.  The rescuer encounters scheduling
> > overhead and is single-threaded, so it's slow and should be used only
> > when absolutely necessary.
> 
> No, it should just try a regular non-bulk alloc_pages (and eventually
> alloc_pages_bulk should do that fallback for the callers, but that's
> a separate discussion).

It already does that.  blk_crypto_alloc_enc_bio() first calls
alloc_pages_bulk().  If it doesn't completely succeed, it calls
mempool_alloc_bulk() to get the rest.  That itself tries regular
allocations again before actually using the mempool.  It needs a
guaranteed allocation, so it needs the mempool.

Now, as I explained in this patchset, whether this code can wait forever
for the mempool actually depends on whether it's a recursive bio
submission or not.  If it is, then it cannot wait, but ultimately it
does still need to use the mempool to get a guaranteed allocation.

Falling back to the rescuer kthread (which can wait on the mempool)
solves that.  But before taking that slow fallback, it's much more
efficient to check the mempool directly first, since pages may be
available there (and in fact it's fairly likely that they will be, since
regular allocations are always used first).  The whole point of the
mempool is that it can be used when the regular allocation fails.

This is also the only caller of mempool_alloc_bulk().  So I'm kind of
confused why it would not be allowed to implement the behavior that is
desired here, especially when the non-bulk API offers it already.

- Eric
