Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E641F4CA9
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073507; cv=none; b=B+oSPEPgPowPi+FXnRh2zj6ImOlNNEKr0751s7jKO2xxqUjn4opS9v3OX8O2LTaOZpL2Xea0JSbZbUEOZIncaNUBvui2pIFrSRtX+8PZFDggJ5cmgvHmYX6cEHXZLtDwLpx1hDHnZxt3xOvb8zV6A/S5LXA7XU8MUkbpgQj+AP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073507; c=relaxed/simple;
	bh=QLjqXRO2pLS6IpfRJwooTzHzKVto59vwBs+ArnSYJKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwy2+p2YX+ilzQFt4Uv3JAsxylmMwV/9IhvnC+vJA6ArKF3hZlSJpogMjWNv10eWFqkiRwohUqiavM54199wBUmU/mcjw6ep26g+fh6sQq+46P4+AEooQscHHji2i6cft9KEE2WfvJU03rnzxlbtWfEmUPKhozkAKFIKLfjmSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2FC0367373; Mon, 16 Jun 2025 13:31:41 +0200 (CEST)
Date: Mon, 16 Jun 2025 13:31:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
Message-ID: <20250616113141.GA21749@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-3-hch@lst.de> <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org> <20250616050247.GA860@lst.de> <2105172c-5540-40d0-9573-15001b745648@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2105172c-5540-40d0-9573-15001b745648@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 08:43:22AM +0200, Daniel Gomez wrote:
> >> This comment does not match with blk_rq_dma_map_iter_start(). It returns false
> >> and status is BLK_STS_INVAL.
> > 
> > I went over you comment a few times and still don't understand it.
> 
> The way I read the comment is that status is only valid when
> blk_rq_dma_map_iter_* returns false.

Yes.

> But blk_rq_dma_map_iter_start() can return false and an invalid status (in the
> default switch case).

The status field is valid.  Your patch below leaves it uninitialized
instead, which leaves me even more confused than the previous comment.

