Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB151277CB8;
	Wed, 12 Nov 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961003; cv=none; b=MlZO8SJk0Qi6DtEfdiMo3ij87mKX2zj7tfq1CuwJ7+8w/P327QzUEDBmhySp1glFkeFO7VtvaYl6WsXti9htK/04VL79sOx56WsZgGOeew1PDvILBmyR1yGyvjNEM8NfHaSF1jp3hUCaD3HdrZb0PP5zsubKi7TUoXDOwfawgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961003; c=relaxed/simple;
	bh=R68lyaKZuVdiD0o54Fj+yYa5Ky9uRQ3jNdQoHZ6wcYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSH5nKqsJ5qXoIAzeQXrKDxxE2sbYRUtx4Z/oEmM9i18nTgdUPh5ySU/z7i278NFDDdwj8K5NuVwFYH6pTCDnOTrgghqXz/Razk0gD9dLve4UvZBt4rpJcX05Y5cZ+ZODi8Wy0RNKYGAHQXJD1T+1MHeDjTuk5aKnKqRIy6CPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXvh2aY/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXvh2aY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E66FC4CEF5;
	Wed, 12 Nov 2025 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762961002;
	bh=R68lyaKZuVdiD0o54Fj+yYa5Ky9uRQ3jNdQoHZ6wcYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXvh2aY/29WbplAxXgCKqpBoHSFrIZsLF14u/GH2RNc2nvmjhsNFyHhoDKqu8SjKt
	 7SLpjGixVVKsWks/qOXJEIa6jFmdeq2Fg5FxkjWZQMCSmWAkPta6dcYn6EtuaYiROT
	 oxCx8HLP4TURdJLrTsZfYlFISg1dhgxGtiXrSgaj4Jplf6Pyxwpe0MDeLWqhWT3oC2
	 A8i5L1MDaYazR35NjIwgzWj7Y8ys7/C67wK+mfQpnVZ2DYHKksAV6bvRVbJVpN6aD0
	 8kG7hlQpqbbT7Ht2ju9vtDV/zFnVK9cMsRrOMltCezhNDJDq/QtMHoISbkWisYWX0v
	 9EhQVaE3OuWbw==
Date: Wed, 12 Nov 2025 10:23:19 -0500
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] block-dma: properly take MMIO path
Message-ID: <aRSmZ6IisXDmI9Yg@kbusch-mbp>
References: <20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com>
 <20251027-block-with-mmio-v3-2-ac3370e1f7b7@nvidia.com>
 <aRSbzwpS2AuP92_n@kbusch-mbp>
 <20251112151604.GF17382@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112151604.GF17382@unreal>

On Wed, Nov 12, 2025 at 05:16:04PM +0200, Leon Romanovsky wrote:
> On Wed, Nov 12, 2025 at 09:38:07AM -0500, Keith Busch wrote:
> > On Mon, Oct 27, 2025 at 09:30:21AM +0200, Leon Romanovsky wrote:
> > > @@ -732,13 +746,20 @@ static void nvme_unmap_metadata(struct request *req)
> > >  		return;
> > >  	}
> > >  
> > > -	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
> > > -					iod->meta_total_len)) {
> > > +	if (iod->flags & IOD_META_P2P)
> > > +		map = PCI_P2PDMA_MAP_BUS_ADDR;
> > > +	if (iod->flags & IOD_META_MMIO) {
> > > +		map = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> > > +		attrs |= DMA_ATTR_MMIO;
> > > +	}
> > 
> > This should be an 'else if' no?
> 
> We can't have both IOD_META_P2P and IOD_META_MMIO. It can be only one or
> IOD_META_P2P or IOD_META_MMIO. In this case "else if' is not necessary.

I get that and I'm not saying this is a bug, but it just looks odd.
You're checking the conditions as if they're independent of each other
when they're not. If the first 'if' is true, there's no need to test the
second one as we know it's false, but this code flow will test it
anyway.
