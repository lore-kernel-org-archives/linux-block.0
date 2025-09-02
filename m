Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104013314C8
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823814; cv=none; b=PzLBZJCFqHkqVQtWM5+irWORx2uVV3Ecvj2WLAhMLA8VtH9mtfmZj3ZI39PrGMYy43RsT3D/uBPRR6FEczp2UukzH+RfVTwldRe/kPo7cF8B9eHjSx2tr229aZv1eQ8uSUpCuFVj2k7GLR5wiqp3WJoh6iUYq1f9+VKVmZPmnUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823814; c=relaxed/simple;
	bh=cn3LtgfpnA+smc7XsesC+rM3Kfu7yDWpL5KCuGBwqK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWhqeUJZl9B85Q05CosvIJA4Woh/55IsmmLlUWn0agc33LddaE/6LWnV3l0FRM7Hlz0fFe1eyr6j9zSJexchgJ/FPHp+qjtdc6sZqPsRf2ET1jhxKGficnHHd0JFW/i3rTbIIkdnt91jEEIb7UHipkAjM8dYd3msVgoy+SR4aZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYGKWjYI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYGKWjYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA73C4CEED;
	Tue,  2 Sep 2025 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823813;
	bh=cn3LtgfpnA+smc7XsesC+rM3Kfu7yDWpL5KCuGBwqK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYGKWjYIcXbhb5YFAXoVsPdyDXuWE3zebzF/XOqN5TGe7KuzAHam4xHRrBqYgHc/c
	 3mFkseja3ogqbQe9zi5lFWtVaRcZArMHbHFLTwU/QMLXYlpFF20++yY3pjYdRiNnSE
	 nKlAqIICTfFDVZ2JfkR++DGoFOMbIGlCsrBC+1wKDOfv84i7KYxM0xqCqovLlL1vjg
	 533sVizehfOpq/hNf7Fw+BDd3O9BqOaChhQ0V1gnaScKtdt4RUBmzEOgzh2YXjDYWW
	 cRrbJchP/EoIELP+VV3GM0BuuX0M+iJvIEXQtf0Z5V4hCaYPTUuOaswdZsZrS5fB09
	 4J199KGIgVMlA==
Date: Tue, 2 Sep 2025 08:36:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	martin.petersen@oracle.com, jgg@nvidia.com, leon@kernel.org
Subject: Re: [PATCH 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <aLcBA-Z8yZ44t4ZK@kbusch-mbp>
References: <20250829142307.3769873-1-kbusch@meta.com>
 <20250829142307.3769873-3-kbusch@meta.com>
 <20250902053358.GB11204@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902053358.GB11204@lst.de>

On Tue, Sep 02, 2025 at 07:33:58AM +0200, Christoph Hellwig wrote:
> On Fri, Aug 29, 2025 at 07:23:07AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > We only need to consider data and metadata dma mapping types separately.
> > The request and bio integrity payload have enough flag bits to
> > internally track the mapping type for each. Add flags for these so the
> > caller doesn't need to track them, and provide separete request and
> > integrity helpers to the common code for unmpaping. This will make it
> > easier to scale as new mappings are added without burdening the caller
> > to track such things.
> 
> We are actually about to run out of REQ_* bits with the current
> encoding.  We could shrink the space for REQ_OP_ a bit to create
> more, or try to move some flags out into BIO_ flags (like
> REQ_ALLOC_CACHE) or kill them by looking at pointers instead
> (REQ_INTEGRITY), or by overlaying flags that can't be used with
> the same of (REQ_FUA vs REQ_RAHEAD vs REQ_UNMAP for example).
> And maybe we can come up with a more coherent scheme for
> REQ_PRIO / REQ_BACKGROUND / REQ_SWAP and maybe REQ_IDLE that create
> another priority scheme in addition to the I/O priorities.
 
Sure, but can we do that effort separately from this? I'm mainly trying
to align with Leon's DMA series that adds REQ_MMIO so that we won't have
flag conflicts.
