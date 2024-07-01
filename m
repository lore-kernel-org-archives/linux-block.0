Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060716C6B7
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846686; cv=none; b=tGxuBrJt20TeR9eoIL/PyPGFBxRrWxOnaJh7qY67loCJwSAIQql54HT8lHnxXKTugQA5qITHCo3ktI7RP9nU7afdZu2NYEbg1dXYairiHORIM7b7+rmsTqCRHTsGIxF9euIJhEQgROwzk7w/dAQrvm3IbRtmzET4HnXzOFPNZsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846686; c=relaxed/simple;
	bh=tSZ08u2JaYKd7Vo/22KrFGaU7klgwoiUevTs1dWxA+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEQhihB7Doz34reOe7h+vgLSD2l+86ulz+99GUvd4mFH8eDvIm6eSKHz3azJMyglsRbY/Skb+EGkAKLRS//5lSQI694HS70jMwojczHPe015/eCS53XR4ivxY0OsSBZwjrGIfREkB1Gx3kljdXbxsH0gxKWV2SPGrX/JjmVqrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB76B68BFE; Mon,  1 Jul 2024 17:11:12 +0200 (CEST)
Date: Mon, 1 Jul 2024 17:11:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: don't set io_opt if NOWS is zero
Message-ID: <20240701151112.GA1677@lst.de>
References: <20240701051800.1245240-1-hch@lst.de> <20240701051800.1245240-4-hch@lst.de> <ZoK1WRFbr1dK86FK@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoK1WRFbr1dK86FK@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 01, 2024 at 07:55:37AM -0600, Keith Busch wrote:
> On Mon, Jul 01, 2024 at 07:17:52AM +0200, Christoph Hellwig wrote:
> > NOWS is one of the annoying "0's based values" in NVMe, where 0 means one
> > and we thus can't detect if it isn't set.  
> 
> We can detect if it is set based on the namespace features flags,
> though.

Except that the flag covers 5 different flags, for 2 different operations.

> > Thus a NOWS value of 0 means
> > that the Namespace Optimal Write Size is a single LBA, which is clearly
> > bogus.  Ignore the value in that case and don't propagate an io_opt
> > value to the block layer.
> 
> Hm, why is that clearly bogus? Optane SSDs were optimized for
> single-sector writes.

Because even if they optimize for it, the pure overhead of both
the PCIe physical layer, nvme command overhead and software overhead
will never make it more optimal to split a larger I/O down to this
size, which the optimal write size is about.
