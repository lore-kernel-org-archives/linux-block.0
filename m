Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39DE2E11DB
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073713; cv=none; b=lWbpyW6uFaVJNjlxgMfsKwrrXHC5Zb9qYt+ByxHUktHtSXs8oqp29JivEL8+M3is+a6+1z3s27+9oHLeropFMljrV1Cx4C5m7OFmKN5ePZ4t0pee0oOdHJOhvMJnANp6Gz7WM4OC5vEDQ6JrlIaqWIkUMDAk1rgWDz7UW6HyNz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073713; c=relaxed/simple;
	bh=xoixbIzVyqakRNAu3/aE0xP9QbTeuyAOLsIHxSCjdh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g57gj+5aVrXEMBCdFOV3TiRmkQJ3Gi1dvE4cFwtTPUM8qXx3UBZ/4ZNwOU3AF2MBBLPyJ/HqQEGBe/WCNT/ghkAuj9kPjNr8ZU5Z+CTfG9ARzD/TQSKiu6WAqISgw1NHWA70BtwJxGKeny5b0AjTWSatOj0r458IniSZ7p4Frh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99CB368D07; Mon, 16 Jun 2025 13:35:06 +0200 (CEST)
Date: Mon, 16 Jun 2025 13:35:05 +0200
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
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
Message-ID: <20250616113505.GA22121@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-8-hch@lst.de> <871b014b-e308-4f20-9701-5581beee91ed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871b014b-e308-4f20-9701-5581beee91ed@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 09:49:47AM +0200, Daniel Gomez wrote:
> >  #define NVME_MAX_SEGS \
> > -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
> > -	    (PAGE_SIZE / sizeof(struct scatterlist)))
> > +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))
> 
> IIRC, I've seen in the commit history going from PAGE_SIZE to CC.MPS for
> different cases in the driver. PRPs requires contiguous regions to be CC.MPS,
> i.e use NVME_CTRL_PAGE_SIZE for PRP lists and entries. But I think that is not a
> limit for SGLs. Can we use PAGE_SIZE here?

Sure.  Separate unrelated patch, though.
