Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3992F5B;
	Tue, 18 Nov 2025 05:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442210; cv=none; b=VsSOik8/menoLCWqpW4zc7m7Lx3kaIj+GdCC11hEHfQwccr5oDSxK2Lti4DdnZljJExdLp+VwAp8xL6tUP0ZPWI1iyBwGMrar/BYdpm/BZVTVh9Xifu7HNLfR7ynCXPbVsY30CoBVA7LM9zjeYb+SLdGFz/N2av+Y4DvRwIYdwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442210; c=relaxed/simple;
	bh=th+y1fo3MvZY2H3zw+RLSTbRt53fuB5Qk4b/r5+M1uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYKkJagoQ82AlEvzD4ou6NTGrNcJIYtUyJ83mqQXv1c1BxiHx+1+cU073scRNc9rrrBz08GXjIdB0c+hE1P/u15KacD/bUDmgaZ5tq++NjM9rze2bOBNJts0hwOZ1e6OrstqnLERm53SACZkemdLGjKbHd53YmA47zQPYkDZh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1063227AAA; Tue, 18 Nov 2025 06:03:12 +0100 (CET)
Date: Tue, 18 Nov 2025 06:03:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to
 handle larger sizes
Message-ID: <20251118050311.GA21569@lst.de>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com> <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This patch changes the length variables from unsigned int to size_t.
> Using size_t ensures that we can handle larger sizes, as size_t is
> always equal to or larger than the previously used u32 type.
> 
> Originally, u32 was used because blk-mq-dma code evolved from
> scatter-gather implementation, which uses unsigned int to describe length.
> This change will also allow us to reuse the existing struct phys_vec in places
> that don't need scatter-gather.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  block/blk-mq-dma.c      | 8 ++++++--
>  drivers/nvme/host/pci.c | 4 ++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index e9108ccaf4b0..e7d9b54c3eed 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -8,7 +8,7 @@
>  
>  struct phys_vec {
>  	phys_addr_t	paddr;
> -	u32		len;
> +	size_t		len;
>  };

So we're now going to increase memory usage by 50% again after just
reducing it by removing the scatterlist?

