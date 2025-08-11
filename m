Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891222257B
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921164; cv=none; b=mGhoymXbgaiJP34k9JoFEGMb8oJH9iCpipBeUJbj0DqtoVa0B51t9tOtVPxB43rX/IlNN48ZW3biD+cpAxOQldGrB7ImNhb2mdQWjHThwNJ2z/sIR2Zrzv0i6LfqE7TXva568+23df2zmh0plhGQBnYQxuaZXI+WzWizpBX/q/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921164; c=relaxed/simple;
	bh=HDc8elUJkmVeXiuK4Hlg1vj2+rQZV+rKRIxa232WJEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz4TubovfWCN6yWfq0JO1RNKFap951vkj6gs7wk//WwQyka7Q1fELFwuBQ+NQ1CJgFz2Zdke0SqLzgwPLlVi/Lh+WH7tfvjeNko9q+2BtUj5IwhZouv9Q8qoQ7yEQDBi6DyQg7ufFf9RwzXxPL3rTKO70/TFVekXdeRRqIdHDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 258A568BFE; Mon, 11 Aug 2025 16:05:51 +0200 (CEST)
Date: Mon, 11 Aug 2025 16:05:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, joshi.k@samsung.com
Subject: Re: [PATCHv5 1/8] blk-mq-dma: introduce blk_map_iter
Message-ID: <20250811140550.GA19377@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-2-kbusch@meta.com> <20250810140448.GA4262@lst.de> <aJnwjVm7tTJwoQhj@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJnwjVm7tTJwoQhj@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 11, 2025 at 07:30:53AM -0600, Keith Busch wrote:
> Perhaps I misunderstood the assignment:
> 
>   https://lore.kernel.org/linux-block/20250722055339.GB13634@lst.de/
> 
> I thought you were saying you wanted the lower (bvec pages -> phys
> addrs) and upper part (phys -> dma) available as an API rather than
> keeping the lower part private to blk-dma. This patch helps move towards
> that, and in the next patch provides a common place to stash the bvec
> array that's being iterated.

Eventually we might want to make it public, yes.  But that works just
fine with the phys_vec.  In fact Leon has a series outstanding currently
that makes struct phys_vec public without any other changes to this
code.
