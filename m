Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117432E152;
	Thu, 18 Dec 2025 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037626; cv=none; b=TeoLCRYYz/yi1YLIydN3xwp7o7/zWK++F4+IrGlPBjk4eXhYAvBdzcZ6IYIR2tG6bI4wwRSYbkAgdJ7hsRmWQaMwYBlNv1Ixrin/ylO7g10RVo46fhRyiy2N3Hb5lYfFTLqK6XbS1Rp0nBcjZan0Yjue5qsRtRNCejqdvaLCbPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037626; c=relaxed/simple;
	bh=PN62smMz9fnkcONiBNdVyrjuDYxkLgyjHAGvxXs6shM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itHt19CSakalF/3mQYIaj+aRGwh3U/YJephBJuWlCEBfLMFN2Q/9rwE8XIfkJRKR1bhKGVXfRpnov40Y1R1ziZqjFS6QOfoZuHOOL+vcv8cTtvFvfc8mYLb5STLPyLOi5vkehQvc/khmrW0AusKxESKGInzbnG9WBqIjFrLlKc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hbYodE/Z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbYodE/Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7AZnlHdb5mVs/DWMBb/Fn6vsoTS72x+uWHSaGcyXP+E=; b=hbYodE/Zyf6pmKD15iiGgEvYny
	URWV0ikQGTiAUqJfk/PSiCb7vNaOYGN2qRdU4jxS2T8CHlQwVPp71BI12BCyF3hG0mVcN1bl899pa
	hMJgFHu3mXje2KoqVxoYnLDWr8TY7eDe8T4fEe9VkZ+hv4SuNErqi9oS7cGPlFSTgDKZXB/1XBunQ
	QqL02V3qkCh1mvXYOhIxEqENJSWMKemr48sTstuKC+qPTbAkYNGTRoJHya3q16mnaK2vEdr8Nlpz6
	YQQNA08ZkKSJRNlDK8ZUBmdHJRZybItT+Smzvq2zhwqzVxCxN4BjMVCYudQkk8lgfoJv67m5l8CVz
	CBcBV9pQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW73n-00000007rvr-3hnF;
	Thu, 18 Dec 2025 06:00:23 +0000
Date: Wed, 17 Dec 2025 22:00:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: retiring laptop_mode? was Re: [PATCH] mm: vmscan: always allow
 writeback during memcg reclaim
Message-ID: <aUOYd6FiIBf06Skt@infradead.org>
References: <20251213083639.364539-1-kartikey406@gmail.com>
 <20251215041200.GB905277@cmpxchg.org>
 <aT-xv1BNYabnZB_n@infradead.org>
 <20251215200838.GC905277@cmpxchg.org>
 <aUENEydFvVvxZK8r@infradead.org>
 <20251216185201.GH905277@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216185201.GH905277@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 16, 2025 at 01:52:01PM -0500, Johannes Weiner wrote:
> On Mon, Dec 15, 2025 at 11:41:07PM -0800, Christoph Hellwig wrote:
> > On Mon, Dec 15, 2025 at 03:08:38PM -0500, Johannes Weiner wrote:
> > > Debated whether to add some sort of deprecation sysctl handler, but at
> > > least systemd-sysctl just prints a warning and still applies other
> > > settings from the same config file.
> > 
> > In general dropping sysctl will break things.  So I think we'll need
> > a stub, at which point it might as well warn for a while.
> 
> Fair enough, I added that.
> 
> Jens, that change seemed small enough that I carried your Ack, but
> please let me know if you feel otherwise ;)
> 
> > > Laptop mode was introduced to save battery, by delaying and
> > > consolidating writes and maximize the time rotating hard drives
> > > wouldn't have to spin. Needless to say, this is a scenario of the
> > > (in)glorious past.
> > 
> > Maybe expand on this a bit by mentioning that reclaim now never does
> > file system writeback, and fs writeback is already very lumpy by
> > design.  And of cours that hard disk with their high spinup latency
> > and extra power draw are a thing of the past in laptops or other mobile
> > devices.
> 
> Sounds good. Can you take a look at the new version below?

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

