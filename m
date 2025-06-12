Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3861AAA1F
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749704507; cv=none; b=rgPUQt3UQ8vA8nkwFyNM6ybsXOqG2bg8IXrUC1Tbe2U46gRze7kGBhkW95k0TDQJ5FW9CKd8TZ3vHkZ3lx2NWK7gP+IMr3RmBs2DhkGZNUbCC90QqqfNUBzcRHxGGtVdzmWOOd02DgkkrEMTkB7zGaQQO2+f2YrSrVXS4nrxlFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749704507; c=relaxed/simple;
	bh=S8J2nDkYUvkKi2BljjzOowstaQ1me8TK4eKM0k1SMvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVAsc8p+fIyp109oMFI6QlBxJmLp/Zbosqbi990gRuUCQZFS20iO3quYZH4e1Jk+Ikl+JKqOLsCgdCF4OS6FbSD17/DVMBJbPeZEIOL3V5LW6yyuMofB2iYRr/fkfRoGioWckmQBWCk+5acHaUKgaBuiXKuHpTQE83QEi2YuoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDD2868D09; Thu, 12 Jun 2025 07:01:42 +0200 (CEST)
Date: Thu, 12 Jun 2025 07:01:42 +0200
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
Subject: Re: [PATCH 5/9] nvme-pci: merge the simple PRP and SGL setup into
 a common helper
Message-ID: <20250612050142.GG12863@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-6-hch@lst.de> <aEnvJ6V3F0Z_pO1U@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEnvJ6V3F0Z_pO1U@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 11, 2025 at 03:03:35PM -0600, Keith Busch wrote:
> On Tue, Jun 10, 2025 at 07:06:43AM +0200, Christoph Hellwig wrote:
> > -	iod->dma_len = bv->bv_len;
> > +		iod->cmd.common.dptr.prp1 = cpu_to_le64(dma_addr);
> > +		iod->cmd.common.dptr.prp2 = 0;
> > +		if (bv.bv_len > first_prp_len)
> > +			iod->cmd.common.dptr.prp2 =
> > +				cpu_to_le64(dma_addr + first_prp_len);
> 
> Nit, set prp2 to 0 in an 'else' case instead of unconditionally before
> overwriting it?

unconditionally setting it actually generates slightly better code,
assuming the compiler won't just optimize the other form to it anyway.
But if you think it is more readable I can change it around.
