Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476C78F34
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644114; cv=none; b=HclhZvddcFxSxJF8TV3V/dPIzdMbutomPRyJ9zeonsGdrMgnXnNYXBAx1a84WWB8QWZ3lsr6reGr7vr52EaEKobBWJpG2OCdfn0+5p0I+6CQTHzpHtdXPA6zRRk4qtJWMQgHutqSxpIIOLBK44jvkaPiQmwQudiOda0j1YUt83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644114; c=relaxed/simple;
	bh=zK3mQC0Jkck96l1GMcCAp8W9FUpL+mkHpHxAzpC5Qi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYENJfAqf3ZcJAH6JRUmSzX2SEWw7dmFUT7ODNFny6slC2KcX0BwN4Rw29SqjWIx1D0bMTgn7iVjRwf2XlOiowm7hgp4Gzny4Yx1Luqpt/9/9I0AZvYxEQKprii0kl56nPDBy2sqrYVZCYufv1ytFa6qFuxHwdIx8AGndcaRkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN11kb6+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN11kb6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0A3C4CEEE;
	Wed, 11 Jun 2025 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749644114;
	bh=zK3mQC0Jkck96l1GMcCAp8W9FUpL+mkHpHxAzpC5Qi4=;
	h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
	b=KN11kb6+nrjF2QKf1wbs0T2MFYQuV1hjJ2xlHdBcU0eYeYBzqO0x32J/s9Df40sxM
	 fNOif8tExR1viPxI/6EDIwNVRjdv+ae6nC4bMtbqoUgWUwwTrpUDmb7suBwGvOW8IK
	 D9U5Zrnhq2ur7nSgpSnijdc5D5o3aYIwwyexCYf902cFku1y1IljdTdJind9Mcx3vs
	 oISMZj8+OrB8UxmnWDlfeNnROWIrSehOnqlwasHTiqYKHZZisJuE8b2Y7Jnl6jjVfo
	 P//9yg8Y/wqMX+OXg6KRYi195jP1WtSeFQXxZwzrFjyJEv97l/T8/hdbElumpypaFy
	 RcJ+gSzh2y6pA==
Message-ID: <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
Date: Wed, 11 Jun 2025 14:15:10 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
Content-Language: en-US
Reply-To: Daniel Gomez <da.gomez@kernel.org>
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/06/2025 07.06, Christoph Hellwig wrote:
> Use the blk_rq_dma_map API to DMA map requests instead of scatterlists.
> This removes the need to allocate a scatterlist covering every segment,
> and thus the overall transfer length limit based on the scatterlist
> allocation.
> 
> Instead the DMA mapping is done by iterating the bio_vec chain in the
> request directly.  The unmap is handled differently depending on how
> we mapped:
> 
>  - when using an IOMMU only a single IOVA is used, and it is stored in
>    iova_state
>  - for direct mappings that don't use swiotlb and are cache coherent no
>    unmap is needed at all
>  - for direct mappings that are not cache coherent or use swiotlb, the
>    physical addresses are rebuild from the PRPs or SGL segments
> 
> The latter unfortunately adds a fair amount of code to the driver, but
> it is code not used in the fast path.
> 
> The conversion only covers the data mapping path, and still uses a
> scatterlist for the multi-segment metadata case.  I plan to convert that
> as soon as we have good test coverage for the multi-segment metadata
> path.
> 
> Thanks to Chaitanya Kulkarni for an initial attempt at a new DMA API
> conversion for nvme-pci, Kanchan Joshi for bringing back the single
> segment optimization, Leon Romanovsky for shepherding this through a
> gazillion rebases and Nitesh Shetty for various improvements.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 388 +++++++++++++++++++++++++---------------
>  1 file changed, 242 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 04461efb6d27..2d3573293d0c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -7,7 +7,7 @@
>  #include <linux/acpi.h>
>  #include <linux/async.h>
>  #include <linux/blkdev.h>
> -#include <linux/blk-mq.h>
> +#include <linux/blk-mq-dma.h>
>  #include <linux/blk-integrity.h>
>  #include <linux/dmi.h>
>  #include <linux/init.h>
> @@ -27,7 +27,6 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/io-64-nonatomic-hi-lo.h>
>  #include <linux/sed-opal.h>
> -#include <linux/pci-p2pdma.h>
>  
>  #include "trace.h"
>  #include "nvme.h"
> @@ -46,13 +45,11 @@
>  #define NVME_MAX_NR_DESCRIPTORS	5
>  
>  /*
> - * For data SGLs we support a single descriptors worth of SGL entries, but for
> - * now we also limit it to avoid an allocation larger than PAGE_SIZE for the
> - * scatterlist.
> + * For data SGLs we support a single descriptors worth of SGL entries.
> + * For PRPs, segments don't matter at all.
>   */
>  #define NVME_MAX_SEGS \
> -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
> -	    (PAGE_SIZE / sizeof(struct scatterlist)))
> +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))

The 8 MiB max transfer size is only reachable if host segments are at least 32k.
But I think this limitation is only on the SGL side, right? Adding support to
multiple SGL segments should allow us to increase this limit 256 -> 2048.

Is this correct?
