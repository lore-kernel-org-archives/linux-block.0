Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB732FA10;
	Wed, 19 Nov 2025 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563499; cv=none; b=gmyw5A6D2FPgaQ2TaAA9z2Ile+7cnUUXsKWpqDHdM7esokLgYZxYYlvgM+ZudZizheNSGCW88ogNz47vvjDuvigO5TFXRYpGAHics4EzXs9j9VX9bSElIAD4h+8xH/XCW1d4/sIKENeI1EBjlWlWQKwQH5pum8Np6PvgATgdhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563499; c=relaxed/simple;
	bh=8VS8aG0Ml+tlomReLo+mvEAE+QAcyleX7yGJ+roLEpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiDkRL5FrA36zgalBOezABMiD/PJIrBw3mkuni75/eXW1ACJ18bGC2Jng5laUA+P3femuLLIDzKemliBUu7mvAiPcjVZWp3Et8u37oHUT6sHgCkG2Y7+ubSY/oupkB2Ambzx3sGTyGy4lUfbXBdKLUYBMmXK2RGqMyfcYI0n+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqjE47m3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqjE47m3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B231EC4CEF5;
	Wed, 19 Nov 2025 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763563498;
	bh=8VS8aG0Ml+tlomReLo+mvEAE+QAcyleX7yGJ+roLEpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqjE47m3hZL12U5KCPY0FxdOzOIj1HJu2mx/X4e1bFVuBhoVs4L7m0MpL0neZYWro
	 rglyvgc4ErM/okl218fkg3b8LsGN6Tisze+C3jT4pyzDhh4bVCKKCIWiZYkokSPf4M
	 6NB/wzfD53cqHhfvTOWEs5ZHkINh4xCBR8gy4e7U8ZH+Q+vhvWNoRIGzr7QBRB1WrG
	 a/soA1nq3DT1rZmgZ3IZRyl13CsphqTku2s15SmvudcghWfb3y7GmF6XptxxHZ0WxO
	 YE2poOQgtOSbO/3WuUc8snV+VM5webVLpYInBQZsvddaIfiLINPpI/P+oS0iLu0gCz
	 mxHwJoBqQF6KQ==
Date: Wed, 19 Nov 2025 16:44:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119144452.GI18335@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <20251118050311.GA21569@lst.de>
 <20251119095516.GA13783@unreal>
 <20251119101048.GA26266@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119101048.GA26266@lst.de>

On Wed, Nov 19, 2025 at 11:10:48AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 19, 2025 at 11:55:16AM +0200, Leon Romanovsky wrote:
> > So what is the resolution? Should I drop this patch or not?
> 
> I think it should be dropped.  I don't think having to use one 96-bit
> structure per 4GB worth of memory should be a deal breaker.

Christoph,

It seems like no size change will before and after my change.
https://lore.kernel.org/linux-nvme/20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com/T/#ma575c050517e91e7630683cf193e39d812338fa4

Thanks
