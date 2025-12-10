Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E1221FCA
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765349654; cv=none; b=uhtxV3tN2VZYNmIAli2nxpZNtFUDLM+SskmXjLEynNj8t9khoo1f8AMZ+d8wzouuvW8VRdbvr2M+zX2lvIA6AO/sfwmXaqlvVlkRkTkycqLXWkrgBbNZbpPUflYhKkYeEhosTWSYV1WK5oivGFrMgVNudPocNUgCvr0zwn/EqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765349654; c=relaxed/simple;
	bh=YTaMP+bLZZf1C49KSlHUEHbFCxHYIE/8EPZhCUnvcKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkOS0VCc7RmMGxqMvS/kISIe8D6BeCBA3F1ngxjMGyJO4jGgz9L+K8/UbmeuIBHAGEW1fRnwmzLXv5VdQVmXAcVBsi6p+4D+kRxRXGM6+v5rpHcgdtSQNxHpMv9gGQbAh5+/YVyriGy8sKcTIwW+aGrgY91O5DHGMEKS7AFJakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A3A9E227AA8; Wed, 10 Dec 2025 07:54:07 +0100 (CET)
Date: Wed, 10 Dec 2025 07:54:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, Sebastian Ott <sebott@redhat.com>
Subject: Re: [PATCH] blk-mq-dma: always initialize dma state
Message-ID: <20251210065407.GA650@lst.de>
References: <20251210064915.3196916-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210064915.3196916-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 09, 2025 at 10:49:15PM -0800, Keith Busch wrote:
> -	if (blk_can_dma_map_iova(req, dma_dev) &&
> -	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
> +	if (!blk_can_dma_map_iova(req, dma_dev))
> +		memset(state, 0, sizeof(*state));
> +	else if (dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
>  		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);

What about just doing the memset unconditionally?  It's just two
64-bit fields so no real overhead, and it gives us a clean slate that
avoid introducing other bugs later on.

