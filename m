Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503325B1C7
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570890; cv=none; b=VJdj2MMMFeNUsbElSFJ00Rxyc6TQz+pqKCYC8N2h+c5lj82xuHYG+2jTBvgx3pF1FlzeXDAe6XS8H4T6JKHRdPf/LlK+b62X2cIWJpPlHD4FKBFHX+zSmWIB1lnk6BlBJxOrfP7zOsKT6AMnZKymbFoZFD+sw57dnQW/CFZoS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570890; c=relaxed/simple;
	bh=WvFP0McKHwocaNiAixFjj5MG5WROJq1Uu3RKxW5v3zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTyIS0MDi2v9YBiN11VMIFcEXi6vgjxrmksZjEV23o6b3HBuOcn63Ka0derCwQdn17M5r+sRJgy2ZPnhXTOH8lGkBeaIivDJzTjvhBnt7VZH4etJcfpwOl8k2jlCU4P5wMqEG68ZdDYQk1UUrbd1QTojb4bC0HaRPLCWF9rBvcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 867B6227A88; Mon, 27 Oct 2025 14:14:41 +0100 (CET)
Date: Mon, 27 Oct 2025 14:14:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] slab, block: generalize bvec_alloc_gfp
Message-ID: <20251027131441.GA26554@lst.de>
References: <20251023080919.9209-1-hch@lst.de> <20251023080919.9209-2-hch@lst.de> <aP6QX_gNpY9UDtub@casper.infradead.org> <20251027064728.GA13145@lst.de> <aP9u8lFBvzEzmuHh@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP9u8lFBvzEzmuHh@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 27, 2025 at 01:09:06PM +0000, Matthew Wilcox wrote:
> > > Is there a reason _not_ to use the kvmalloc code for bvec allocations?
> > 
> > It's using a dedicated slab cache, which makes sense for such a frequent
> > and usually short-lived allocation.  We also don't use vmalloc backing
> > ever at the moment.
> 
> That's not what I meant.

Oh, not the entirely kvmalloc code, but the helper.  Ok.

> What I was proposing was:
> 
> +static inline gfp_t try_alloc_gfp(gfp_t gfp)
> +{
> +	gfp |= __GFP_NOWARN;
> +	if (!(gfp & __GFP_RETRY_MAYFAIL))
> +		gfp &= ~__GFP_DIRECT_RECLAIM;
> +	gfp &= ~__GFP_NOFAIL;


That's missing the __GFP_NOMEMALLOC from the original one, and also
__GFP_NORETRY.  So it'll be pretty different.

For now I think I'll just either duplicate the logic or keep it in
block code to get the deadlock fix in, and then we can spend more
time analyzing all the flags and documenting the ones needed in
various places.
