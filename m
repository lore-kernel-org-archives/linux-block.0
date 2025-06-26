Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8138FB9
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 05:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750914674; cv=none; b=YSKEkb8W7vKYrz5L+VGEb4ShsMX+hI5KNSkpbE0JguhnPUzlwZ1rOw5KyEB/Og2xGmwpYdtRcNH/0Wf42Z3IGJzcVu7d6C189xpvbyoIYx114HcZTQRlgnePVzsJAO5AYs6x47chBk8NocRAui936GCZMhH2xdvhvcQs5g9QoLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750914674; c=relaxed/simple;
	bh=bzwnq/Juzdy782BFxOm81D3YY4ZBkgMEG5CdsJmbkRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUd2IC3DOKwjpjLRSCoG/tErILRsLxFYIcHKkvcQeX1YA+kTFjB7bicVmMs80XP4G9IehRA713S5EtstVHEaq5BCrp87YGu+l7w/dUXtY7xq80rpghxrrdaxS7mQ7OCL5RD7Imi2Q1DgE/knI2VuiYF/zfvvmZBMCdrJk0GrU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FC8B68B05; Thu, 26 Jun 2025 07:11:07 +0200 (CEST)
Date: Thu, 26 Jun 2025 07:11:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, leon@kernel.org, joshi.k@samsung.com,
	sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: convert metadata mapping to dma iter
Message-ID: <20250626051106.GB23248@lst.de>
References: <20250625204445.1802483-1-kbusch@meta.com> <20250625204445.1802483-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625204445.1802483-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 25, 2025 at 01:44:45PM -0700, Keith Busch wrote:
>  static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
>  {
>  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_dev *dev = nvmeq->dev;
>  	struct nvme_sgl_desc *sg_list;
> +	struct blk_dma_iter iter;
>  	dma_addr_t sgl_dma;
> +	int i = 0;
>  
> +	if (!blk_rq_integrity_dma_map_iter_start(req, dev->dev, &iter))
> +		return iter.status;

If blk_rq_dma_map_coalesce returns true after this, which it will do for
all mappings when using an IOMMU, we can simply set up a single contiguous
metadata pointers here, which will be a lot more efficient than using an
SGL.

> +	for (i = 1; i <= iod->nr_meta_descriptors; i++)
> +		dma_unmap_page(dev->dev, le64_to_cpu(sg_list[i].addr),
> +				le32_to_cpu(sg_list[i].length), dir);

This should walk based on the size of SGL segment descriptor pointed to
by the metadata pointer, similar to what we do for the data SGLs.  The
descriptors if counted as by the data mapping path are always one for
SGL mappings (and could in fact just be replaced with a flag if we
cared enough).

