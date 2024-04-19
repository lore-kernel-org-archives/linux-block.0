Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE882D62
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536206; cv=none; b=B/jDf7DpK4Ap97WicWbO6oMq8nU8qbZ8FTVbM0w3ItP8SoUu32rE+nbN+yRnbIq6+CUxcHqnIzAcjwEcdASscKHK7FHP+hsS8SNNIB6JBsrmGTXz60EAfzTR+TajcpdFN9F5uftKWB3chgTgkLMWkqFV5SSCwxGoVeA0njPyXGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536206; c=relaxed/simple;
	bh=hO8XU5klV9iUM7MoJ7M2/79+Ja82HJtYdCmGGMMyHgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OS4IQDM0AtFg3a8WrAh6otKrrz1/kcQFoLLPSsBUlSyP6DNGowse7IBOMEzCDUtFin+XxSK+sJMdA9ZTQmKOsK2V5wHQ2lnIofAzJaJkaUJ6OCbf5nCFHFy+roJX+T9NyINwqU3bJFh896YVNJrar3WeAoB1J+Wi/whzgtsCNlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a1Z8j0BF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a1Z8j0BF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oQEujvbgIJve+8fGKwS5nUlMoIdKaMs/G1sSYBbfbw8=; b=a1Z8j0BForp3Pm5rhOFkD16GcG
	0fVEMM2ttPGS9WSGKsd5S3NJvrPPy15YK84WZR5TYZhcXETvRPJjj4AZSIMIiU5FkP4qs5TGrjfPp
	Fv9PhVAgMS3IwNajPEihyRbV3i10gIy6ESAJMHPjq2cWp7F+Rnw5URbGRzFdVCJjGDxq8EQieJolR
	W4MrFsgW9PO4edhHCmpv6hNNsJBSBZZoV7RJZgOl0le4YIbPLopAJI91Tw0gU2FdP/uXGZuO8pFNz
	dGQ9C+mg6GyynfnR7CSARcTYjIUfggcbpBhpSbnAP1qEhiLzohQHeb2/28dOk4flcoETFLvR4DYQF
	DebpAg8g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxp2e-00000007oUM-1bDX;
	Fri, 19 Apr 2024 14:16:40 +0000
Date: Fri, 19 Apr 2024 15:16:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	joshi.k@samsung.com, mcgrof@kernel.org, anuj20.g@samsung.com,
	nj.shetty@samsung.com, c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH] block : add larger order folio size instead of pages
Message-ID: <ZiJ8yMVb4OoQJzM1@casper.infradead.org>
References: <CGME20240419092428epcas5p4f63759b0efa1f12dfbcf13c67fa8d0f0@epcas5p4.samsung.com>
 <20240419091721.1790-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419091721.1790-1-kundan.kumar@samsung.com>

On Fri, Apr 19, 2024 at 02:47:21PM +0530, Kundan Kumar wrote:
> When mTHP is enabled, IO can contain larger folios instead of pages.
> In such cases add a larger size to the bio instead of looping through
> pages. This reduces the overhead of iterating through pages for larger
> block sizes. perf diff before and after this change:
> 
> Perf diff for write I/O with 128K block size:
> 	1.22%     -0.97%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
> Perf diff for read I/O with 128K block size:
> 	4.13%     -3.26%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages

I'm a bit confused by this to be honest.  We already merge adjacent
pages, and it doesn't look to be _that_ expensive.  Can you drill down
any further in the perf stats and show what the expensive part is?

