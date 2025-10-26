Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99888212572;
	Sun, 26 Oct 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761485409; cv=none; b=Xv3Sn8GgcshhOTlWE8cF83aIwSu7mVYSHVRUlc+IHOJDYxdm0Pe8/9Vpo3QIy4TIVEmuwdlODwQdzGmwXq++VdOFMU/so1L+V9yfM+Pw/EaojabpzBFR5dDH6sLMy7IPgHhMbsSzFkjMH4EI8ImYq3Jvk7sh7DNnyPeMUzfdHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761485409; c=relaxed/simple;
	bh=40O4AkKAojsrOlSedZ12tmVu2dY2adh7yZ0M+ABkhxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7Phfx7k5pPw9QAuYLhx3rONS96iCzVbaF2Ke51thtnLPeMBSyxyiyfQB63V8a0F3G6M/f81UhSimtByEKwf60aPvPI1Z+5wBSdSKi6ObLtxL0UNYSVfg+YdbiJmHrjkaALdb3jdghLsvSU08mWcFvLhnqOS4E0BvMzoqQDBp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccYD/F0F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccYD/F0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E816C4CEE7;
	Sun, 26 Oct 2025 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761485409;
	bh=40O4AkKAojsrOlSedZ12tmVu2dY2adh7yZ0M+ABkhxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ccYD/F0FX/MYdI3AQbnRUPySQl7LYSTqJKO/BtNbNNxvRdcgqI7T9sc/oM06tpBgZ
	 uyEQBHDuDlee2IdDuyDQ5bU0imuIDLO+R4IOIS6VrwjPhxpFjDD/RMmlxtMxirB0ud
	 z1KCFNyMSD905kmUzg+iMfQRwcTN3yGsyfoDTnSIkmEVA/JLDWzOhbrLBGCgfHJrdw
	 sixIYjk81+pcJNXN1OX+h44WAuVZMzkgtZyGcpI2DoChLysHunbYrbtUaY8JA56s7H
	 GNvmrxpiIsLkDCeNgp7JI102c3uQQ1D09+CaytccWLlzAfetxh/h07TmuGXzIDRqcn
	 QVpd4DG9VUnIQ==
Date: Sun, 26 Oct 2025 15:30:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/2] block-dma: properly take MMIO path
Message-ID: <20251026133004.GE12554@unreal>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com>
 <20251020-block-with-mmio-v2-2-147e9f93d8d4@nvidia.com>
 <20251022062135.GD4317@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022062135.GD4317@lst.de>

On Wed, Oct 22, 2025 at 08:21:35AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 08:00:21PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > In commit eadaa8b255f3 ("dma-mapping: introduce new DMA attribute to
> > indicate MMIO memory"), DMA_ATTR_MMIO attribute was added to describe
> > MMIO addresses, which require to avoid any memory cache flushing, as
> > an outcome of the discussion pointed in Link tag below.
> > 
> > In case of PCI_P2PDMA_MAP_THRU_HOST_BRIDGE transfer, blk-mq-dm logic
> > treated this as regular page and relied on "struct page" DMA flow.
> > That flow performs CPU cache flushing, which shouldn't be done here,
> > and doesn't set IOMMU_MMIO flag in DMA-IOMMU case.
> > 
> > Link: https://lore.kernel.org/all/f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com/
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  block/blk-mq-dma.c            |  6 ++++--
> >  drivers/nvme/host/pci.c       | 23 +++++++++++++++++++++--
> >  include/linux/blk-integrity.h |  7 ++++---
> >  include/linux/blk-mq-dma.h    | 11 +++++++----
> >  4 files changed, 36 insertions(+), 11 deletions(-)
> > 
> > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > index 4ba7b0323da4..3ede8022b41c 100644
> > --- a/block/blk-mq-dma.c
> > +++ b/block/blk-mq-dma.c
> > @@ -94,7 +94,7 @@ static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
> >  		struct blk_dma_iter *iter, struct phys_vec *vec)
> >  {
> >  	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
> > -			rq_dma_dir(req), 0);
> > +			rq_dma_dir(req), iter->attrs);
> >  	if (dma_mapping_error(dma_dev, iter->addr)) {
> >  		iter->status = BLK_STS_RESOURCE;
> >  		return false;
> > @@ -116,7 +116,7 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
> >  
> >  	do {
> >  		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
> > -				vec->len, dir, 0);
> > +				vec->len, dir, iter->attrs);
> >  		if (error)
> >  			break;
> >  		mapped += vec->len;
> > @@ -184,6 +184,8 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
> >  		 * P2P transfers through the host bridge are treated the
> >  		 * same as non-P2P transfers below and during unmap.
> >  		 */
> > +		iter->attrs |= DMA_ATTR_MMIO;
> 
> DMA_ATTR_MMIO is the only flags in iter->attrs, and I can't see any other
> DMA mapping flag that would fit here.  So I'd rather store the
> enum pci_p2pdma_map_type here, which also removes the need for REQ_P2PDMA 
> and BIP_P2P_DMA when propagating that to nvme.

It is already stored in iter->p2pdma.map, will reuse it.

Thanks

> 
