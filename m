Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F23019D8;
	Mon, 20 Oct 2025 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963436; cv=none; b=dYIjfFrO3fZ3EiwenTxvOsGPQIMUPePF1H4TxUugjSPDwh/DMlA22o5DJ5AFalH5VWrM0ZpiRud36JZ+eMxhFwS6d2MiNzoSigX6SlUmToKrMp6uBF+xLpaXShMWuluTdwKF04qrkIIFNiYzvi+0m+hsHcpQRuUWD1eb0Ds/hKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963436; c=relaxed/simple;
	bh=aqnPmo/lgklu83JhO5MG2REZ+QJ8s0OR0Wk/TPWy/DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV1T3xViukZmnIctZLT2tEEF+sesdvQ7E0eZOCQie380Ip2DNnfdID8zLUnYgE4AANnJCLsVdC3qW2ok99J2Lbhq+xHk0ByuAsgzYacIFcmhoufisekFKSiPrxn3KzPeO0hcE8aXndK4Dfj+WsizyFVk0Sl7qDVbdvee9wLvBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E3C2227A88; Mon, 20 Oct 2025 14:30:28 +0200 (CEST)
Date: Mon, 20 Oct 2025 14:30:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] block-dma: properly take MMIO path
Message-ID: <20251020123027.GA19560@lst.de>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com> <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com> <20251017062519.GC402@lst.de> <20251020085231.GM6199@unreal>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020085231.GM6199@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 20, 2025 at 11:52:31AM +0300, Leon Romanovsky wrote:
> What about this commit message?

Much bettwer.  Btw, what is the plan for getting rid of the
"automatic" p2p handling, which would be the logical conflusion from
this?

