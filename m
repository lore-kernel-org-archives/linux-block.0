Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B12EB5D1;
	Fri, 17 Oct 2025 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681937; cv=none; b=jYNCqPPqtBpCVlPtkoc9bP+1rTUmpqulWsLhlJdstTO6t6fu3QjSlE6gj10B1BfKo+f7UvO8H6T3E+eN50FNhAYL7ETogODDfegOtF6FE+6+lHWNXgv3dG7NC0fvdpoFRn3OX+gYR5ab9PL+/EYWsOl0PINMYfH7dMaCGZCdBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681937; c=relaxed/simple;
	bh=i/sVTraZhyy6jOai6yrvF9UmzzQavKji6AbeO4bGByQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4IjGq/X6zSFgM0K8iJxCLn8z2EmiLyOpC1wV/e/cyZNZ8NDEalLd03YTbwTlono3xYt6ub0sC4Xfh+nfBRtMO0F/QzTjjvujdKH58Ja9wifzFECOjvFizLO4m2pLCJtCjJoDiv5BqqXntjOcwigBocIdaDDy2vzoLgNQsgkVj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BC2AB227A87; Fri, 17 Oct 2025 08:18:48 +0200 (CEST)
Date: Fri, 17 Oct 2025 08:18:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] blk-mq-dma: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251017061848.GA402@lst.de>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com> <20251017-block-with-mmio-v1-1-3f486904db5e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-block-with-mmio-v1-1-3f486904db5e@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 17, 2025 at 08:31:58AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> After introduction of dma_map_phys(), there is no need to convert
> from physical address to struct page in order to map page. So let's
> use it directly.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

You forgot to pick up my review from last round.

