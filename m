Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77127057D
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791245; cv=none; b=gwb1eocDfamxo15jS7QbmPPLHJV5yHberHvbQkim+WsF1eS4H31qKGI469ik2jdtpQRNZLTP+6ERqeLxd3IYsof451prEBTjqgGJgsZJHzxWe1MLG8pQTUr2hFX6t47vPmjRIOVsyovEStykST6iBubGoorehajTBcSUYdVH9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791245; c=relaxed/simple;
	bh=hjXyi40Ofwirgc7PeeU6nZCvGlRk2Sz+VSE8yq3WvgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWKZBnU7izKu9J5/yvqtfGRD4Yl7g7WHvxpBxrWjUOytwCTm2Zr9XVMqhaPktjt2yW8KWkSGA5xpUXvlpnLT6XH63opZRwB3pEI4HGKRwhgv8GEdAo9azBnR+jqVe19ZEan3u9sEAec1iEp4A/5V+vugcnqfgT+OUxM6xnVOu/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DD2B68AA6; Tue,  2 Sep 2025 07:33:59 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:33:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, martin.petersen@oracle.com, jgg@nvidia.com,
	leon@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <20250902053358.GB11204@lst.de>
References: <20250829142307.3769873-1-kbusch@meta.com> <20250829142307.3769873-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829142307.3769873-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 29, 2025 at 07:23:07AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We only need to consider data and metadata dma mapping types separately.
> The request and bio integrity payload have enough flag bits to
> internally track the mapping type for each. Add flags for these so the
> caller doesn't need to track them, and provide separete request and
> integrity helpers to the common code for unmpaping. This will make it
> easier to scale as new mappings are added without burdening the caller
> to track such things.

We are actually about to run out of REQ_* bits with the current
encoding.  We could shrink the space for REQ_OP_ a bit to create
more, or try to move some flags out into BIO_ flags (like
REQ_ALLOC_CACHE) or kill them by looking at pointers instead
(REQ_INTEGRITY), or by overlaying flags that can't be used with
the same of (REQ_FUA vs REQ_RAHEAD vs REQ_UNMAP for example).
And maybe we can come up with a more coherent scheme for
REQ_PRIO / REQ_BACKGROUND / REQ_SWAP and maybe REQ_IDLE that create
another priority scheme in addition to the I/O priorities.

