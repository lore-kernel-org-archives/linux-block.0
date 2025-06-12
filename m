Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35497FD
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 04:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704270; cv=none; b=EQ+0+x5mfufHHcKFN6rZIdw8bA1oTB0/FepQHKINUXQEiKH33J1mAFbKHOzdGtMfDX98Du2DazvowmutH16zYDXZCVg/bGfEhKUD9om3sS5+LfAtUnpGpjt1NOTfPaJDAUcYo28dFFdDpi3ggge9/iAu3CvV1Y64g5uE44g6grs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704270; c=relaxed/simple;
	bh=vybdzuUvrg64lF151pZhWhITN7INc465MNhDEteqYfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bncmeLRyMB9FwFf9xkpqBH1imXX4aKLWCUDKqoK44gaU/met0boJa2PQ0ANWys6AuutXESiDVicq7XVABs0w/GoW4aD0Yivkh3fj53C95NSaoj2fa/awhjvm/Yd57jN/ml82d5a1nQ7caG+YXL5K02qXzE5Przk4goLORPl+T2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE55A68D09; Thu, 12 Jun 2025 06:57:43 +0200 (CEST)
Date: Thu, 12 Jun 2025 06:57:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P
 transfers in a single bio
Message-ID: <20250612045743.GB12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-2-hch@lst.de> <aEhROl2D89kFX8C7@kbusch-mbp> <20250611034316.GA2869@lst.de> <aEmuG1dUDGuci7VW@kbusch-mbp> <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com> <aEmxn0K6m34HsZeN@kbusch-mbp> <88fe6154-6086-409d-a180-665d62d72d47@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fe6154-6086-409d-a180-665d62d72d47@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 11, 2025 at 01:41:54PM -0600, Logan Gunthorpe wrote:
> > Is there some other mechansim that ensures a host memory mapped IOVA
> > doesn't collide with a PCI bus address then?
> 
> Yes, in the absence of a switch with ACS protection this can be a problem.
>
> I haven't looked at this in a long time, but the iommu drivers reserve
> regions where the PCI addresses are valid so no iova will be allocated
> with a similar bus address. After a quick search, I believe today, this
> is handled by iova_reserve_pci_windows().

Exactly.

Fun side story:  the CMB decoding for commands in the NVMe spec relies on
this to not corrupt data as it tries to match an IOVA against a PCI bus
addresses.  A certain very big hypervisor vendor did not reserve the
space like this and it caused data corruption due to this broken nvme
feature.

