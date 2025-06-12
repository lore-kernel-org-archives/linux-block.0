Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90A87FD
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704362; cv=none; b=my81zHNoaFm7ywiTWkFMqrxHFztd8fI6syHmxcVJBJ2j/Nh/wge58mj4G/Oi/xYQErfvDvarxcUZ90XfuNuL+tvdBofG4WHQJ0eD3yqN3PRLLVGo8mWHTeLBnuoUTR57CtsHXlV1EJgKX2+p8W85hiLiVftlaxH6HSi1UvjzQdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704362; c=relaxed/simple;
	bh=4dQ6zB5Hjl7rsFyoGbPRJ7/FZ2lkEMJ5l860VTjriw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlfvpBPqJIz/y+SLAsPmnS9CiSL1P4zl7tGAn3N3owGAnOyhnKDQQJtP3IjTly91r64Er+69hkgcwbfyZ0XHw76MDV500DjC1N415dSs6mGsHhBml3gTsTDvCz+mUxkej2DbtPciCFNdzXezqIBRxVUQlAbg8PglaC3/lzEBaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E322968D09; Thu, 12 Jun 2025 06:59:16 +0200 (CEST)
Date: Thu, 12 Jun 2025 06:59:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/9] nvme-pci: simplify nvme_pci_metadata_use_sgls
Message-ID: <20250612045916.GC12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-4-hch@lst.de> <aEn3TZO1nGnh3wvK@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEn3TZO1nGnh3wvK@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 11, 2025 at 03:38:22PM -0600, Keith Busch wrote:
> On Tue, Jun 10, 2025 at 07:06:41AM +0200, Christoph Hellwig wrote:
> > +static inline bool nvme_pci_metadata_use_sgls(struct request *req)
> >  {
> > -	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
> > -		return false;
> >  	return req->nr_integrity_segments > 1 ||
> >  		nvme_req(req)->flags & NVME_REQ_USERCMD;
> >  }
> 
> ...
> 
> 
> > @@ -981,7 +979,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req)
> >  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> >  
> >  	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
> > -	    nvme_pci_metadata_use_sgls(dev, req))
> > +	    nvme_pci_metadata_use_sgls(req))
> >  		return nvme_pci_setup_meta_sgls(dev, req);
> >  	return nvme_pci_setup_meta_mptr(dev, req);
> >  }
> 
> Am I missing something here? This looks like it forces user commands to
> use metadata SGLs even if the controller doesn't support it.

Yeah, looks like I messed up something here.
