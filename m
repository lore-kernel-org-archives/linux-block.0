Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0728D8D1;
	Wed, 15 Oct 2025 04:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501787; cv=none; b=j/BbEezJ8WVVmc8iHbgaG5SkfGIjKXEGBmOe4sPiI+SVEq7J9uxquGVvi9rT+XkRxxEVOYASXpCewadesMDBTcxzsDk+Qk8qkcNvzUalntaftcQw0lBQDRjnk7HbPvkfYxiuiXp5UooPlHg/jYlmHZ64BYPMsN5q8ZyPMQ8ks+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501787; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCMNKw2TPu7CnVVCnmSU3vQNA3zO7ERQu9TDm5mVWgqPjpalxBYm7Q2SlpQzOIbuEO0s6Eo+qk9ntvtoplW3Bu9D7/ZDPe4JzPA47lyh+fWMFVVoe71TMBJ9Bph4lrhaa7RZViIFA2AryZR093AxGxoWDoGq/5n/JWhUt8de0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 155B2227A87; Wed, 15 Oct 2025 06:16:20 +0200 (CEST)
Date: Wed, 15 Oct 2025 06:16:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/4] blk-mq-dma: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251015041619.GA7073@lst.de>
References: <cover.1760369219.git.leon@kernel.org> <a40705f38a9f3c757f30228b9b848ce0a87cbcdd.1760369219.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a40705f38a9f3c757f30228b9b848ce0a87cbcdd.1760369219.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

