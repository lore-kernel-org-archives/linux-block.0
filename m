Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D828CF6D
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 05:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163626; cv=none; b=Z8SVVRnxd+8vEOl86bCkzlhKvic4rnhdCEpvyCps4qB/U0VW8YKSsQg0mIA1yHTIpECUnZmmOywk5stjWyDXohAxSLUMJJTuWjXAOttfiSw+bnmYkk7xSL9FufuDpzaSrM7+rGN8+8PFXISeDLU6yn8fSRKgmbI6ACsrT++Qt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163626; c=relaxed/simple;
	bh=8P88nmybSdt6par1HmuSfKl0o1ivIxV0cYgSGht2lzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uISyKqtkpixSj3Rb+zKMBn/LqoA5mLjdyG99dA32J/0LomizDPa8BwuDP0gCGO4CvMcOLKIdno3MU48y0JzXuRaFpkjd7wbtE96XRGUDHMcPVmE4T/AZAEajkILKAQmXkctrEO2IkWVdMsiiuSecL/BxjVOepVT7ywPPX4athb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9AC0768AA6; Tue, 22 Jul 2025 07:53:39 +0200 (CEST)
Date: Tue, 22 Jul 2025 07:53:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv2 1/7] blk-mq-dma: move the bio and bvec_iter to
 blk_dma_iter
Message-ID: <20250722055339.GB13634@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-2-kbusch@meta.com> <20250721074223.GF32034@lst.de> <aH74XluC0BnerBaQ@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH74XluC0BnerBaQ@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 21, 2025 at 08:33:02PM -0600, Keith Busch wrote:
> On Mon, Jul 21, 2025 at 09:42:23AM +0200, Christoph Hellwig wrote:
> > On Sun, Jul 20, 2025 at 11:40:34AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > The req_iterator just happens to have a similar fields to what the dma
> > > iterator needs, but we're not necessarily iterating a bio_vec here. Have
> > > the dma iterator define its private fields directly. It also helps to
> > > remove eyesores like "iter->iter.iter".
> > 
> > Going back to this after looking at the later patches.  The level
> > for which this iter exists is only called blk_map_* as there is
> > nothing dma specific about, just mapping to physical addresses.
> > 
> > So maybe call it blk_map_iter instead?
> 
> But the structure yields "dma_addr_t" type values to the consumer.
> Whether those are physical addresses or remapped io virtual addresses,
> they're still used for direct memory access, so I think the name as-is
> is a pretty good fit.

There's two layers:

The lower layer implemented by blk_map_iter_next just yields a phys_vec.

The upper layer built on top does the dma mapping in case of the new
blk_rq_dma_map_iter_start / blk_rq_dma_map_iter_next API.  But in case of
the old __blk_rq_map_sg API it doesn't even directly do the DMA mapping
yet.  And some drivers at least historically used the blk_map_sg without
then doing a DMA mapping, either for MMIO or platform specific things
using physical address.  My hope was to eventually migrate them to use
blk_map_iter_next.
