Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C6F5647B
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999236; cv=none; b=grRdE+nPp0IIWRvYZY1SmWwitEIPWRKO2bsQiZmA9oDEz5f5S2hjPOhUZ61QMz4c6r5/lT6ZUCRKXkpmrJiMCMs8YHojVt4GgtbZm50xc63Nmsh9jN2VrCtmUMJsaxEb+BUM1AeceLPrDBj/jUQUX5L2RSXE+uFO3uhj4TzzJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999236; c=relaxed/simple;
	bh=ApiQ6kBjJ9lEWhkLwIhpDQ7vDgQArANOuDsbkzVX/Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8ZdjSioUAZDR8OL12w7xtTGCC/4H4VHPeF6Ag8CKMqwtuye/D+eo3Nd8xuVUy5qL1DYxg+COpnDvhtyIEImuQkwFGjRd6PAkuYRijgI3zizAcVdkcYZrLNqqxFnpw6rvDs7Mykzne8P+ZHgISiD4lV8fo/6FZJME3iQfamtmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 716F968BEB; Tue, 23 Jan 2024 09:40:29 +0100 (CET)
Date: Tue, 23 Jan 2024 09:40:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 02/15] block: refactor disk_update_readahead
Message-ID: <20240123084029.GA29041@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-3-hch@lst.de> <96007133-162c-4fff-9343-dd88ca520aa7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96007133-162c-4fff-9343-dd88ca520aa7@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 23, 2024 at 01:41:05PM +0900, Damien Le Moal wrote:
> > +{
> > +	/*
> > +	 * For read-ahead of large files to be effective, we need to read ahead
> > +	 * at least twice the optimal I/O size.
> > +	 */
> > +	bdi->ra_pages = max(lim->io_opt * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);
> 
> Nit: while at it, you could replace that division by PAGE_SIZE with a right
> shift by PAGE_SHIFT.

I don't really see the point, this is everything but a fast path,
and for simple constant divisions compilers aren't actually bad at
doing optimizations.

