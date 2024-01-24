Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606A18029
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088628; cv=none; b=UR+EF/A/tqBw7b3fJ4h35wjpGNZZexGVWRkTx/SbRYNUVZW6LbDkmAWSgoeibBU0PfyyxJrcA6mhGhDBiwk4ZV3lBJM8lvnjtmR+4jtRK943ZE63P2OEKSv9EZzxABZz+VX8uVuboWyEQdltZ2jtGvnJhbVHVp07KUjhQrX8Xuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088628; c=relaxed/simple;
	bh=YFqrxXgjiOo+TmUq2rZrSQXYpZJ2Jkfcjn2kBwsP6bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEmWnsRh7Fm8C78WgtRaOXsF+rKjWEhOhpSZxDrmgGfl2kRy8RVoyVKfYW9pDwNAlwuEqvEceAZulpj47Rlws5BfLUlQSIdA+UofP/2CvEn1TeCZ6LeEhaHXNeafSKzEuM0HwU8vZQwllMuT3NoU3bqWkSmT0zUngxIWlA6DbV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nIfo07yc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nIfo07yc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vm8Rc+r9I+uSvtsH6aN3r2KmjV1L26uemM6XI/poOQg=; b=nIfo07yc8xKrum+FrFTrpWg68a
	bQub0LRiGXHHscd86BUxz9iVsUDDN9G6sMpI/pHJlhBoTwupruAl0dmMNFaZFF72kyGZaAsNbjy3L
	GsD0ObxRAFmsdMeLR4vwMkmN1Ss5IHKU/9xi4jMM0gwYDjoF3VQFOIiYGvNp+dHb9FlSz3mTzs19B
	ZSFL9Ekf/wSr/6Ne2n3ZKumIEKbT90rLxyHU6i2F+jdeksSYuyi1GtiCU8/yhq3Azm6kOykg4Xg3M
	BQhqEWQsnrAp9N7IewthJSXgFuiiLhsKzvqXhmz4HvD+H9zY9Iy8QKywtV5pQk4SHwPaqW3BKhhXV
	TDYCq2rg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZaU-002FLd-1Z;
	Wed, 24 Jan 2024 09:30:26 +0000
Date: Wed, 24 Jan 2024 01:30:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, dlemoal@kernel.org
Subject: Re: [PATCH 6/6] block: convert struct blk_plug callback list to
 hlists
Message-ID: <ZbDYssPlyoPUGvqI@infradead.org>
References: <20240123173310.1966157-1-axboe@kernel.dk>
 <20240123173310.1966157-7-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123173310.1966157-7-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 23, 2024 at 10:30:38AM -0700, Jens Axboe wrote:
> We currently use a doubly linked list, which means the head takes up
> 16 bytes. As any iteration goes over the full list by first splicing it
> to an on-stack copy, we never need to remove members from the middle of
> the list.
> 
> Convert it to an hlist instead, saving 8 bytes in the blk_plug structure.
> This also helps save 40 bytes of text in the core block code, tested on
> arm64.
> 
> This does mean that flush callbacks will be run in reverse. While this
> should not pose a problem, we can always change the list splicing to
> just iteration-and-add instead, preservering ordering. These lists are
> generally just a single entry (or a few entries), either way this should
> be fine.

That would complete mess up I/O order for anyone using flush callbacks,
I don't think that's great.

