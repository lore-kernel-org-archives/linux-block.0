Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BF27C15B
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693448; cv=none; b=peltxsPBTj/Bx29BHuUjM98Mfw+dz/DZU5MfKehOf2EGUsBdsRC/JKLaszMiupfPKWb4GHv6GMIIVOKVPpm0/PVPSggIlR0PgxWlEGsu1NolcdnJbZESYcsCshZs5qPdeO7UaeaiG1S7l0kUs+gyNms5Iaxg7SWTcgEfwhifFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693448; c=relaxed/simple;
	bh=OSSbYV4s1eA20gHgWKrDQn++rtQfoP6FQbDvciPIb2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfKjUJJ/fasHGnEZ3owfJUmQ9uSE/pJvarpHw4AgWy1HjNd90tcbQGY95IB4gZlvxFgVMsltJDX9Jb0P8G9ZyHpstS5/5LdGdkkflin5cLN57xHh0msyHMScgevELWofa8H7LunNlNe8aoZC+gPsjHhWn0qG73vYDPiLnOoI6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=po+Ewlzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po+Ewlzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CA0C4CEEA;
	Mon, 23 Jun 2025 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693447;
	bh=OSSbYV4s1eA20gHgWKrDQn++rtQfoP6FQbDvciPIb2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=po+EwlzkjKODiK24Pe5UW52fGQ13j43yKEuP9BMperlgXeqCEvhS8y+YNv0MC22a3
	 8AaOCytka3W+DtMqjVJD6ovYd79eZtha/kkSMBfuPMEUOlYPAsD5mkhwBGHKqKHjZo
	 bXN2wGSEmEvvJXHxg04IbVyknPE2v0SWZ/E6O3UgZXB710xlnbjcKG5798FPi6hcjB
	 RmvBTppWY9DEnOOU+eGgR6oItZLiJ46HbWeTF5+EuQyWEnujcrg0NtfCbVZBO4o8y1
	 5I7zkOVk1xHrTqvQKNuRVoQuOtHWccqvARLxvX6b+Buw8Wg6cd9NEcWw638Kovr8UX
	 KOdTchTKnhluA==
Date: Mon, 23 Jun 2025 09:44:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 6/8] nvme-pci: convert the data mapping to blk_rq_dma_map
Message-ID: <aFl2RWQWaldHce4x@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-7-hch@lst.de>

On Mon, Jun 23, 2025 at 04:12:28PM +0200, Christoph Hellwig wrote:
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
>  - for direct mappings that don't use swiotlb and are cache coherent,
>    unmap is not needed at all
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

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
