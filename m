Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4918BBA9
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592675; cv=none; b=RrBR5dDpdRpsvZtcgS4XQNgEdIexK5wf+Nbrm29/G/Wk5tW5YFZ8IqqviYEfX6qibSBOE/IBUfQkKKPqQhZ8wK3DxrFEfJ6Lyy9SJ+YTB90GJtnD62BgvuOgS7jNAPDoa6lU6E+LW9e8/OUI9MiCyNO4cLwmb4v+ZVWXzPc/h3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592675; c=relaxed/simple;
	bh=TYUSi9Yplde1tXSVFfpDZFbguzd/gWK3YUSGfzajH0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtzLuhZNUaRyiycnh4203zNBa0kXHHwqZJiQslEEnb+rc8qLZqlm+dTvXK/wmp/oLNeZBAFOIKV30vKv12K3JRqf9Tf10J+FXMUHXdmuPtr08v1FVwg+66Baie79kqjeuIeX2UcC3fbZSLxlAH7gkVqffzXy3TGEoCmrVa+R3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80876C4CEC3;
	Tue, 22 Oct 2024 10:24:33 +0000 (UTC)
Date: Tue, 22 Oct 2024 11:24:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [Regression] b1a000d3b8ec ("block: relax direct io memory
 alignment")
Message-ID: <Zxd9XyqqA604F1Rn@arm.com>
References: <Zw6a7SlNGMlsHJ19@fedora>
 <20241016080419.GA30713@lst.de>
 <Zw958YtMExrNhUxy@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw958YtMExrNhUxy@fedora>

On Wed, Oct 16, 2024 at 04:31:45PM +0800, Ming Lei wrote:
> On Wed, Oct 16, 2024 at 10:04:19AM +0200, Christoph Hellwig wrote:
> > On Wed, Oct 16, 2024 at 12:40:13AM +0800, Ming Lei wrote:
> > > Turns out host controller's DMA alignment is often too relax, so two DMA
> > > buffers may cross same cache line easily, and trigger the warning of
> > > "cacheline tracking EEXIST, overlapping mappings aren't supported".
> > > 
> > > The attached test code can trigger the warning immediately with CONFIG_DMA_API_DEBUG
> > > enabled when reading from one scsi disk which queue DMA alignment is 3.
> > 
> > We should not allow smaller than cache line alignment on architectures
> > that are not cache coherent indeed.

Even on architectures that are not fully coherent, the coherency is a
property of the device. You may need to somehow pass this information in
struct queue_limits if you want it to be optimal.

> Yes, something like the following change:
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index a446654ddee5..26bd0e72c68e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -348,7 +348,9 @@ static int blk_validate_limits(struct queue_limits *lim)
>  	 */
>  	if (!lim->dma_alignment)
>  		lim->dma_alignment = SECTOR_SIZE - 1;
> -	if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
> +	else if (lim->dma_alignment < L1_CACHE_BYTES - 1)
> +		lim->dma_alignment = L1_CACHE_BYTES - 1;
> +	else if (WARN_ON_ONCE(lim->dma_alignment > PAGE_SIZE))
>  		return -EINVAL;

L1_CACHE_BYTES is not the right check here since a level 2/3 cache may
have a larger cache line than level 1 (and we have such configurations
on arm64 where ARCH_DMA_MINALIGN is 128 and L1_CACHE_BYTES is 64). Use
dma_get_cache_alignment() instead. On fully coherent architectures like
x86 it should return 1.

That said, the DMA debug code also uses the static L1_CACHE_SHIFT and it
will trigger the warning anyway. Some discussion around the DMA API
debug came up during the small ARCH_KMALLOC_MINALIGN changes (don't
remember it was in private with Robin or on the list). Now kmalloc() can
return a small buffer (less than a cache line) that won't be bounced if
the device is coherent (see dma_kmalloc_safe()) but the DMA API debug
code only checks for direction == DMA_TO_DEVICE, not
dev_is_dma_coherent(). For arm64 I did not want to disable small
ARCH_KMALLOC_MINALIGN if CONFIG_DMA_API_DEBUG is enabled as this would
skew the testing by forcing all allocations to be ARCH_DMA_MINALIGN
aligned.

Maybe I'm missing something in those checks but I'm surprised that the
DMA API debug code doesn't complain about small kmalloc() buffers on x86
(which never had any bouncing for this specific case since it's fully
coherent). I suspect people just don't enable DMA debugging on x86 for
such devices (typically USB drivers have this issue).

So maybe the DMA API debug should have two modes: a generic one that
catches alignments irrespective of the coherency of the device and
another that's specific to the device/architecture coherency properties.
The former, if enabled, should also force a higher minimum kmalloc()
alignment and a dma_get_cache_alignment() > 1.

-- 
Catalin
