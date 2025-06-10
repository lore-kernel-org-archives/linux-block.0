Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4828D8FC
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559899; cv=none; b=cl+3/9Ou8WWiBdLFLjW1H9WkLmqZEFIWnkVB7l1OzZLGflZa673nUqGyiC1Z74ugyXpJHPXH17raYTmVFfkHps60gS1gC9hfho3d4gebYydx8OIOkvOWSQq2dqDIkNzdlEqg84wYhseU53zdFbXdpFkgT8LJiVEuqDDSgOXy8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559899; c=relaxed/simple;
	bh=GrM7bg2VX6XUBKa3sIuRKNEdiNvsK86ggN+WUT/jQZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPq0VoPeXDpAP7cAI1vcnXO8mpEggYCinDO8gUP6/iXHFe8iilV4p1woHyEaQuRKVF/5aZa9gMww39GPQaFTCJnZiwcxaj/XQhTDbJ/WHC55WfuoWlx/rdKh0YGjOG6ThwzvTiRfup8xZmn2eyhkUQXdxsQHhcXx2L2w4lA4yTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spGtxHrD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spGtxHrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E995C4CEEF;
	Tue, 10 Jun 2025 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559899;
	bh=GrM7bg2VX6XUBKa3sIuRKNEdiNvsK86ggN+WUT/jQZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spGtxHrDx/PR/l6qp0k5nSElh8ajrOeR4lddLvFV2Ghngz0w/6t53aBK+i4IirQbv
	 WT/52IjwM97jLvD4wPbVbv8pzAq/pa0RpKltLQXFVDzhOQdgV/Tb4mccDdfiLGQWWJ
	 xEmlqwkduEZrJNu1sTzWrWab1ZAVHJhQQyrUl1QJoTMFWjPc0TPfkaNrf/r8HBE8Eh
	 v1VTSDV3cYCQtvaLEk9xirzcArds4pniUOGeMPkMD1uFdI5vDugGsSy1LgI9xfnIre
	 IgpOjN2zqRQjTkz7sAI8uyONhB2M7/NrxTGq5RAzjbSM7FSCmVtd2N4ya9SfGLQRNT
	 6GCoAj1J1Ibbg==
Date: Tue, 10 Jun 2025 15:51:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
Message-ID: <20250610125134.GD10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-3-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:40AM +0200, Christoph Hellwig wrote:
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
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq-dma.c         | 162 +++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq-dma.h |  63 +++++++++++++++
>  2 files changed, 225 insertions(+)
>  create mode 100644 include/linux/blk-mq-dma.h
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
