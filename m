Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1997DA7F
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083750; cv=none; b=OQI1aAtAotJD4RkGF/buOqIdzE8gHy38vLdZnoBvgkBKnYPAHv6p+7nGx8bqfKXUGcJN2cWXrF7eKxkV2IPhckm/TuDKCrogkxoQ2aoDHveA1SKRyUPReiHlQnh2NyvPljUGD0H9VclQYHXuv0iwWmSo5h7oNW+fIg99bdlQhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083750; c=relaxed/simple;
	bh=rd373gGF4+XCak4hs/mWAi0XWWY9mVYyzY1VmIeTVPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fo3fyGP/1gOd4tWKQ2oOWv6df739c9GPyPBvqUtODm7XWaNHZHanp+nAQmwLPaidxnowzTOzYcM9mIDPwMoRdsHf2n/YTmKvTpkSY4y+y6ZGDe3JFQ61zJ2kkENj5d1IOZCbLf5CIBa/B7aHAy1A9LwElio/EOqfviA4NQrEbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C69068B05; Mon, 21 Jul 2025 09:42:24 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:42:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/7] blk-mq-dma: move the bio and bvec_iter to
 blk_dma_iter
Message-ID: <20250721074223.GF32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jul 20, 2025 at 11:40:34AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The req_iterator just happens to have a similar fields to what the dma
> iterator needs, but we're not necessarily iterating a bio_vec here. Have
> the dma iterator define its private fields directly. It also helps to
> remove eyesores like "iter->iter.iter".

Going back to this after looking at the later patches.  The level
for which this iter exists is only called blk_map_* as there is
nothing dma specific about, just mapping to physical addresses.

So maybe call it blk_map_iter instead?
