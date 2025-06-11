Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE579C4
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 03:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613403; cv=none; b=qDgLhxy9Gx60eisQuaovPjhh50bVFXjIuw1FhRixBgVKd+UD1yXph/2blgRuY9TrBcymhNQAnjpA+MUc9Dvft2PROX0p7nLhukH/ubRGdfrOCg3wdt6aIdY5qat6Ihxa7CuHKVHZZ5k7ykNUUccTW/hKMdReNkAYqkvYPfSdsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613403; c=relaxed/simple;
	bh=wTlDqs/1SJ5Zwj80kbv4Fh1YE1+vgus2zcK7Wjn6W4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwmtSpleU5x3adNrvsAHfw3gAbc8tt/y9IRB20OLuijrwx9h5R1BIiAVyj9nDqXYmLEP60zPyRn27FdhlLZAe6uK8wTdGiz6Dg2lcVNUCLNeHADgbImegTegKx67xTX9Vv2Tib02nEE20SzOo1BGkN+Ngx1O2ME2IN/uROonYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A32C68C4E; Wed, 11 Jun 2025 05:43:16 +0200 (CEST)
Date: Wed, 11 Jun 2025 05:43:16 +0200
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
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P
 transfers in a single bio
Message-ID: <20250611034316.GA2869@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-2-hch@lst.de> <aEhROl2D89kFX8C7@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEhROl2D89kFX8C7@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 10, 2025 at 09:37:30AM -0600, Keith Busch wrote:
> On Tue, Jun 10, 2025 at 07:06:39AM +0200, Christoph Hellwig wrote:
> > To get out of the DMA mapping helpers having to check every segment for
> > it's P2P status, ensure that bios either contain P2P transfers or non-P2P
> > transfers, and that a P2P bio only contains ranges from a single device.
> 
> I may be out of the loop here. Is this an optimization to make something
> easier for the DMA layer?

Yes.  P2P that is based on a bus address (i.e. using a switch) uses
a completely different way to DMA MAP than the normal IOMMU or
direct mapping.  So the optimization of collapsing all host physical
addresses into an iova can't work once it is present.

> I don't think there's any fundamental reason
> why devices like nvme couldn't handle a command that uses memory mixed
> among multiple devices and/or host memory, at least.

Sure, devices don't even see if an IOVA is P2P or not, this is all
host side.

