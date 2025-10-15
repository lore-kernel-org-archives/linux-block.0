Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC0272E4E;
	Wed, 15 Oct 2025 04:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760502059; cv=none; b=YHbg1n/+aqOxbiDI2o2yCtqVJvbowfnAweirrZuR58HcQHYyJBRiejr5VF0f4lBrQkZaPbFhBvcfbwmfOMmW8hLgflk00cm2tCk/wnoy5RhqxT8/Ucu06xmtFUCBm6ffQVNLrrN6uiJUzLwjPk8otTqzAyEboNnPun3wMQlLRPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760502059; c=relaxed/simple;
	bh=Nd2YSL1vAC3SrcdeprsK9lBgZGgvCpiOL5Al7Li3dpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCziJaFnpeAsgZnFYKAQRbXPwQz2aN53kII9paUFiBre/aFJpCPKk/LgHGYtaxu7OEplZjqv4dGDETPtKxwtMHnRlnc6Ka7T1PQ8B2SJFmvkOrBXZxq027WA1uzDZji8YfpmO1ZIXLSyC5dRGrGhXsC4/EHfc1jgejk12O83e24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BB19227A87; Wed, 15 Oct 2025 06:20:53 +0200 (CEST)
Date: Wed, 15 Oct 2025 06:20:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4/4] nvme-pci: unmap MMIO pages with appropriate
 interface
Message-ID: <20251015042053.GC7073@lst.de>
References: <cover.1760369219.git.leon@kernel.org> <6522567376d50f71425ccc4950552fca48e4f57f.1760369219.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6522567376d50f71425ccc4950552fca48e4f57f.1760369219.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 13, 2025 at 06:34:12PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Block layer maps MMIO memory through dma_map_phys() interface
> with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> that memory with the appropriate unmap function, something which
> wasn't possible before adding new REQ attribute to block layer in
> previous patch.

This should go into the same patch that switches to dma_map_phys.
Unless I'm missing something it also misses passing the flag for
the metadata mapping.

Btw, where is all this going?  Are you trying to remove the auto
detection of P2P in the low-level dma mapping routines?  If so that
should probably go into at very least the cover lttter, but probably also
the commit logs.
