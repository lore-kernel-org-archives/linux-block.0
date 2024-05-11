Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F052E832
	for <linux-block@vger.kernel.org>; Sat, 11 May 2024 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715469085; cv=none; b=D9uUAdQCNW/f0lJG1iQahhOxYcAsCmLukY8x1s7UV8CERWYbszDLnYiEy0q4HBIzp+yB+JbyIdPTCLJutdNG2/3ND0wJD0ujUv5WmNFtpVeA86T6D6XwYp2Q41MlMNohTD2LsaXobmjzSqbyY0ZOCtyWtfYlE+QskJ1bT5ncems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715469085; c=relaxed/simple;
	bh=CTh9eZw5bQHNbsppCkPzQ2PnRlcxhmfiE/5yXjy936c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY4LeoSXBAQAbiMxAgCdOtKAWpOIs4AwVEIMTqen+4asbkF8a08Mr7dN+oqyTG8GALIVq41BTmHRbS+YkMhKvTeAx1CjO2X5WQp/J1GSD71V1vME0njW6Ai3ZekT2hMofW6ipxwAR4TNixkiUAcP4Rsn4zasN/3GV1pwZEC+2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PgFaV022; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PgFaV022"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aqAu8Pps5JqAT8IXH8R703iSyYY7OAg7iaYI1DF/DG4=; b=PgFaV022wiDuTyWA6+dIs4TU5o
	u3/fsA5WtqeiWI0TCle8dDfexuf9yWswzOkgNIsnqOcxQDbfGojiX6oFJa7TCHN104r4TYitDyoIL
	XcmeVya9Pk4MArV5+j/Kkm18lrdfsX4c0+FTRv1z44dA3rB06lemUZgfPKkO12EhoiWGhci+Um4aE
	r/PxNRVrnNnAonv/tp9FyuAt1hNA5sgc4y1kK5TTfQi25tshirxYSJKBCo5Zo0kjdM8FVf0JWsC3A
	D7aYIQ8saq16btQ6fmEw9Q7tRel9Eli+t+jZe/7/OBs7Ou+peZ1vMnl0B6/YBTBqKPq7jUBdkkrf5
	arkIw+XA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vsA-00000008tSQ-1kAK;
	Sat, 11 May 2024 23:11:22 +0000
Date: Sat, 11 May 2024 16:11:22 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: hare@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <Zj_7GjhpWtY-ZOjr@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj6hotHEsOSL9h1K@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj6hotHEsOSL9h1K@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, May 10, 2024 at 11:37:22PM +0100, Matthew Wilcox wrote:
> On Fri, May 10, 2024 at 12:29:06PM +0200, hare@kernel.org wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Don't set the capacity to zero for when logical block size > PAGE_SIZE
> > as the block device with iomap aops support allocating block cache with
> > a minimum folio order.
> 
> It feels like this should be something the block layer does rather than
> something an individual block driver does.  Is there similar code to
> rip out of sd.c?  Or other block drivers?

Each block driver must be tested and set a max if its below what the page
cache supports.

  Luis
