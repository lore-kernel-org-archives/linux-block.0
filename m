Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D919DF48
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050181; cv=none; b=B9u8z7VEWeIO7D74DFc734Qw+SfbqTEp89Ii1eDCNBdYrPe+Rmbx5hDiThNKArNFwzcci8/cDptGrIEVAmn7zQoVZM1I9t+d5h2lkX0Yey7MvntgrkyGkDxdV8DcHmCyz2qXXmFXw56cH9iCteVUkVJgtopMcIN1qfc3h5sq+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050181; c=relaxed/simple;
	bh=3ApIgvA52f7RrsrFLTfvsvDrp1RXK2VYtS5ItZpzE/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9WHFfQDyRi7atItcZNFtmeVrtYMLEQV0bo0M4PZg1IViHE2aTqoNqHLJd+yxXynSTWEeKq6E6waH8JIRkCxr/RV7Rbnn3nBdmCD/TaZGrWZXlrq8z7zRe/3a+b6Ae1mFvJwfKY/1zhwcM+02qGMGCir0FnTVYRuqe/tLHYo8PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07C6568BFE; Mon, 16 Jun 2025 07:02:48 +0200 (CEST)
Date: Mon, 16 Jun 2025 07:02:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
Message-ID: <20250616050247.GA860@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-3-hch@lst.de> <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 11, 2025 at 03:43:07PM +0200, Daniel Gomez wrote:
> > +struct blk_dma_iter {
> > +	/* Output address range for this iteration */
> > +	dma_addr_t			addr;
> > +	u32				len;
> > +
> > +	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
> > +	blk_status_t			status;
> 
> This comment does not match with blk_rq_dma_map_iter_start(). It returns false
> and status is BLK_STS_INVAL.

I went over you comment a few times and still don't understand it.
