Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A639A224D6;
	Thu,  2 Apr 2026 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775107865; cv=none; b=dSxT5MOcki39J+jaGmagaKL0Bo1x3qMYxBLEfdVh4UUVprL0XV8TBqoh0yKQyuQb49dRzzd+nqll7Z4+eYR3KvK/q3Y3lwiejt1zxJD6JpnwYy9+x7t7BpB6zEgdLtE8dRUNCaKac1fjTAhHHiNXOABgyHbVwInMkacu5vqfo3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775107865; c=relaxed/simple;
	bh=AipQmdkASDXeeEbuHUqmH98lmg776Bl+vOSQk3wV6Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUSweh7vD5FG0+8gbRDXdxmkgWpnAVUL7gviPiRpWCpaA3Y8sEwxT2e4u0rElFpRf99Z9sDR3MDRVUg8f5IErOeegWqRECRDVUXI3fikkT2iIL6SeAjjnq7TLQSxHJL6wX3bFOnG1NK93TbqWtUJtmxDxoxy9LPzNlwSMkDxPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4569268BEB; Thu,  2 Apr 2026 07:30:58 +0200 (CEST)
Date: Thu, 2 Apr 2026 07:30:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 2/2] block: allow different-pgmap pages as separate
 bvecs in bio_add_page
Message-ID: <20260402053057.GA11783@lst.de>
References: <20260401082329.1602328-1-namjain@linux.microsoft.com> <20260401082329.1602328-3-namjain@linux.microsoft.com> <20260401140850.GC21703@lst.de> <70c82c3a-d135-4877-ab46-c15d329815f5@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70c82c3a-d135-4877-ab46-c15d329815f5@linux.microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 02, 2026 at 10:51:05AM +0530, Naman Jain wrote:
> When a direct I/O request spans pages from different chunks (different 
> pgmaps), the current code rejected the second page entirely:
>
>     if (!zone_device_pages_have_same_pgmap(bv->bv_page, page))
>         return 0;  // Rejection - forces bio split or I/O error
>
> Both chunks are regular RAM from the DMA perspective 
> (MEMORY_DEVICE_GENERIC, not P2PDMA). The only requirement is that they not 
> be merged into the same bvec segment, which patch 1/2 enforces by adding 
> the pgmap check to biovec_phys_mergeable().
>
> This patch allows pages from different pgmaps to be added as separate bvec 
> entries in the same bio, eliminating bio splits and I/O failures
> when buffers span pgmap boundaries.

Which as I said we can't do in general, as different pgmaps cna have
different DMA mapping requirements.  We might be able to relax this
if we know multiple pgmaps can be mapped in the same way.  I.e.
replace zone_device_pages_have_same_pgmap with
zone_device_pages_compatible and add additional conditions to it.

> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -231,6 +231,9 @@ int bio_integrity_add_page(struct bio *bio, struct page 
> *page,
>         if (bip->bip_vcnt > 0) {
>                 struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
>
> +               if (is_pci_p2pdma_page(bv->bv_page) !=
> +                   is_pci_p2pdma_page(page))
> +                       return 0;
>                 if (zone_device_pages_have_same_pgmap(bv->bv_page, page) &&

The above is implied by not having the same pgmap.

