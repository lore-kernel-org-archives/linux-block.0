Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FD031158C
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824860; cv=none; b=HHRo+p1WjPoXgGRtv65OQvmvKjkH3ImmxCjeDelSDfp45LPpjVYmBY4qXGnUcZePY0LZ5mNUwMctnwOU1IVkW0ASeHUAQ3bjnHbzXgDiUo29CqSauEt9GXKj9iwUh1jGjB/EfTMbauSHJrE/QJ+SV2c9j5QWw955PUTnCCV5oWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824860; c=relaxed/simple;
	bh=t0vNZIT2/nPB3n2F/JxbUMmEGCau5sSHsOKd/pb6yaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTrd0OA6pUmAtGyQyFFmHuzy4pl8D3r8xhmKy+SXetBhsiG6q/RK9LEu/sblgUqgMTIDeZHmaUa8H9t7U3wNxOuRM8q9Nj5PAHJaYsrCi/MNqFuscDbxXCvZUzuO75zjG94UGOsZ3bdx8MAW4G7OsTc1j3l+GuaBtn4ziLkA00E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CCD7D68B05; Tue,  2 Sep 2025 16:54:10 +0200 (CEST)
Date: Tue, 2 Sep 2025 16:54:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, martin.petersen@oracle.com, jgg@nvidia.com,
	leon@kernel.org
Subject: Re: [PATCH 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <20250902145409.GA13103@lst.de>
References: <20250829142307.3769873-1-kbusch@meta.com> <20250829142307.3769873-3-kbusch@meta.com> <20250902053358.GB11204@lst.de> <aLcBA-Z8yZ44t4ZK@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLcBA-Z8yZ44t4ZK@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 02, 2025 at 08:36:51AM -0600, Keith Busch wrote:
> > We are actually about to run out of REQ_* bits with the current
> > encoding.  We could shrink the space for REQ_OP_ a bit to create
> > more, or try to move some flags out into BIO_ flags (like
> > REQ_ALLOC_CACHE) or kill them by looking at pointers instead
> > (REQ_INTEGRITY), or by overlaying flags that can't be used with
> > the same of (REQ_FUA vs REQ_RAHEAD vs REQ_UNMAP for example).
> > And maybe we can come up with a more coherent scheme for
> > REQ_PRIO / REQ_BACKGROUND / REQ_SWAP and maybe REQ_IDLE that create
> > another priority scheme in addition to the I/O priorities.
>  
> Sure, but can we do that effort separately from this? I'm mainly trying
> to align with Leon's DMA series that adds REQ_MMIO so that we won't have
> flag conflicts.

I was just thinking out aloud how we could reclaim them, not trying
to take that on for this series.
