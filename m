Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B52EDD57;
	Mon, 20 Oct 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950613; cv=none; b=YZ9PgA4nmeRE17IpoGHK2NSbFsm4+DOy2a+KVLx6OlYhyxXlzWY8u48KFdnY8PFpPel4ErJpALIcaIwgCCRxQua24wg5sYH2pFyJrnHejLxDR6bTVWeW+kHTvIHrX3tHVflTyI2mjByfV/aLSwKuUngGwk7S7ChJIHm4hPKr/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950613; c=relaxed/simple;
	bh=w3aN04Vk00eSSY6/KDz0bmiTPKv0E4MFFtWbbIJG2ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNH/9evucx5XIP2rmqMmka6J9+8IwzraT6gHgkqp7QcsfzyLx1OXpfyMtMxu2lBjidRE8Lv5/SxfjnxqL7qOAS+sLdZVbvlcTQ9yAGQFT4cdOsU8Coifp5fKlZPXL7HJVa8GHwsLuuMJni0pVeN37wjxqNla2HwkcUpl/ButB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGtVZs1N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGtVZs1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6364FC4CEF9;
	Mon, 20 Oct 2025 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760950613;
	bh=w3aN04Vk00eSSY6/KDz0bmiTPKv0E4MFFtWbbIJG2ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGtVZs1NZUD5ltfaM/YJEP8EBJGa3FUsfLXutwYH5E5wwBCLZrEsHbJiIL2xHpIVc
	 5S07RgueFcq57rbhB5AeeyZCnz7jSQz87n/d2S6QTx9SL7qjYSzrC5WVGwiHy75KTA
	 YBPjZhLEQeblnxlZX2xjmgE8oBcvPBKHBaEwTYA8ZOkzGHWbaOf7uHiIrt0+SuLVSR
	 HVCQm0a/2MpByvLvQn0vp2Ao3Mp9G5ua8wqdKNJSoQHfgIIvXlu6MkXH6s62bCZXMp
	 hgPQfVzppPNG4Q3U1n5Cz2RJo8PhBNSg/29tL0WUr5WDb83JHaYuUqJGsNnpwaL/mg
	 Nun/9VsKt1BhA==
Date: Mon, 20 Oct 2025 11:56:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] block-dma: properly take MMIO path
Message-ID: <20251020085648.GN6199@unreal>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
 <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com>
 <20251017062519.GC402@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017062519.GC402@lst.de>

On Fri, Oct 17, 2025 at 08:25:19AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 08:32:00AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Make sure that CPU is not synced and IOMMU is configured to take
> > MMIO path by providing newly introduced DMA_ATTR_MMIO attribute.

<...>

> > +		if (iter->iter.is_integrity)
> > +			bio_integrity(req->bio)->bip_flags |= BIP_MMIO;
> > +		else
> > +			req->cmd_flags |= REQ_MMIO;
> > +		iter->iter.attrs |= DMA_ATTR_MMIO;
> 
> REQ_MMIO / BIP_MMIO is not block layer state, but driver state resulting
> from the dma mapping.  Reflecting it in block layer data structures
> is not a good idea.  This is really something that just needs to be
> communicated outward and recorded in the driver.  For nvme I suspect
> two new flags in nvme_iod_flags would be the right place, assuming
> we actually need it.  But do we need it?  If REQ_/BIP_P2PDMA is set,
> these are always true.

We have three different flows.
1. Regular one, backed by struct page, e.g. dma_map_page()
2. PCI_P2PDMA_MAP_BUS_ADDR - non-DMA flow
3. PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - DMA without struct page, e.g. dma_map_resource()

There is a need for two bits to represent them.

Thanks
