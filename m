Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D916040FD87
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888525; cv=none; b=K5gwKeHDhle6HZ+XlyxvKUKJ+m4hJl2Lhs1iMAczb4JcV5SwLuvbtVkAjdE4hCbCLT9oDCd38ky7xFOFKIrDW7/Dis8wvZEzPW5z9rKj3A8LVIe9cbHnjFM1XOJ+00UoJlK/CbFd7BknsW8BQClTD1L/O4Hh/YTJSKxFhqrEgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888525; c=relaxed/simple;
	bh=TMp0r2RO2WfbkRyH8m3UkLENaqoRTiJaa4wWtWUZtk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWgBap5HY125TVrnDU3bNEUcjpZhZMrrNCL2UgaHKoRpczrLjaNjl6fDV72j5ToylA1jfle4HsLLXLAs+im+bF5dS9yqrOM5bW3v6vtQfyc91C9LcMtJRlhimRZMIxYnB3b06D5QvXWmvqtjr98ErPC3UCV7w3L6K5AYkJq13h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DE6068B05; Wed, 27 May 2026 15:28:41 +0200 (CEST)
Date: Wed, 27 May 2026 15:28:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, nilay@linux.ibm.com
Subject: Re: [PATCHv2 1/2] block: export passthrough stats enabled
Message-ID: <20260527132841.GA12022@lst.de>
References: <20260526153921.2402015-1-kbusch@meta.com> <20260526153921.2402015-2-kbusch@meta.com> <20260527131458.GA10351@lst.de> <ahbwAxG1Pj2z3Q21@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahbwAxG1Pj2z3Q21@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 27, 2026 at 07:22:11AM -0600, Keith Busch wrote:
> On Wed, May 27, 2026 at 03:14:58PM +0200, Christoph Hellwig wrote:
> > > +static inline bool blk_rq_passthrough_stats(struct request *req,
> > > +					    struct request_queue *q)
> > 
> > The kerneldoc requested last time would be really nice to have.
> > Also, now that this is a public API killing the q argument and
> > just using req->q would make the API easier to understand.
> 
> Oh, my missing kerneldoc is clearly a problem. We need a separate
> argument for the request_queue because the q we want to count stats for
> may not be the one providing the request.

Even more argument for having the documentation :)

