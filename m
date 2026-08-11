Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0D3D9538;
	Tue, 11 Aug 2026 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479223; cv=none; b=ucyOIbFdqL+aW7glc4vr2I/9l/JC0kYYP4Iv6kZx2H2ISN23W5uQ0VRnqir8pdUO7HkvpP59j5wyBNZiYTpY/JDfnuAEZ0gn5YsiUGmvWxmS2wj9AutO0k+fP6sbBsScdn9DExJ4uleWjEFLIp3RW29r49GJBM5/R2PN2X6UnqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479223; c=relaxed/simple;
	bh=bq7lSt327yN6cPego3JXagRu6oA3DciB03eeo4BSRqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU4OQYoX5MlJmseNPDXq1Ws6kXjzf2BkILW8GVKWVdfrFPr2IHgBRmpQJEugCpvdLhYREn16bjfU7JS01aitg+DigOo2xpPcl+E22/ebc7vDN+mqEKQ+8Ernynfp6xdrFJjfBgTLO7Wg/6VFJJmqa/hx1+kWW8QX3Av1IkXD2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a066R9N2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a066R9N2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6YbFpOmvNf504sQf2QihriBMoey+d8zmHbwInFB/oZQ=; b=a066R9N27OIM70SnmDCVlfwHs2
	rp6/CjIfME+lq/Ia17LZWz0DPG2aQd4osZzsfh7lVX8KAHTxuZmNpwJN22+GUNTvvmLyG33knvKbM
	MMO7XW0ko3H0+JYBjpl7KiSy8lfZrYft/YosON0EcQDPhbhnYDmHgieQdiOVTJWgjVLY2NFYCcYu2
	0d1AU4mwSZ7yM3nXMw9LBiBE1nPDWH0nfOZXEr6O3BRa4l08i0yi2mNsxyls97QNGzqpJNoQNDiLv
	Y5nANGdXeP9R68PIbwE3/TkrA0r9rqzQEHT83oU3RVE2W/IgcdOPEuE0unTx/lET+1Ht/eYEECl00
	MUPAtPXQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtsqv-0000000Etzg-1riU;
	Tue, 11 Aug 2026 20:13:37 +0000
Date: Tue, 11 Aug 2026 13:13:37 -0700
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
Message-ID: <anuCcb-Cma6JOAb0@infradead.org>
References: <20260806221031.79050-1-ebiggers@kernel.org>
 <20260806221031.79050-3-ebiggers@kernel.org>
 <ann1i5VjTmgChjs7@infradead.org>
 <20260810161404.GA1930@sol>
 <anoIiy0V-m-05yZc@infradead.org>
 <20260810182215.GA270444@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810182215.GA270444@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 10, 2026 at 06:22:15PM +0000, Eric Biggers wrote:
> On Mon, Aug 10, 2026 at 10:21:15AM -0700, Christoph Hellwig wrote:
> > On Mon, Aug 10, 2026 at 09:14:04AM -0700, Eric Biggers wrote:
> > > On Mon, Aug 10, 2026 at 09:00:11AM -0700, Christoph Hellwig wrote:
> > > > On Thu, Aug 06, 2026 at 03:10:30PM -0700, Eric Biggers wrote:
> > > > > To fix a deadlock, blk-crypto-fallback needs to be able to make fallible
> > > > > mempool_alloc_bulk() allocations.
> > > > 
> > > > It doesn't.  fallible mempool allocations are a concept that doesn't
> > > > make much sense.  Please just go straight to the backing page allocator
> > > > instead for callers that do not need the mempool guarantees.
> > > 
> > > It does make sense.  When alloc_pages_bulk() doesn't completely succeed,
> > > there still might be pages available in the mempool.
> > 
> > But they should not go to a caller that does not need the mempool.
> 
> The caller does need the mempool.

If it does not specify a blocking GFP_* mask, it by definition does not.

> Now, as I explained in this patchset, whether this code can wait forever
> for the mempool actually depends on whether it's a recursive bio
> submission or not.  If it is, then it cannot wait, but ultimately it
> does still need to use the mempool to get a guaranteed allocation.
> 
> Falling back to the rescuer kthread (which can wait on the mempool)
> solves that.  But before taking that slow fallback, it's much more
> efficient to check the mempool directly first, since pages may be
> available there (and in fact it's fairly likely that they will be, since
> regular allocations are always used first).  The whole point of the
> mempool is that it can be used when the regular allocation fails.

What is actually efficient is do skip the mempool entirely from the
original submission context and do a non-mempool GFP_NOIO allocation,
and only in the extremely unlikely case that this fails fall back to
the rescruer thread.

> This is also the only caller of mempool_alloc_bulk().  So I'm kind of
> confused why it would not be allowed to implement the behavior that is
> desired here, especially when the non-bulk API offers it already.

Because passing GFP_ flags with all their warts is a bad idea where
we can avoid, as is using up mempool resources where not needed, and as
is having a possible failure path from a function that can only happen
for non-standard flags.  (having a return value at all is also stupid,
but that is forced on us by the braindead alloc_hooks).

