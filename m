Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44A1514F7;
	Mon, 20 Oct 2025 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972015; cv=none; b=npIQvDGI7XGACgqFRX0Qzan+GVRHVpJHnqMUlwYsBLclvAI8IsaJ/et3G9z99Mw3nM59l/sG5hRCN7sgJ22sC894l8ujqhVXu3cuOg0By3GG4aatD9cpqNtJDbkbhVFJmUXFM7uWvHrklTeEl4vZindp8JK1SDfv5oaLRpFrecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972015; c=relaxed/simple;
	bh=iAt8uGGscg6uWZh66jwdRnihglXUOWBkZsoHIrSxxpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvAYegYNAmoW4eRn3EBIkvuNAVSckBN1iDH6D2T5F3LxnDB8N/4mxNn9ogGNNbD0BWb8+oxezdEnx+GSCjydGCrMN41R9ygV1n/kP9IVPYx0t9ffY6uuM6b9ysZBvbMDfX1Vh48GvKo8tesqNr89eoc9yHYJVZACUKoTki7ZCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asELskkp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asELskkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A889C4CEF9;
	Mon, 20 Oct 2025 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760972015;
	bh=iAt8uGGscg6uWZh66jwdRnihglXUOWBkZsoHIrSxxpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asELskkprdgJtjllqYs0rdCuEmNCkXqf4RBj2CyENr/KnnJJILB41kjDrHdVs7+W6
	 ffnVeXfx/I2d232YlMsDIASdOVv8OY7PhBo2MBieCPhN06dAao+0W8Lc37WK0sPkh6
	 WbegKrPveUSXR1m3Mfy/3xeRSNY+EXtOEXdLGyPSp1EBI+FqxSS8aWowSCzHE+IRi8
	 UxLmeEKWma8nAxmSVZzbzYpzqNZT7KTC9CbIQyVcUDep/EZ+SXxD8CfyZVW4VYmVJo
	 dPusg9uxnjdW4uNJ/UGXYQG4B4uF7vaVJBMpIi5bTB7rYm0KhFMkYE1fIXmYf47SkM
	 mVwmzzY/NxoYA==
Date: Mon, 20 Oct 2025 17:53:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] block-dma: properly take MMIO path
Message-ID: <20251020145330.GO6199@unreal>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
 <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com>
 <20251017062519.GC402@lst.de>
 <20251020085231.GM6199@unreal>
 <20251020123027.GA19560@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020123027.GA19560@lst.de>

On Mon, Oct 20, 2025 at 02:30:27PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 11:52:31AM +0300, Leon Romanovsky wrote:
> > What about this commit message?
> 
> Much bettwer.  Btw, what is the plan for getting rid of the
> "automatic" p2p handling, which would be the logical conflusion from
> this?

I continued with "automatic" p2p code and think that it is structured
pretty well. Why do you want to remove it?

The code in v2 looks like this:

@@ -184,6 +184,8 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
                 * P2P transfers through the host bridge are treated the
                 * same as non-P2P transfers below and during unmap.
                 */
+               iter->attrs |= DMA_ATTR_MMIO;
+               fallthrough;
        case PCI_P2PDMA_MAP_NONE:
                break;
        default:

...

@@ -1038,6 +1051,9 @@ static blk_status_t nvme_map_data(struct request *req)
        if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
                return iter.status;
 
+       if (iter.attrs & DMA_ATTR_MMIO)
+               iod->flags |= IOD_DATA_MMIO;
+
        if (use_sgl == SGL_FORCED ||
            (use_sgl == SGL_SUPPORTED &&
             (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))
@@ -1060,6 +1076,9 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
                                                &iod->meta_dma_state, &iter))
                return iter.status;
 
+       if (iter.attrs & DMA_ATTR_MMIO)
+               iod->flags |= IOD_META_MMIO;
+
        if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
                entries = 1;

...

@@ -733,8 +739,11 @@ static void nvme_unmap_metadata(struct request *req)
                return;
        }

+       if (iod->flags & IOD_META_MMIO)
+               attrs |= DMA_ATTR_MMIO;
+
        if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
-                                       iod->meta_total_len)) {
+                                       iod->meta_total_len, attrs)) {
                if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
                        nvme_free_sgls(req, sge, &sge[1], attrs);
                else

The code is here (waiting for kbuild results)  https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=block-with-mmio-v2

Thanks
