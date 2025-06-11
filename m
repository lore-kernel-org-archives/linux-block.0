Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298CC1EE033
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649391; cv=none; b=otALFZThJsAVYj2WCz4S2JEKCUaE+gnEuo2cnHAkuE7STy6pm6arHl4UIjlp9VfPC8ed3yDYEHEPT6mSKvkhYVbfq899vWEQY/7dXn5+e5vCVzU+JtazKyalnE9Bg4hfXJGbKKtaR87uvBpIwqCOgQB4OOnx3g6CAAIGNGhmXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649391; c=relaxed/simple;
	bh=P6zwvzUUz0B6hR+x2yVh9ikQbfrWHN7UKz34ytW9BGs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WGIR49xNiy4sF1AAsabwAI1N0uKSMxiRg2kvu1wEL0BPdswWgB3EWz2uUXxNkmwaZFDNqQ52HMV7cAlQXPbNMyXukwhtWVUWtfPn5APmi7tg/1qPt3oXb7hwIklmbbGryqKzpOrIrVa/FBOG3oZI5SrN84KRuRIVASYOUuXja1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Moxy7nJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Moxy7nJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB67C4CEEE;
	Wed, 11 Jun 2025 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749649390;
	bh=P6zwvzUUz0B6hR+x2yVh9ikQbfrWHN7UKz34ytW9BGs=;
	h=Date:From:Subject:To:Cc:References:Reply-To:In-Reply-To:From;
	b=Moxy7nJEE8sgn9ViYdpJER/1vycmZ+sZTA6VU9Q/QwU3AHksf0tHaL+6p0eRecFgI
	 nDh4tyEqXqsqg/cjtw5iAsCxyYNLyOdrMvSH/oHCCNs1yphjxp8Fali/B/39500tkQ
	 3U4zLDXkPSbo/wVyyWs1YO9GrCppJkFROCwpbh4Gr2axsVpe/f+D1WGzAEosXeNZ2s
	 NY2Egsa8na8+MlCJeqcOQVHNHjMhYt7AoP6RiGtmZ5/a3oVUsk8XQzIWCLZFB0rYO+
	 Hb5csuLxcHpdJdRTTxTjls+69gb9RF8SMYo4+3PCGArmk/90aegTLJFu4WMONQisCy
	 YQxS5SvL7OCvg==
Message-ID: <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org>
Date: Wed, 11 Jun 2025 15:43:07 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-3-hch@lst.de>
Content-Language: en-US
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2025 07.06, Christoph Hellwig wrote:
> Add a new blk_rq_dma_map / blk_rq_dma_unmap pair that does away with
> the wasteful scatterlist structure.  Instead it uses the mapping iterator
> to either add segments to the IOVA for IOMMU operations, or just maps
> them one by one for the direct mapping.  For the IOMMU case instead of
> a scatterlist with an entry for each segment, only a single [dma_addr,len]
> pair needs to be stored for processing a request, and for the direct
> mapping the per-segment allocation shrinks from
> [page,offset,len,dma_addr,dma_len] to just [dma_addr,len].
> 
> One big difference to the scatterlist API, which could be considered
> downside, is that the IOVA collapsing only works when the driver sets
> a virt_boundary that matches the IOMMU granule.  For NVMe this is done
> already so it works perfectly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq-dma.c         | 162 +++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq-dma.h |  63 +++++++++++++++
>  2 files changed, 225 insertions(+)
>  create mode 100644 include/linux/blk-mq-dma.h
> 
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index 82bae475dfa4..37f8fba077e6 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c

> +static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
> +		struct dma_iova_state *state, struct blk_dma_iter *iter,
> +		struct phys_vec *vec)
> +{
> +	enum dma_data_direction dir = rq_dma_dir(req);
> +	unsigned int mapped = 0;
> +	int error = 0;

error does not need to be initialized.

> +/**
> + * blk_rq_dma_map_iter_start - map the first DMA segment for a request
> + * @req:	request to map
> + * @dma_dev:	device to map to
> + * @state:	DMA IOVA state
> + * @iter:	block layer DMA iterator
> + *
> + * Start DMA mapping @req to @dma_dev.  @state and @iter are provided by the
> + * caller and don't need to be initialized.  @state needs to be stored for use
> + * at unmap time, @iter is only needed at map time.
> + *
> + * Returns %false if there is no segment to map, including due to an error, or
> + * %true ft it did map a segment.
> + *
> + * If a segment was mapped, the DMA address for it is returned in @iter.addr and
> + * the length in @iter.len.  If no segment was mapped the status code is
> + * returned in @iter.status.
> + *
> + * The caller can call blk_rq_dma_map_coalesce() to check if further segments
> + * need to be mapped after this, or go straight to blk_rq_dma_map_iter_next()
> + * to try to map the following segments.
> + */
> +bool blk_rq_dma_map_iter_start(struct request *req, struct device *dma_dev,
> +		struct dma_iova_state *state, struct blk_dma_iter *iter)
> +{
> +	unsigned int total_len = blk_rq_payload_bytes(req);
> +	struct phys_vec vec;
> +
> +	iter->iter.bio = req->bio;
> +	iter->iter.iter = req->bio->bi_iter;
> +	memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
> +	iter->status = BLK_STS_OK;
> +
> +	/*
> +	 * Grab the first segment ASAP because we'll need it to check for P2P
> +	 * transfers.
> +	 */
> +	if (!blk_map_iter_next(req, &iter->iter, &vec))
> +		return false;
> +
> +	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA)) {
> +		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
> +					 phys_to_page(vec.paddr))) {
> +		case PCI_P2PDMA_MAP_BUS_ADDR:
> +			return blk_dma_map_bus(req, dma_dev, iter, &vec);
> +		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +			/*
> +			 * P2P transfers through the host bridge are treated the
> +			 * same as non-P2P transfers below and during unmap.
> +			 */
> +			req->cmd_flags &= ~REQ_P2PDMA;
> +			break;
> +		default:
> +			iter->status = BLK_STS_INVAL;
> +			return false;
> +		}
> +	}
> +
> +	if (blk_can_dma_map_iova(req, dma_dev) &&
> +	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
> +		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
> +	return blk_dma_map_direct(req, dma_dev, iter, &vec);
> +}
> +EXPORT_SYMBOL_GPL(blk_rq_dma_map_iter_start);
> +

...

> diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
> new file mode 100644
> index 000000000000..c26a01aeae00
> --- /dev/null
> +++ b/include/linux/blk-mq-dma.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef BLK_MQ_DMA_H
> +#define BLK_MQ_DMA_H
> +
> +#include <linux/blk-mq.h>
> +#include <linux/pci-p2pdma.h>
> +
> +struct blk_dma_iter {
> +	/* Output address range for this iteration */
> +	dma_addr_t			addr;
> +	u32				len;
> +
> +	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
> +	blk_status_t			status;

This comment does not match with blk_rq_dma_map_iter_start(). It returns false
and status is BLK_STS_INVAL.
