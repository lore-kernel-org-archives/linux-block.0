Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEE9247281
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754836074; cv=none; b=QHnmW2EVvTpI8ba7FGmByTsv1jsJtChN5EQskv+s1yajs2W/SyK5UL0k3pFpJtD5/KHBMgAsUG/nJQOU7mXs+b/zXkxbxEpC/Qtqq1vwOpP4SwQ2y3/19t1WaPyVdbi+aqO+/+6UJ5i6XwvcTUkXQScbBKA9kJtjxTRcXc+Jo5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754836074; c=relaxed/simple;
	bh=rX5bw2uRdYjdb9jGEJlG5Nz8z8uZUoLyWCpTq2z4ufc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaYyH0bpmS85WIVHlwJpv91jzD2gm6M6UTwlq5qQKb/G7LXRXUn4UxwaX2pgIIybsJygduIGLOzaTcggOGonaSFZvmtroF+V72mGoyVGyM+H+fIZLtaiPj5DS8qUZuA/CMVwAT/4cGrp1UukwYeQhungWu2nJXBuIvZ3fSg05DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61D3C227A87; Sun, 10 Aug 2025 16:27:48 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:27:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 8/8] nvme-pci: convert metadata mapping to dma iter
Message-ID: <20250810142748.GA4717@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-9-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-9-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 08, 2025 at 08:58:26AM -0700, Keith Busch wrote:
>  
>  struct nvme_dma_vec {
> @@ -281,13 +285,14 @@ struct nvme_iod {
>  	u8 nr_descriptors;
>  
>  	unsigned int total_len;
> +	unsigned int meta_total_len;
>  	struct dma_iova_state dma_state;
> +	struct dma_iova_state meta_dma_state;
>  	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
>  	struct nvme_dma_vec *dma_vecs;
>  	unsigned int nr_dma_vecs;
>  
>  	dma_addr_t meta_dma;
> -	struct sg_table meta_sgt;
>  	struct nvme_sgl_desc *meta_descriptor;

Maybe keep the meta fields together as much as we can to ensure they
are in the same cacheline(s)?

> +static void nvme_unmap_metadata(struct request *req)
> +{
> +	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> +	enum dma_data_direction dir = rq_dma_dir(req);
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct device *dma_dev = nvmeq->dev->dev;
> +
> +	if (iod->flags & IOD_META_MPTR) {
> +		dma_unmap_page(dma_dev, iod->meta_dma,
> +			       rq_integrity_vec(req).bv_len,
> +			       rq_dma_dir(req));
> +		return;
> +	}
> +
> +	if (!blk_rq_dma_unmap(req, dma_dev, &iod->meta_dma_state,
> +				iod->meta_total_len,
> +				iod->flags & IOD_META_P2P_BUS_ADDR)) {
> +		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
> +			nvme_free_meta_sgls(iod, dma_dev, dir);
> +		else
> +			dma_unmap_page(dma_dev, iod->meta_dma,
> +				       iod->meta_total_len, dir);
> +	}

IOD_META_MPTR above really should be named IOD_SINGLE_META_SEGMENT as
it's all about avoiding the dma iterator, which could also create a
single segment case handled just above.

>  static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
>  {
>  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> +	unsigned int entries = req->nr_integrity_segments;
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_dev *dev = nvmeq->dev;
>  	struct nvme_sgl_desc *sg_list;
> +	struct blk_dma_iter iter;
>  	dma_addr_t sgl_dma;
> +	int i = 0;
>  
> +	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev,
> +						&iod->meta_dma_state, &iter))
> +		return iter.status;
>  
> +	if (iter.p2pdma.map == PCI_P2PDMA_MAP_BUS_ADDR)
> +		iod->flags |= IOD_META_P2P_BUS_ADDR;
> +	else if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
> +		entries = 1;
> +
> +	if (entries == 1 && !(nvme_req(req)->flags & NVME_REQ_USERCMD)) {
> +		iod->cmd.common.metadata = cpu_to_le64(iter.addr);
> +		iod->meta_total_len = iter.len;
> +		iod->meta_dma = iter.addr;
> +		iod->meta_descriptor = NULL;
> +		return BLK_STS_OK;

Maybe throw in a comment explaining that we fall back to a single metadata
pointer here if we can, and why we don't for passthrough requests?

