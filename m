Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C41FDE02
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672007; cv=none; b=jB1kmhCh2tjGxDI5dDAQ5IQ1Jb+lURtR74lYh+g75zdHK6JTTNye9uQ+m9BS1h17Q2qVKR86MNZIIuqfuRNAgCavrd8kPgxwqzRMuomM5ay5d+BEs0IVZbsv+8XgUalW+UE1S/o1zd8PZItrc3IJp9YkMrg/R2s8MiuWYASvaeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672007; c=relaxed/simple;
	bh=ooKf35t5Mm4QWKAgMc0QQBD+koQKDB4/2gFAGm9zMdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTB2LGgkAOpDtZ931bCFBNn+MzeBVHJdCBplk9DQYDf8VIYlSEh2kliHLhU+7oWIunVZZkENz7Nos6w73d5XXBJM8qrm78/2hhaP1DJQ4HTx2zNAmsZGe1bU7Unfiz7E+74PFTwQEanRqImYtokLrP7GRHDt+58IDnFoheXj8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck+I2qQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck+I2qQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EA0C4CEE3;
	Wed, 11 Jun 2025 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749672007;
	bh=ooKf35t5Mm4QWKAgMc0QQBD+koQKDB4/2gFAGm9zMdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ck+I2qQ7CfveRuzjoUygtQAbhUev9wTDtalXJBJYaeFI1NWp1p3T8m9Lo+XSW51sx
	 nL6rQT3JKRp/VjpxsW4Xovk+m+1lCN9eF3RB5dcERSzYSKyruti4+i7HTNjMEE5DWv
	 EtkciBllqF5lL3Q/T69Iy0fa2e1V9BYWz4RbLaTa0nHDMDfAB4GqJiFvYJ3nSbb2/i
	 aj8ic5bG7WCNsUnVcFHoHSKqvQpXnClUPcVsLxFDnNNgUEgy9o9KlX6jnRQVzw5tAf
	 u3kuNNzbY2dCkq/R3+gpxQ3n7rWvnTWuMmwJl3WcvVXUuaRcj7UzchCXqdWuSg4fio
	 cUZ7k8GC32Y0g==
Date: Wed, 11 Jun 2025 14:00:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
Message-ID: <aEngRKqXEYmikcn2@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
 <aEhROl2D89kFX8C7@kbusch-mbp>
 <20250611034316.GA2869@lst.de>
 <aEmuG1dUDGuci7VW@kbusch-mbp>
 <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com>
 <aEmxn0K6m34HsZeN@kbusch-mbp>
 <88fe6154-6086-409d-a180-665d62d72d47@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fe6154-6086-409d-a180-665d62d72d47@deltatee.com>

On Wed, Jun 11, 2025 at 01:41:54PM -0600, Logan Gunthorpe wrote:
> On 2025-06-11 10:41, Keith Busch wrote:
> > Is there some other mechansim that ensures a host memory mapped IOVA
> > doesn't collide with a PCI bus address then?
> 
> Yes, in the absence of a switch with ACS protection this can be a problem.
> 
> I haven't looked at this in a long time, but the iommu drivers reserve
> regions where the PCI addresses are valid so no iova will be allocated
> with a similar bus address. After a quick search, I believe today, this
> is handled by iova_reserve_pci_windows().

Excellent, I think that was the piece I was missing. Thanks!
