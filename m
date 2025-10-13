Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5172472BD;
	Mon, 13 Oct 2025 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383786; cv=none; b=pjuwkY2bxTYP/yDt3UzFQw7UFE0qtej/ZQRKnrN/PmLS45TY/wShxMtogLYV0V6NMj7tnUoapo3oqe4urBv88S44PyqPNzUNjX/BhFYhAnzKJvYzm/h3V3146wVIVuVg3yuYxk2MVfvbQOLR3J0FuCqapofTLUqKsGNOiBjAv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383786; c=relaxed/simple;
	bh=9Ij8SmNLx3ItPq0glCSzcjFttSD8Tgb6RfqIs4yskVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvQRxxTh2gxYaEXjJPWFbpmeeJie1k9K8bgRVm9dUEv88iwFkJ4SMyZy8vhmtqY7ilk/xcfYw/mAe3pnb0d+UTuZmgSUNh0IWY9I2CDYBvoWIJDFvBdIP3V1VqA5/GbVbZeP9IlWuhIHkghIl726c8/n7smjNxZeXftYFaGig2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO6dBNv9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO6dBNv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F311CC4CEE7;
	Mon, 13 Oct 2025 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760383785;
	bh=9Ij8SmNLx3ItPq0glCSzcjFttSD8Tgb6RfqIs4yskVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tO6dBNv9pePmCDLa5Db348i+CRT7zA0wUg0RabPn7tFcQLIWX+HBJJbGFp0Tw0j/O
	 i71pRMWz4UueDrI3iHVmOL5TReq/GPcILgXDFYNlMQD47VQmQi6ungDYkwSlEQb/zx
	 Sa8iNYNBw7JdJ/OcEZeMcwIZSDlJpz0OdXNTea3sQmhiZGfkIS0OQIsaPd7oqgDETy
	 lqQFogyDKaAV6nGdmhxp9daEizjceeXub1uw5P7lOABjYHHWAnPrTXGHdlBooBYRtX
	 mfbN1hDHKOg96kwmrzqP0J41MpawSdyOPIScDgs58hDclkE/UOXDrwqa5pknZUkAfb
	 8zDB7UcLszcpA==
Date: Mon, 13 Oct 2025 22:29:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] block-dma: properly take MMIO path
Message-ID: <20251013192940.GC14552@unreal>
References: <cover.1760369219.git.leon@kernel.org>
 <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org>
 <aO1MfsuWeteOsBve@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO1MfsuWeteOsBve@kbusch-mbp>

On Mon, Oct 13, 2025 at 01:01:18PM -0600, Keith Busch wrote:
> On Mon, Oct 13, 2025 at 06:34:11PM +0300, Leon Romanovsky wrote:
> >  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
> >  		struct blk_dma_iter *iter, struct phys_vec *vec)
> >  {
> > +	unsigned int attrs = 0;
> > +
> > +	if (req->cmd_flags & REQ_MMIO)
> > +		attrs |= DMA_ATTR_MMIO;
> 
> Since data and integrity paylods use these same functions and may point
> to different kinds of memory, I think you'd have to pass the 'attrs'
> from the caller since it knows which flags to check for MMIO dma.

I think that hunk will fix it.

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 38f5c34ca223..8af88ba97c7a 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -88,9 +88,11 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
                struct blk_dma_iter *iter, struct phys_vec *vec)
 {
+       struct bio_integrity_payload *bip = bio_integrity(req->bio);
        unsigned int attrs = 0;

-       if (req->cmd_flags & REQ_MMIO)
+       if ((!bip && req->cmd_flags & REQ_MMIO) ||
+           bio_integrity_flagged(req->bio, BIP_MMIO))
                attrs |= DMA_ATTR_MMIO;

        iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
~
