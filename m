Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905D41F4E59
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754835687; cv=none; b=Cz6mSy7epGgjcblbbytdtguTQbFNaN3dWrOFWmuMRwXB7XAUW2YAKXWtBda8/oWov72lowh65gj0CBNItzim2rJ+QNN7RhZICN/rnNbR4LdKwg6OCSCQccJMPYlFwOF/GIPzwffNHZn2eTRM5YyKS7wZiIKZtOCOGNFz9EH6HZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754835687; c=relaxed/simple;
	bh=pDvs3XpN/DJFFtz9rOZKDLEXRR96giL/Rl+WT8VnBZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUiTF6lhOAmV9/Ad3ZGtV2mBKVmRpylKG3XMUValNQ55VsrORShCzwMM77e78Nylw7mv5KV9xs1KiWQX34Nfr4H9CnvIRQ9Rygbk++WF9KlG4Hdzsnt4v1O/QzpAQWe/Iz/25x8uTqOMxRnB4/MOAzpGTrtN+k75ln9sTy8o/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2401227A87; Sun, 10 Aug 2025 16:21:21 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:21:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 7/8] nvme-pci: create common sgl unmapping helper
Message-ID: <20250810142121.GH4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-8-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 08, 2025 at 08:58:25AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This can be reused by metadata sgls once that starts using the blk-mq
> dma api.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)

> +static void __nvme_free_sgls(struct device *dma_dev, struct nvme_sgl_desc *sge,
> +		struct nvme_sgl_desc *sg_list, enum dma_data_direction dir)
> +{
> +	unsigned int len = le32_to_cpu(sge->length);
> +	unsigned int i, nr_entries;
> +
> +	if (sge->type == (NVME_SGL_FMT_DATA_DESC << 4)) {
> +		dma_unmap_page(dma_dev, le64_to_cpu(sge->addr), len, dir);
> +		return;
> +	}
> +
> +	nr_entries = len / sizeof(*sg_list);
> +	for (i = 0; i < nr_entries; i++)


We can probably just do away with the nr_entries variable, the compiler
is not going to recompute this for every loop ieration.


>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>  	struct device *dma_dev = nvmeq->dev->dev;
>  	struct nvme_sgl_desc *sg_list = iod->descriptors[0];
>  	enum dma_data_direction dir = rq_dma_dir(req);
>  
> +	__nvme_free_sgls(dma_dev, sge, sg_list, dir);

Shouldn't we move the calculation of nvmeq, dma_dev and dir into
__nvme_free_sgls as they are going to be the same for data and metadata.
And then maybe rename it to __nvme_free_sgls and just opencode the
iod->descriptors[0] and &iod->cmd.common.dptr.sgl dereferences in
nvme_unmap_data?

