Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EB922C339
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073643; cv=none; b=BGVdHbgRWzpW9dnFY+tcg2WuIMVrPEvm40261JCYfpdH1yCEP7LdLfXBYq636799z3dLgqu9deBDKPVPmMBfEZ1KK9nZBwsDO6K1yXXrW2kpRbIIJZuACwsj6Csyp9BJ3phYDincFl7UFXEhsTkQp1S65YhUnDbyvr83cNh8TDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073643; c=relaxed/simple;
	bh=e8ZM7UoDZIwrBcdUL8hHWDY/ji2Idf7l1lN/9mG6CW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xmh7WrsOnaRMGQvBteFi4WiHCU9LqIB/lcHlHPGC5QHP3wGwOlCtplWGsX4WRxngXn/xIGhBw2FAH7uQJB0SoH4Sv/wOYG259xHU4UWrXzJAXLYjkpfG0vxnJqOYtgLzGWUKsvZ4OMwBmZ6ENRt//jHk6so6rhccHQdJKk1EkEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D42D167373; Mon, 16 Jun 2025 13:33:55 +0200 (CEST)
Date: Mon, 16 Jun 2025 13:33:55 +0200
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
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
Message-ID: <20250616113355.GA21945@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-8-hch@lst.de> <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org> <20250612050256.GH12863@lst.de> <4af8a37c-68ca-4098-8572-27e4b8b35649@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af8a37c-68ca-4098-8572-27e4b8b35649@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 09:41:15AM +0200, Daniel Gomez wrote:
> >> Adding support to
> >> multiple SGL segments should allow us to increase this limit 256 -> 2048.
> >>
> >> Is this correct?
> > 
> > Yes.  Note that plenty of hardware doesn't really like chained SGLs too
> > much and you might get performance degradation.
> >
> 
> I see the driver assumes better performance on SGLs over PRPs when I/Os are
> greater than 32k (this is the default sgl threshold).

Yes.  Although that might be worth revisiting - the threshold was we
benchmarked on the first hardware we got hold off that supports SGLs.

> But what if chaining SGL
> is needed, i.e. my host segments are between 4k and 16k, would PRPs perform
> better than chaining SGLs?

Right now we don't support chaining of SGL descriptors, so that's a moot
point.

> Also, if host segments are between 4k and 16k, PRPs would be able to support it
> but this limit prevents that use case. I guess the question is if you see any
> blocker to enable this path?

Well, if you think it's worth it give it a spin on a wide variety of
hardware.
