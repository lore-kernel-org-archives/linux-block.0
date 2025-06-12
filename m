Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056833C1F
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704433; cv=none; b=Yfd6H1mkjZjBZQ76pcrHhWv+v3DvAJMUFAwau+DYYpDcxBwTtcNImLgNV6jYm0bAuTr5Bxsu/9y/m9cWktkE9bARBQ4ptrNjDMufYrIFN5dzMfKPZiMoa5/2k36WRQPhREW5BakuYa8PiOHBTDLeqdLKA/A9SAAKB24sSXPEZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704433; c=relaxed/simple;
	bh=9Pyeq7qs1QB7R/oQW/lIflEmweJ+X0g3/IMEuWp0odI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjO+JAWE7uHjK4j8YtUjb09Gmr71KQptYt2MFt3lRlpAdElOGEGUrFIXyC4YUrMrt3hYjft9TRZRsdICRlMxixRUrF6lSnTGZBStzd9CMVurfZ0GSr7rdhv3Z8yVrMStX87SZZkz3xob4SagerxukX7V6yXeS92q82x3yxki5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 540AB68D0D; Thu, 12 Jun 2025 07:00:28 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:00:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <20250612050027.GE12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-5-hch@lst.de> <aEnsLRDcZ-ykBsVX@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEnsLRDcZ-ykBsVX@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 11, 2025 at 02:50:53PM -0600, Keith Busch wrote:
> > +	if (use_sgl == SGL_FORCED ||
> > +	    (use_sgl == SGL_SUPPORTED &&
> > +	     (!sgl_threshold || nvme_pci_avg_seg_size(req) < sgl_threshold)))
> 
> This looks backwards for deciding to use sgls in the non-forced case.
> Shouldn't it be:
> 
> 	     (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))
> 
> ?

Yes.

