Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02F1FDA
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754835154; cv=none; b=UvlknJH+UuwuNKA5B4s28ZlZwzYB44WSfaSgtQHg8AzE12Yu6ZWERtZE6hNn0WuuKfCba9uGB8VPughcaIKZ0nj5G9kk8fv2IUeM5sWINz/2/6/TtoR12SF/iolbUcdSPICCY+W5j8LM+Q035bR7OfSaZTHUhyNn89382DytLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754835154; c=relaxed/simple;
	bh=JTlXLbXoFTyhghznWR96Bo6YuCMTMf720M8aVAzxNws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqNswfAz0bGGGYm2sOly8yENpCZ3XA8OOkGsmM0XN2qPNTtoL/LTH9YWt2dCcJ0aIrwy7+Sx25E3+tNZ2zRkALSE+kYd5L9D0wHBJ1knm0sj/dL0VGK+8rDYjwLJonJvL+lkfU0wFe6si38Mich9y4N0Hri2OPfZUPh9rBLmNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06A01227A87; Sun, 10 Aug 2025 16:04:49 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:04:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 1/8] blk-mq-dma: introduce blk_map_iter
Message-ID: <20250810140448.GA4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +struct blk_map_iter {
> +	phys_addr_t			paddr;
> +	u32				len;
> +	struct bvec_iter		iter;
> +	struct bio			*bio;
> +};

This now mixes the output previous in the phys_vec, and instead
of keeping it private to the implementation exposes it to all the
callers.  I could not find an explanation in the commit log, nor
something that makes use of it later in the series.

If possible I'd like to keep these separate and the output isolated
in blk-mq-dma.c.  But if there's a good reason to merge them, please
add it to the commit log, and also clearly document the usage of the
fields in the (public) structure.  Especially the len member could
very easily confuse.

