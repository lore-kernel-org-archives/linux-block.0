Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A0294A14
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769201; cv=none; b=QFfQPWi9KcXWKCHc1dyBLlxEh/K+M6Ysa8VHGIdAvtP0khEdtwM9+JZjsaDT65YYWard4jXAOSZpAbNP/9LuK25YxfGU8TXhz6ze38GFh29IRaobYXaKxtB3fBYOjn7eW0PZbnzZMVBalTyuNUokV/Njuvp5tFzFsMhX4zUmmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769201; c=relaxed/simple;
	bh=noO0TXo+Bzs2RoFDOO1d0fvClmXOZpW8U9l/BTWKr80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqvK3EJaSSj3UfVqiUNLSwKp8gWpzIpWqB7gZvLC8UHR8bqzUX9tc2ftUxtSJzjG3ghqlfB/kM80gRbywCqbIm+XzAVZCLhAqa+Ka83c0DPqm7Ao0+PmgFVMFM1FJXBJerUVumbWTgaFDuI3apO/K0FTuxEorvRLI1T95Mt4adE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D54268AFE; Tue, 24 Jun 2025 14:46:26 +0200 (CEST)
Date: Tue, 24 Jun 2025 14:46:25 +0200
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
Subject: Re: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <20250624124625.GA19239@lst.de>
References: <20250623141259.76767-1-hch@lst.de> <20250623141259.76767-4-hch@lst.de> <aFlyYjALviyhQ-IE@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFlyYjALviyhQ-IE@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 23, 2025 at 09:27:30AM -0600, Keith Busch wrote:
> > -	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
> > +	if (use_sgl == SGL_FORCED ||
> > +	    (use_sgl == SGL_SUPPORTED &&
> > +	     (!sgl_threshold || nvme_pci_avg_seg_size(req) >= sgl_threshold)))
> >  		ret = nvme_pci_setup_sgls(nvmeq, req, &cmnd->rw);
> 
> We historically interpreted sgl_threshold set to 0 to mean disable SGL
> usage, maybe because the controller is broken or something. It might be
> okay to have 0 mean to not consider segment sizes, but I just wanted to
> point out this is a different interpretation of the user parameter.

This is still a leftover from the threshold mess in the first version.
I'll fix it for the next one.
