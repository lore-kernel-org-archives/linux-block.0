Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329F3101D5;
	Fri, 17 Oct 2025 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682015; cv=none; b=nvGPeE8ykP6XttQy/oTF4nEbYTWkRlVwEKfCAM7X4UBIyWAz/y54eKBVIGTclIP/g2V7GQpi0LxACV15hw+nxCai0KKCdQMxQtYib7L0R/iYvsJFHdNVzRM9gyE34+aD8Yxf9BvJmFcGSr3Zm2Eat9pgw97yz4j3ofE6VaC7768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682015; c=relaxed/simple;
	bh=uGakUfnEI2WHJMDC5Ou1Fjy/MVt0dyqZ03IOtgUdHhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVTJI3GGTlhaUGEzAan/tUNaynudC6JCHNXkG5OJUnJ8tLn2B1pE2IlreM/tBqSYX/P6Cc7my/Z3CN+HKzuo29vyAvZhl1BLRq7u2AUCwjw3K8si8sLjdtVv+Tu4hmD8DrL4+pLObPEjaXlhYnZJYxf6c7fyipfmuMs7O8k2hPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B951C227AAA; Fri, 17 Oct 2025 08:20:09 +0200 (CEST)
Date: Fri, 17 Oct 2025 08:20:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-pci: unmap MMIO pages with appropriate
 interface
Message-ID: <20251017062008.GB402@lst.de>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com> <20251017-block-with-mmio-v1-2-3f486904db5e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-block-with-mmio-v1-2-3f486904db5e@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 17, 2025 at 08:31:59AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Block layer maps MMIO memory through dma_map_phys() interface
> with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> that memory with the appropriate unmap function, something which
> wasn't possible before adding new REQ attribute to block layer in
> previous patch.

DMA_ATTR_MMIO only gets set in the following patch as far as I can
tell.

The more logical way would be to simply convert to dma_unmap_phys
here and then add the flag in one go as suggested last round.

