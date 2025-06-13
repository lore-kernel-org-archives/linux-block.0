Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE21DF987
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795461; cv=none; b=IPGrUhtjFAV5tjnqG8PrJ4U24WM2bzS7kuGLteXKvDUZjWERGIcl6SveT7zywFNykDdTWFbqgEZ1uCC9ngRSxnrlBdLbdlbEHNPwd7ELW1wf+0fuxsD1TYBVx9n/Sz1J5qiAYGiH76JbAOnRCjkgbHTV8OIu9YInwVdouGg3kVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795461; c=relaxed/simple;
	bh=LF/Vd5mVZVsNTTqp6DC/YrNF2fsdMkBNh6QPcdiAJJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9VQODmB6DRuUBoVzLLzcp7Zgxxfqcsgtj0Pt6g6U2mSf29HD8oh91wGHVHU0+7STdtl4cJbIPhMDRlAeiINZ9WwH9vwVsG91k0fTct5EaKsq6JkDoECW+pI2bwYfQMFekxtbzEvK5yRENtcQG1qzqxcM8Z3dQDzBBqfJVBDTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D2BD68D0D; Fri, 13 Jun 2025 08:17:34 +0200 (CEST)
Date: Fri, 13 Jun 2025 08:17:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
Message-ID: <20250613061734.GA9482@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <CGME20250610050727epcas5p3d2b58ed1a8224a141d819fdc985d1a0c@epcas5p3.samsung.com> <20250610050713.2046316-3-hch@lst.de> <e7e6235b-99c3-478d-887e-4b2c9a1a14f4@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e6235b-99c3-478d-887e-4b2c9a1a14f4@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 12, 2025 at 12:05:18PM +0530, Kanchan Joshi wrote:
> On 6/10/2025 10:36 AM, Christoph Hellwig wrote:
> > +static bool blk_dma_map_bus(struct request *req, struct device *dma_dev,
> 
> Both are not used in the function body.

I'll fix it.

> > + */
> > +bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
> > +		struct dma_iova_state *state, struct blk_dma_iter *iter)
> > +{
> > +	unsigned int total_len = blk_rq_payload_bytes(req);
> > +	struct phys_vec vec;
> > +
> > +	iter->iter.bio = req->bio;
> > +	iter->iter.iter = req->bio->bi_iter;
> > +	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
> Should this (or maybe p2pdma field itself) be compiled out using 
> CONFIG_PCI_P2PDMA.

We could, but is it really worth the effort?
