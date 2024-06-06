Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C891E52A
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649678; cv=none; b=q1r8DbDqeMMj4u1ISHNQ8n59uxanfN3DsPZFyOr6UZHwc9aHJ3Y9w3PcK4VhPzUTexnKdB/HsB4aDr14njYhOp0N/sqaOcoZpCKjZDPxEdkL+WMvh4jEvLT2JFsOmOZfRURy++/W6sjUrG0YYPxjEZy5vlUrGXqZ27htnm6njqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649678; c=relaxed/simple;
	bh=dGqF9CjKU03ztqdbrlZk7PmwPVPhdjSp78vIGA5lpgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W198e1CwGKxgJAJE2NhYPi/xY0SeA6Gc1Z1goDGpRJH+IElw8Q8qNFT2q8BfD2coSZK783dVv6xRzUujJ9qZUChInU/M6zPBVRQqZPh7v0wC5EzO+VbyqKe9nF0PgKKULPiPXUUN9ArzcGZgNZw/9G+incBdkKRzEoMFWGNcXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6941668CFE; Thu,  6 Jun 2024 06:54:32 +0200 (CEST)
Date: Thu, 6 Jun 2024 06:54:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, linux-block@vger.kernel.org, joshi.k@samsung.com,
	mcgrof@kernel.org, anuj20.g@samsung.com, nj.shetty@samsung.com,
	c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] block: add folio awareness instead of looping
 through pages
Message-ID: <20240606045432.GE8395@lst.de>
References: <20240605092455.20435-1-kundan.kumar@samsung.com> <CGME20240605093225epcas5p335664b9185c99a8fe1d661227d3f4f1a@epcas5p3.samsung.com> <20240605092455.20435-2-kundan.kumar@samsung.com> <ZmCyQwCtvgolgkcz@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmCyQwCtvgolgkcz@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 05, 2024 at 07:45:23PM +0100, Matthew Wilcox wrote:
> >  	if (bio->bi_vcnt > 0 &&
> >  	    bvec_try_merge_page(&bio->bi_io_vec[bio->bi_vcnt - 1],
> > -				page, len, offset, &same_page)) {
> > +				&folio->page, len, offset, &same_page)) {
> 
> Let's make that folio_page(folio, 0)

Or just pass a folio to bvec_try_merge_page (and rename it) if we want
to go all the way, but given that that will go down quite a bit
into xen and zone device code maybe that's not worth it for now as
we should eventually just convert it to a plain phys_addr_t anyway.

> >  	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> >  	bool same_page = false;
> >  
> > -	if (bio_add_hw_page(q, bio, page, len, offset,
> > +	if (bio_add_hw_page(q, bio, &folio->page, len, offset,
> 
> Likewise.

OTOH replacing / augmenting bio_add_hw_page with a bio_add_hw_folio
should be worthwhile, so I'd love to see that as a prep patch.

