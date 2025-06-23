Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D234326D4ED
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693402; cv=none; b=WW8WjQ2ln2vJz2D3LXaaCznkYu3o2K70Ab6/VzjuGWjefDnzdv4LoApYASzf53xjbj9gs1FzLDjyhyllu14sqk3kRtzPS9qb2v12Gh761wPO93Idl2B6CPkGYpx7vBqhSrRFjGhsAWgN/Uv8fvus5LCd/8mbcTomx77Bpmd3qUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693402; c=relaxed/simple;
	bh=VcRWjYMSJw03/dks5fmNXEVRgkYNfRhBtD8HoaYy0Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3gSCWsOkVToZq4az4zM58QJbPYOi5f8pxPo8Cg2MZojBuBtiXSStNSEJZ5aaYgyMLmllZXu6jSVpo5y5DHfmzwhMqqEDdbYmhyl+p9dxxN8N1ub010zXU01TNrwQ302kEZElReEhTDchFSJNA2pBtl4Jgn75N2gFspHGlkv/rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh2Ue8Oo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh2Ue8Oo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8E1C4CEEA;
	Mon, 23 Jun 2025 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693402;
	bh=VcRWjYMSJw03/dks5fmNXEVRgkYNfRhBtD8HoaYy0Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zh2Ue8OomNtBloDplx1kd1zOkpJ09KIl7feACNXNxKEdjIIFp4qb/K2eJrW+u5O4S
	 wvSDh55jisc21Yk8eA02p/2rZeuasIUk6iwxis4sE06dqr6TJoEbBmKwMGffl0H9Ur
	 ld6FusCNzzP5pW9VCjQ547CtlMe+B7NOn+hduEwgTKQWA/lVQKl0VoNdevTqzgei7p
	 mAhC3BR1PdbnW1aoUAZMyNcJamI5sJY0C7T+9wvRucjYbYZEXJ4wyKQwX4j3buZy9X
	 w5ji8fYeNp1ihS8mrk/mImaRwnNqMTBx3/ugTrRfojLEh6FN44bQrYjRViC36T5dx7
	 akO4ZVqqvaE2Q==
Date: Mon, 23 Jun 2025 09:43:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 2/8] block: add scatterlist-less DMA mapping helpers
Message-ID: <aFl2GJskYNdvZDDo@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-3-hch@lst.de>

On Mon, Jun 23, 2025 at 04:12:24PM +0200, Christoph Hellwig wrote:
> Add a new blk_rq_dma_map / blk_rq_dma_unmap pair that does away with
> the wasteful scatterlist structure.  Instead it uses the mapping iterator
> to either add segments to the IOVA for IOMMU operations, or just maps
> them one by one for the direct mapping.  For the IOMMU case instead of
> a scatterlist with an entry for each segment, only a single [dma_addr,len]
> pair needs to be stored for processing a request, and for the direct
> mapping the per-segment allocation shrinks from
> [page,offset,len,dma_addr,dma_len] to just [dma_addr,len].
> 
> One big difference to the scatterlist API, which could be considered
> downside, is that the IOVA collapsing only works when the driver sets
> a virt_boundary that matches the IOMMU granule.  For NVMe this is done
> already so it works perfectly.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
