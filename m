Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D81AACC
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 05:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715663315; cv=none; b=EuvNCvLCb+SyJf2hIQGed8aYANQj7KfmYpv6YZIUSHzp0qrniTyLip0CZm+VE/WrflhSFh+jCsw+m4mFVn7t8yWMtmGTO0bYudSUO0BCTqV/Y4+8YV+ZRVU/Aw6auEtNQqNdaNsWs11an3+CXZNJStWu6GcTiwxbgWHpwyKNjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715663315; c=relaxed/simple;
	bh=mB+8jHTwf1bMVLqyntHhJLdnCHwvdfi8WlYdPEnSuN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYatcvMTK2Wo0POCg0Qd46iIWi7ZLhUZ0xj5P4q/FELU4XhZ/rjsPpnYU0a4N9TLLz20FyJKGree4bLwbn430DxsBQyIIUZBGTH3Hr14d26ktVHhy4SBZDfz+ZUowPoOz101nTg99EhJ2Fb9DKwk0HdPzQ5L4GrxqQ3tYNlmvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c1IcnK+e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c1IcnK+e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V8BLKEDjVLSYCeIAVSa2UNwbV9pR9h6kyjxXY8EtniY=; b=c1IcnK+e5fUSdoqZLyvbrU8Ygc
	2nqiAtWrFNYDhiHPZoshYlYeJdUgQyyTfFlqq6ddCUGNOHQEJ68l/WSFeztaa20+eyKxUzzwDxIRd
	oc9/5OnwSASoCAuhsj+iIDnRbP9eTc5Gya5KGXS1L5H39oMzPsZa9E1QZctVXsG/53/s+bb8QZs+Y
	TjhWAnbgCR/heuhtMokjJqPhjp9m4d8rPknIVJTTc/O6mmPWHvOb9iZZ4XM/ZQZkzUpt/13+2N5Yd
	fCk8FuDBPjZ3QA1p9dqMDFxCjraCzhl4Zsi0Lq+HWnFtnQhjQ3eD+FoJQBmrBCyP5BGp9ylYHbUUk
	DtlTlsqw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6kOp-00000008kBQ-0ekQ;
	Tue, 14 May 2024 05:08:27 +0000
Date: Tue, 14 May 2024 06:08:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, hare@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <ZkLxy6QUc5BB_adf@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
 <Zj__oIGiY8xzrwnb@casper.infradead.org>
 <ZkAEhFLVD9gSk0y0@bombadil.infradead.org>
 <ZkAszpvBkb5_UUiH@bombadil.infradead.org>
 <ZkCI_21z_h1ez4sN@bombadil.infradead.org>
 <993991e6-7f06-4dfd-b5d7-554b9574384c@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993991e6-7f06-4dfd-b5d7-554b9574384c@suse.de>

On Mon, May 13, 2024 at 06:07:55PM +0200, Hannes Reinecke wrote:
> On 5/12/24 11:16, Luis Chamberlain wrote:
> > On Sat, May 11, 2024 at 07:43:26PM -0700, Luis Chamberlain wrote:
> > > I'll try next going above 512 KiB.
> > 
> > At 1 MiB NVMe LBA format we crash with the BUG_ON(sectors <= 0) on bio_split().
> 
> Ah. MAX_BUFS_PER_PAGE getting in the way.

That doesn't make sense.  We will need something like this patch for
filesystems which use large folios with buffer_heads.  But for a 1MB
block size device, we should have one buffer_head per folio.

