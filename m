Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E471DDC07
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704406; cv=none; b=rkYrmCm4J1HKtJP/S0bi91Q9IZs3Tm+7Llombp39fpLWvcADQhUQVHv/4HZlrwG2VohGzJUrQAdaARiSYVBHSVUx0Gp769xawByBWVxg4sDTt7oF5kHNcbSiMqWegWihkxZHVmsTcrWhUf4TGVEEU+ab7kZLcbMebf7KDV7B7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704406; c=relaxed/simple;
	bh=gCg4EfM4emQmT9XEDAuVvOz1bXsGukN95fIGBgt9JJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYVg3FZYHsKEbEiR/b5+uRb4cNHWfluKPd9r4PUqjAcGv/+lbgmcQWLjFOPZxvqZyDq21En58SG/Xp8AdTGgjNT2TIo+uynaJ00kdXGUPHSfjHfiP0/gvdKwdf7Tur1jIctz/F5s6D44SJcM+OjbDXDW7g/cY36uboBNpRStOXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C947568D09; Thu, 12 Jun 2025 07:00:01 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:00:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <20250612050000.GD12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-5-hch@lst.de> <c5d5abc0-9aec-42ba-b21a-a4ac2b34d03c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d5abc0-9aec-42ba-b21a-a4ac2b34d03c@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 11, 2025 at 03:43:36PM +0200, Daniel Gomez wrote:
> > -	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
> > +	if (use_sgl == SGL_FORCED ||
> > +	    (use_sgl == SGL_SUPPORTED &&
> 
> FORCED implies SUPPORTED, what about simplifying to:
> 
> if (use_sgl >= SGL_SUPPORTED)
> 
> or just do:
> 
> if (use_sgl)

For forced we unconditionally enter the sgl branch, for supported
we also need an additional condition.
