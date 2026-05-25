Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E83E3C72;
	Mon, 25 May 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701763; cv=none; b=mqLxnD5dL+vQIjpU/DVrIbU55uPcQzHeMfngn5X03BGnIhhiwaOwnIuxR6Th2+OHJ1ug769egB/OvJegfWNUKo1WYNP5liuySV6oR8GuTwfUX+v1TzHLhUPZxVLUE4nIumbvioaIKCaCo4M+HV2Xb/qG/SdRMF28xO3zLIAbVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701763; c=relaxed/simple;
	bh=SP01eiK2BPZNPJi/RDC0yQU19nFNlhUX2FgAQw40oLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSoqmprlSnDPuvccSCzRjbCtEP3PLVYAh7dC/CJejcqhokfCACtaDpB2PKuq4kpkaUtcVTQ84z9ssvqxdM8BppUfvVXWMbUV6HpOyavQeG+KKpFlnswO24Veragi9m9XM/rUf5+2ntIfplLHRARzIDxcjuRB4wxpioGJAbBDR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsJeKhU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsJeKhU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DBF1F000E9;
	Mon, 25 May 2026 09:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701762;
	bh=TSlRGc4vedzf5rp11u6syntPvQ3XBzKQAqEIKtTm7KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DsJeKhU5epa1AZ8TvhGDHxmb6Hif2L/HdyGp5o6jZV7CL8cUkSEJmw3OIM5zgOCn3
	 egTDTF8ykaFtiJaGET3FmAGqTDxzljNfTRUEHLuBugdRmNL2Wv/hxEeznH/d+LxUxh
	 9ViWgqGSjLoMg7qlS/6GRV+NnU3tMgPgEmJLj2AB3wefYypbTo/XcAUWMh7LyUh+9+
	 p0Vdv/BNubvCfV7rOehbgxw/iaIgA/LE6KBesxADsQLVST9cXN6rGBmt+LKF3GowJF
	 A541T1WqqC9+w3HFkOIwvULrppFTgH2dBXUxZlu1OOVCw8p+KLqEsipD6CWlgI6JFW
	 6KLOmxGNmmdfA==
Date: Mon, 25 May 2026 12:35:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
Message-ID: <ahQX_JCgS9JWIhY-@kernel.org>
References: <20260520-block-v1-1-6463dc2cf042@kernel.org>
 <ahPnX-CwVgK-9chp@infradead.org>
 <ahPxmSqT4Y4jcAbQ@kernel.org>
 <ahP3R2nH8-bHMVf0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahP3R2nH8-bHMVf0@infradead.org>

On Mon, May 25, 2026 at 12:16:23AM -0700, Christoph Hellwig wrote:
> On Mon, May 25, 2026 at 09:52:09AM +0300, Mike Rapoport wrote:
> > On Sun, May 24, 2026 at 11:08:31PM -0700, Christoph Hellwig wrote:
> > > On Wed, May 20, 2026 at 11:15:52AM +0300, Mike Rapoport (Microsoft) wrote:
> > > > check_partition() allocates a buffer to use as backing buffer for
> > > > seq_buf.
> > > > 
> > > > This buffer can be allocated with kmalloc() as there's nothing special
> > > > about it to go directly to the page allocator.
> > > > 
> > > > Replace use of __get_free_page() with kmalloc() and free_page() with
> > > > kfree().
> > > 
> > > So I heard various vague references that we should replace
> > > __get_free_page with kmalloc, but nothing definitive.  Can you please
> > > point to a good resource for that?
> > 
> > There was quite recent discussion when I posted patches that change
> > __get_free_page to return void *:
> > 
> > https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
> 
> This doesn't tell much more.
> 
> > And an old thread when Al posted similar patches:
> > 
> > https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/T/#u<S-Del>
> 
> This does, but it still fails to explain why kmalloc performs just as
> well as __get_free_page(s) these days.

I don't think that in this case - a single allocation on the cold path -
the performance difference is even measurable.

Nevertheless allocations from slab caches are way faster than
__get_free_page() (i.e.  alloc_pages()) as it's essentially lockless
cmpxchg. Allocations that need to refill the cache do alloc_pages() with a
little of slab bookkeeping overhead.

-- 
Sincerely yours,
Mike.
