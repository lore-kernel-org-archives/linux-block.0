Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FA719CCF5;
	Mon, 13 Oct 2025 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384073; cv=none; b=JPX6d9gpudKpG7dhU60ro/2+vqnkgsUsTAWGnK7PUWzDUEjtfYQSov8OiGJU9jfVfnrWeFcrdU414h8fnBeQtVij3bF0G9nWr054LGFsR28ztSxUipGlf3w3PWiuSpO92MZDtBjKJenrm+JJscoHB7MZ6eQL3Ya9M9hMRtyjIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384073; c=relaxed/simple;
	bh=7KebO7qMBUi4ynKKJUC5JxpmX0egvUjIKJ5fNHDrHTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtikx3+wqr+P++R2A38pl5ctcZUjnrtvjXBlQMZjX5k6hoISbN92xJP/Xjm0i8ZoLDkZU2HfgHUMBQRpkRZDHkoyV4MU6gT6mycOs8jQdOhQUCLwvg9tu8ASEhwBFMIQ1odYbw4L/NS/f8V/q2QTayfdS+CspJSMkGOUxOlOk3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGDLXz4q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGDLXz4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DD2C4CEE7;
	Mon, 13 Oct 2025 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760384072;
	bh=7KebO7qMBUi4ynKKJUC5JxpmX0egvUjIKJ5fNHDrHTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sGDLXz4qgVQ4ccV3AQZfLjKfRMJwh62Utb6Gms8YvC9UROIq8aEcAGlPhfibZ1hlG
	 2GHTZaSEX0a3+poTuwTTUiG34WC0HHw/mTPyn1SY/5fr2+JSXtnN4JHoMONa1FXzXY
	 dS7YH0iAsDVUyxmgc/AeNZV0haSHyTQovHNdwBvkMnqJI+xTMot+qSWSruy772abPO
	 38F667TOJH3FxAZE+E0uLO5ZyAudmXnzKi95BpHhXQTeQ9quI7pHXyPVM/MfBsmU5n
	 Yiwj/fGi6f2gCTKzJwVJK4EY+vINQmk53o6aLp9zRrUsywf2KnYIajvSq6pcjPIIsb
	 0O2878r5cyxGw==
Date: Mon, 13 Oct 2025 13:34:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] block-dma: properly take MMIO path
Message-ID: <aO1URj3B3IUHX4Ge@kbusch-mbp>
References: <cover.1760369219.git.leon@kernel.org>
 <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org>
 <aO1MfsuWeteOsBve@kbusch-mbp>
 <20251013192940.GC14552@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013192940.GC14552@unreal>

On Mon, Oct 13, 2025 at 10:29:40PM +0300, Leon Romanovsky wrote:
> On Mon, Oct 13, 2025 at 01:01:18PM -0600, Keith Busch wrote:
> > On Mon, Oct 13, 2025 at 06:34:11PM +0300, Leon Romanovsky wrote:
> > >  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
> > >  		struct blk_dma_iter *iter, struct phys_vec *vec)
> > >  {
> > > +	unsigned int attrs = 0;
> > > +
> > > +	if (req->cmd_flags & REQ_MMIO)
> > > +		attrs |= DMA_ATTR_MMIO;
> > 
> > Since data and integrity paylods use these same functions and may point
> > to different kinds of memory, I think you'd have to pass the 'attrs'
> > from the caller since it knows which flags to check for MMIO dma.
> 
> I think that hunk will fix it.
> 
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index 38f5c34ca223..8af88ba97c7a 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -88,9 +88,11 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
>  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
>                 struct blk_dma_iter *iter, struct phys_vec *vec)
>  {
> +       struct bio_integrity_payload *bip = bio_integrity(req->bio);
>         unsigned int attrs = 0;
> 
> -       if (req->cmd_flags & REQ_MMIO)
> +       if ((!bip && req->cmd_flags & REQ_MMIO) ||
> +           bio_integrity_flagged(req->bio, BIP_MMIO))
>                 attrs |= DMA_ATTR_MMIO;

If cmd_flags has REQ_MMIO set, but the integrity flag doesn't have
BIP_MMIO set, you will skip setting DMA_ATTR_MMIO, but I think we need
that set when this is called for the data payload.
