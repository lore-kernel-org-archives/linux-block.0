Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0391CAA7D
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 04:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780459522; cv=none; b=YfQqDfzRgvoZC3jwUK17JeiqTwLpzItOWec6Ljv/doOAUlvcupnCqq6PZMhlLLRBTCrw2MiXdrBg+8Bk/abmxY5xsfruoP7vbrg/OSPjjRZZSmOdiCc0B6KBfcU0isuhSnvDOH9gfO1R3SYWFwrl697Fsvj1hG4GO3dnUwa6dZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780459522; c=relaxed/simple;
	bh=5JZmVtbAOeYNeIJwSS/8aanSdauXhfPl1FCZp7KoTyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULkh17auwl/kWT+OPYHtJZRF0ezL2ppQ8eD0qyPlOheamtSP9XvQMAbEcbPKCAYCJF/15hL7/kdiGlkUECLwK/941jWxq/MVeMFv8Fg5+Ds3VTiBiZrqz2K3c7CGKZzwh5zsN7oGuzSdxeUd0nZgXr4NCTMYQ4QnT48b29F0+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T2RO7UtK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T2RO7UtK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=043SCsSs2JSML7JnIym3B13AP+h2aeZnXCW78u96sSw=; b=T2RO7UtK1frc+1AkSkGSceeIcT
	xrNY0ELF0Cx86huijYyBxsYf6BdatWGTSm6S52F61MCgjJZcCqqrRzzgDdSsTvckX0uv7wcQEW66Z
	79wzp6/e3j9LwtvQZpCnm5tDjQ7J8v0c8J6vr0cEIcTEADXFzuB5umwi/BijoM/3aY31RNy2kBLYJ
	jilcyx4wTvL1fIEu1xzcjs2PjayF1PftDRqnq9uEijcCjgpt/1f20YHRTATypIMnU0uJCqrnU57Zx
	1Hv7IqzDDKjOQZ4kBmQM7V5fSnGFtfOA9wjQt/zn4MTFg5bO9dMLPVvld4Vc1Bb0xXF6LflO7BmZ2
	eNTjdCCw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcqy-00000003AfF-2ASA;
	Wed, 03 Jun 2026 04:05:16 +0000
Date: Wed, 3 Jun 2026 05:05:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: bio_copy_from_iter
Message-ID: <ah-n_O-q9HSHvewa@casper.infradead.org>
References: <ah28-oyillEaOrm1@casper.infradead.org>
 <20260602060319.GA325@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602060319.GA325@lst.de>

On Tue, Jun 02, 2026 at 08:03:19AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 01, 2026 at 06:10:18PM +0100, Matthew Wilcox wrote:
> > I'd like to remove copy_page_to_iter() (and only have
> > copy_folio_to_iter()).  That led me to looking at bio_copy_to_iter().
> > At first glance, switching it to bio_for_each_folio_all() makes a lot of
> > sense -- if there are large folios involved, then we can copy an entire
> > folio at a time instead of a page.
> > 
> > But what I can't prove to my satisfaction is that every bio passed to
> > bio_copy_to_iter() necessarily contains folios.  That's not currently
> > necessary, but will become necessary in the future. [1].
> 
> bio_copy_to_iter is only called from blk_rq_unmap_user, which is only
> used for bios created blk_rq_map_user_iov and only used when they had to
> be bounce buffer.  There's two sources of pages for the bounce buffering:
> The allocation in bio_copy_user_iov using alloca_page, and whatever sg
> and st pass in through struct rq_map_data.

I must have misread the code.  I thought we could get to bio_map_kern()
from blk_rq_map_user_iov(), but on reviewing it now, I don't see a way.

> A good step to be able
> to validate this would be to kill the mess around struct rq_map_data,
> as in removing that structure.  There's no good reason why these
> drivers should do their own allocations, this has mostly been
> grandfathered in.

Yes, that doesn't look too bad.  Just sg and st using it.

> > [1] I believe all these bvecs are constructed using
> > blk_rq_map_user_iov() which can end up calling bio_add_vmalloc(),
> > and vmalloc pages will not be folios.
> 
> blk_rq_map_user_iov can't call bio_add_vmalloc.  And if you want to make
> the vmalloc backing not folios you will be in a huge world of pain
> anyway, as we expect to back folios using vmap/vm_map_ram and treating
> vmalloc different from this will be extremely messy and invasive.

Assuming you inadvertently transposed two words and meant to write "we
expect to back vmap/vm_map_ram using folios", I do intend to keep that
working, but I also do not intend to allocate folios in order to back
vmalloc areas.  I don't think it'll be all that messy, but I haven't
worked through the details of it yet.
