Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00B3446C2;
	Wed, 19 Nov 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546123; cv=none; b=Amz0jYJE/Fwag7sePY24qTfC0/c5OU9bBmA6abSlSLrFnwRlPEm+QlIFx86dhVzWxJsws2yNAW+p/l/3XoIphxCGtEjcrTT997Q0vowqUOPNFLow8JCliw9wRG41Y4p+S9SMS+gPkeO0VkbN98T1L2Usw5dCISnWuP2g5Q2+DPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546123; c=relaxed/simple;
	bh=mrVGDGmdBwi9bp1Ejm5GWoCivDI1+7VKZSTga3B+PrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhoChP+5gAgqRAkozpGTOmc1+UCjQ6oYbLACv0QF6pPKiNfpYi/RBKKRuJCuztQGcZToMPTC9Gf5PtWxOLCVIxcXhbp7FbAsOKJ1XJ0auY5s8HtOdAMlYQazya1uDxGw+VwMNbq2JmQHKQy7iR8G1t3XD3eY6BWdg/YjJgyQ094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alOJWxNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alOJWxNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9E4C2BCB8;
	Wed, 19 Nov 2025 09:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546122;
	bh=mrVGDGmdBwi9bp1Ejm5GWoCivDI1+7VKZSTga3B+PrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alOJWxNcB+IkVtIDy2pVEUyd3HFS7OmaPY1pgPwYQvu0rHyh4x9n+9brKyMNnQv/v
	 Qq/pe+VC1Nn/fpd6n+LbqNwfMRfVwcZyFTRG9+u0KDEVY3w/5Nv8tE9d3P22QKl/hD
	 ztmwVEfvJ0g6Z2VTO63PE09RkTkimEuutWrCDWxFDze1ym4BLGuNL9hxxXIht6x24v
	 CYHHKFl99vhFfpGb9egB0srcRsR/HhSNEixF0MUs7KHQ+lo8AjkCSqBApb9DMnEPwH
	 M8L5MtlUI6wysxhIXBD2Z4QIm/rkq6+k+Vo8w9R9p7oCQKVHOUgpNF1oEmeNXonWg1
	 E0y9b6mcngrEQ==
Date: Wed, 19 Nov 2025 11:55:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119095516.GA13783@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <20251118050311.GA21569@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118050311.GA21569@lst.de>

On Tue, Nov 18, 2025 at 06:03:11AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > This patch changes the length variables from unsigned int to size_t.
> > Using size_t ensures that we can handle larger sizes, as size_t is
> > always equal to or larger than the previously used u32 type.
> > 
> > Originally, u32 was used because blk-mq-dma code evolved from
> > scatter-gather implementation, which uses unsigned int to describe length.
> > This change will also allow us to reuse the existing struct phys_vec in places
> > that don't need scatter-gather.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > ---
> >  block/blk-mq-dma.c      | 8 ++++++--
> >  drivers/nvme/host/pci.c | 4 ++--
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > index e9108ccaf4b0..e7d9b54c3eed 100644
> > --- a/block/blk-mq-dma.c
> > +++ b/block/blk-mq-dma.c
> > @@ -8,7 +8,7 @@
> >  
> >  struct phys_vec {
> >  	phys_addr_t	paddr;
> > -	u32		len;
> > +	size_t		len;
> >  };
> 
> So we're now going to increase memory usage by 50% again after just
> reducing it by removing the scatterlist?

It is slightly less.

Before this change: 96 bits
After this change (on 64bits system): 128 bits.

It is 33% increase per-structure.

So what is the resolution? Should I drop this patch or not?

Thanks 
