Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED1724728E;
	Tue, 19 Aug 2025 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627608; cv=none; b=iELMi2GT7Xo6L96p5yF142sC+SfS8r/yqR7cTAzOp4gnAtHmiKm0YERfRRIENWr9NrdyV4XBP3BBraQRtiB41fBazVlluxeqqmsoXs5Rn4sommdu/WBaSm6tmFgFotXRwV9/7+TJAPhvBJPkpP2pfKOoTn0CfsEHzlV9wzx6ku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627608; c=relaxed/simple;
	bh=vJQ95/awDQN15gMxlaXB+Tcfic806+eL4EX36Buoiiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aioAx8Ce/m0wwhskFp81e/y3f44rrU21Y9IMj24JO6mHEJU0MYR0+nYy2g3H09R4vlPKsYd2vlrmNmsh6xFkDA5iFN1tBZsMY4hLK5gd1I42dmiloqVyLUkDACfVJ9nviDje33i2jx+BSAgGRxbTxRM+rdl/edQND659BgJzjYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXjytkUF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXjytkUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0BDC4CEF1;
	Tue, 19 Aug 2025 18:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755627608;
	bh=vJQ95/awDQN15gMxlaXB+Tcfic806+eL4EX36Buoiiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXjytkUFHZiUoUGI84YdHLEqkOvvneMczP1tcgM6yHssC3PZa14NlekO8OwnhQkoH
	 1tKFJyNzeoXibR5866EB9AlD853dT6hX/BHgsXNW4sH7pbBGpZs3bWwj08oPN1sJoj
	 hWrw/W8bx/Ed7fmJOvpwVh//YcUPC4H4piBW1ARVWVGtVpPRrRKbwDEj6sLZPN6zpp
	 WYxb2QFL4WZg9ljpPs9MR4UmpIcWbSmNlEaUUOSNEz9VaSvb+A8MMAVV0hqzSSr9AT
	 hd29ClRf6ZWgUwXusfUehQO9rXf61PDcTKf5hXEkAaN2POaxHzJVqre4wL9NW9YYur
	 pp6mAS1uKCUqA==
Date: Tue, 19 Aug 2025 12:20:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 14/16] block-dma: migrate to dma_map_phys instead of
 map_page
Message-ID: <aKTAVOBp0u6ZSC4w@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <22b824931bc8ba090979ab902e4c1c2ec8327b65.1755624249.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b824931bc8ba090979ab902e4c1c2ec8327b65.1755624249.git.leon@kernel.org>

On Tue, Aug 19, 2025 at 08:36:58PM +0300, Leon Romanovsky wrote:
>  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
>  		struct blk_dma_iter *iter, struct phys_vec *vec)
>  {
> -	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
> -			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
> +	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
> +			rq_dma_dir(req), 0);

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

Just a random thought when I had to double back to check what the "0"
means: many dma_ api's have a default macro without an "attrs" argument,
then an _attrs() version for when you need it. Not sure if you want to
strictly follow that pattern, but merely a suggestion.
