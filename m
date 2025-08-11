Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5A2D320E
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919055; cv=none; b=nsOiXrks6vVh/qA+7HELj88JaIQpcsirS+EZYy8JKdz28vY4Zi8oFxB1X/RyxbDLP6TpS7F0vZOqGyazyI3GilfRKwUdc/p9KzRGM8iHzY/wUn5ehhx0bQT9MVqkFOmQQF/NtBCjoNtSQZ/SWnIBcaTvWCNNf/O4HmS42H82AXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919055; c=relaxed/simple;
	bh=wZjCh8XlQL32DPQm8fd7YqWZa/4AL5hrwFmnrWSDD78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/Q2/f1pCKMDzNq5RNbd+asXaUzRhXpPbr8ChVa0RdZ5WjAnYi9oPhOA4se3DQnoc0XfJQTc1Rb9DxJYg+EVyHGE83LQQdwL1AjJCEnPoMVPYQI48Ta3y1IIgExzhSUGjGSD2z/mjyPTuilhIbdlMoFWQipgFH2xiWH6yKATE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZJra/xF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZJra/xF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89B2C4CEED;
	Mon, 11 Aug 2025 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754919055;
	bh=wZjCh8XlQL32DPQm8fd7YqWZa/4AL5hrwFmnrWSDD78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZJra/xFTZZUYA2ye35yT03O3yRf7zdbDk/qD0SUM10HA/zsiMhXFXL+GmwH0xUWC
	 nUX94uoMGxW7dw+UefsARCMkdmxgpaw/b92IlU6bbVlPm3VIE9VMao1Dzwf1iMh2tI
	 UWs4KBLOOHZyVjAbHjrdHZNihbkFMV4bv2W0eZiswFxD1P9fOJY+7inG0FJW92ncdR
	 n1CJeXqVNldYBJwfEqK8SolLz8A0M/cfdXUMVt62b+o/IOOGNLrSEamrv2ydlh1KWT
	 QSChZwmrAODvtk2q0WZ/xSEkpct8bsxJpdwlAf2PBD5Yt1U6I4G4mEgUsqyPiGzTsF
	 Mbe6QbADDF9Og==
Date: Mon, 11 Aug 2025 07:30:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	joshi.k@samsung.com
Subject: Re: [PATCHv5 1/8] blk-mq-dma: introduce blk_map_iter
Message-ID: <aJnwjVm7tTJwoQhj@kbusch-mbp>
References: <20250808155826.1864803-1-kbusch@meta.com>
 <20250808155826.1864803-2-kbusch@meta.com>
 <20250810140448.GA4262@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810140448.GA4262@lst.de>

On Sun, Aug 10, 2025 at 04:04:48PM +0200, Christoph Hellwig wrote:
> > +struct blk_map_iter {
> > +	phys_addr_t			paddr;
> > +	u32				len;
> > +	struct bvec_iter		iter;
> > +	struct bio			*bio;
> > +};
> 
> This now mixes the output previous in the phys_vec, and instead
> of keeping it private to the implementation exposes it to all the
> callers.  I could not find an explanation in the commit log, nor
> something that makes use of it later in the series.
> 
> If possible I'd like to keep these separate and the output isolated
> in blk-mq-dma.c.  But if there's a good reason to merge them, please
> add it to the commit log, and also clearly document the usage of the
> fields in the (public) structure.  Especially the len member could
> very easily confuse.

Perhaps I misunderstood the assignment:

  https://lore.kernel.org/linux-block/20250722055339.GB13634@lst.de/

I thought you were saying you wanted the lower (bvec pages -> phys
addrs) and upper part (phys -> dma) available as an API rather than
keeping the lower part private to blk-dma. This patch helps move towards
that, and in the next patch provides a common place to stash the bvec
array that's being iterated.
