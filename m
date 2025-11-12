Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9E33C53F;
	Wed, 12 Nov 2025 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958291; cv=none; b=FxFxJdFWD5odvBGAIFMwsUVus9zp362vlfEdlN0mnNUCvhO+aXteLV+KEYThLHtoGmCu1BMl/cLkeK/9rb42oDeM2KNKs5LqY6rUAxuSLJjiH23LHpDmF7X7bwEJt+vh33XgV2pqQgTv/vU8tRcvIv+MNLFhq/3clf5rwbX2HxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958291; c=relaxed/simple;
	bh=3w+5TRvSRZNdSUCPnulOp1wUZx4xTqD2yLBq2QoKneQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoLY3tFQdmyul+l7vYpdT8Dn8sBnZPNQGPjqhWo0hC49rf6Y/xWtIV6Qt4jRpRtVtMfaq3PK6iYWfvTnV4RB46MfJvaf5S7MjOYlC/cyFf+6tKHgA0g/yFY8MjB2g0mIYDYbnciaawkHYHdZVBCQAyvtkW8S2k+ecqtvk94P01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPV1gENl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPV1gENl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBA7C4CEF8;
	Wed, 12 Nov 2025 14:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762958290;
	bh=3w+5TRvSRZNdSUCPnulOp1wUZx4xTqD2yLBq2QoKneQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPV1gENlHnzIHESu9BbF88ylyZanjfn8jyXO2haMRr2VQJBg9aoXf423Z9gkqjY1x
	 tubOVbg5LYUdW8AjO2MGOwFGsccdqID34Hc286+wxwQChN4kXumx+23xJNrSXbE9wz
	 EzmvMq5uLrz/2bMF3NUFbvADRocsT6jmsT+DKLAOUaxPLuEKAn/aQgurCazMx/8JL+
	 y+6xKFiyH6H52MjrsD0T1m+4Plcnb7a+qGABlPxs1XvuaZfWFhe1SVFYFLkqC2j65M
	 YgcRZFXP4H4LewlG+B+oZZgaQi4QBeVHqRa0XJ1ed+R1K76a1hC6/rUPMKIeCurBhq
	 sl06EsxKqIH9g==
Date: Wed, 12 Nov 2025 09:38:07 -0500
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <aRSbzwpS2AuP92_n@kbusch-mbp>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>

On Mon, Oct 27, 2025 at 09:30:21AM +0200, Leon Romanovsky wrote:
> @@ -732,13 +746,20 @@ static void nvme_unmap_metadata(struct request *req)
>  		return;
>  	}
>  
> -	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
> -					iod->meta_total_len)) {
> +	if (iod->flags & IOD_META_P2P)
> +		map = PCI_P2PDMA_MAP_BUS_ADDR;
> +	if (iod->flags & IOD_META_MMIO) {
> +		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> +		attrs |= DMA_ATTR_MMIO;
> +	}

This should be an 'else if' no?

> @@ -760,12 +783,20 @@ static void nvme_unmap_data(struct request *req)
>  		return;
>  	}
>  
> -	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
> +	if (iod->flags & IOD_DATA_P2P)
> +		map = PCI_P2PDMA_MAP_BUS_ADDR;
> +	if (iod->flags & IOD_DATA_MMIO) {
> +		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> +		attrs |= DMA_ATTR_MMIO;
> +	}

Same here.

> @@ -1036,6 +1067,17 @@ static blk_status_t nvme_map_data(struct request *req)
>  	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
>  		return iter.status;
>  
> +	switch (iter.p2pdma.map) {
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		iod->flags |= IOD_DATA_P2P;
> +		break;
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		iod->flags |= IOD_DATA_MMIO;
> +		break;
> +	default:
> +		return BLK_STS_RESOURCE;
> +	}

Why is it an error if the data isn't a P2PDMA type?

> @@ -1058,6 +1100,17 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
>  						&iod->meta_dma_state, &iter))
>  		return iter.status;
>  
> +	switch (iter.p2pdma.map) {
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		iod->flags |= IOD_META_P2P;
> +		break;
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		iod->flags |= IOD_META_MMIO;
> +		break;
> +	default:
> +		return BLK_STS_RESOURCE;
> +	}

Same here.
