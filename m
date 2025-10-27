Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152F2472A4
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570562; cv=none; b=ZJmucxbJ+1LHFtd3W9fGF9VLtQW0FPq8n2J4zk0iLRODrcv89Gm+hrtX8et32BYRajzmE+asQ7W51UAtYVqst8CkALFAg3ZycSMJGnvZdVH2QfzR+g784eiE6gCdZJsePorQybzGrO9+5UKx1u5csYTv1NUcF38gKFOfXipvYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570562; c=relaxed/simple;
	bh=IZqHnK7ARFJBHG4inYpqbHpNkty65dNPOCSN+TPO5+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzWSAHSsZO3c1O0+ayD1sgzo/vADRexQihxgPdVkNwIljGdZ+j9zOiJ2wUqV8ozPK/M8QZ2lWm900+1/BrL1nfX5psHb88doLw2mD9Sy1G/IeOWebI2ABYI7gtOrZyGtFLZPLj1473DyKowhJD4WjrsQVDQz0EmgnJ3GejusCXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UfC2n8RW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UfC2n8RW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ar+OO8r4g/ZD5Pwf2pSeyV8HbqM6sytt882/CK4QNMM=; b=UfC2n8RWapYSmEGSopI5s/E/1H
	8LWs7bTf9r2yjxEdeK4mx9/U1mieIqme//WDJfAmeLGdKPdnYWt3okDVRt1HtBbMB+J5eRWGMDf+k
	2rPxl929A4zUQWZsPrQukea280b7g06Ln6EDrOz12qEdgosuJMWTOAOqrbMeZD7kP+66Q071bskce
	m+3HEFdU2MVgspKyLjaiD6z8kK+vVlQsMM0Kz09dPQesChvwfMAvMgkUisyAWCxFumyckqFsyJdtZ
	POisQqBISRAmG84xJqpjNdqXHDB7q9gDlngSdWnuNZ0ZWUE8lWiXPc+6jrwYxIsw/4VqgONFo+toL
	7FzOgOnw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDMyB-00000001vAy-0BYF;
	Mon, 27 Oct 2025 13:09:07 +0000
Date: Mon, 27 Oct 2025 13:09:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] slab, block: generalize bvec_alloc_gfp
Message-ID: <aP9u8lFBvzEzmuHh@casper.infradead.org>
References: <20251023080919.9209-1-hch@lst.de>
 <20251023080919.9209-2-hch@lst.de>
 <aP6QX_gNpY9UDtub@casper.infradead.org>
 <20251027064728.GA13145@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027064728.GA13145@lst.de>

On Mon, Oct 27, 2025 at 07:47:28AM +0100, Christoph Hellwig wrote:
> On Sun, Oct 26, 2025 at 09:19:27PM +0000, Matthew Wilcox wrote:
> > it's quite different.  I am by no stretch of the imagination a GFP
> > flags expert, but it seems to me that we should make the two the same
> > since they're both "try to allocate and we have a fallback if
> > necessary".  I suspect kvmalloc() is called with a wider range of
> > GFP flags than bvec allocation is, so it's probably better tested.
> > 
> > Is there a reason _not_ to use the kvmalloc code for bvec allocations?
> 
> It's using a dedicated slab cache, which makes sense for such a frequent
> and usually short-lived allocation.  We also don't use vmalloc backing
> ever at the moment.

That's not what I meant.

What I was proposing was:

+static inline gfp_t try_alloc_gfp(gfp_t gfp)
+{
+	gfp |= __GFP_NOWARN;
+	if (!(gfp & __GFP_RETRY_MAYFAIL))
+		gfp &= ~__GFP_DIRECT_RECLAIM;
+	gfp &= ~__GFP_NOFAIL;
+
+	return gfp;
+}
