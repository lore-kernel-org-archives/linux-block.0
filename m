Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995AA27F017
	for <linux-block@vger.kernel.org>; Sun, 26 Oct 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761513579; cv=none; b=VytUjLqT16gf5epC+/hu42FYXa+NU0B8ipUyQgwaIgsrmZyNQlTjFfSzqZTcN38VfH7A5z6vAJoTDnK1R5whRx/+PY6oTdE3dQlx3qOG5XzidCSMvBbgGzbCjTanWm0JbXI/aKbeVoCN/yJ6NGWAzZmy9eekgwHnAcDZM25CeKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761513579; c=relaxed/simple;
	bh=ycmIoTznwM1Q+TA+UGowXozs3bnJZAzpKQUBvjZD9zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MljsRhIr7FNL9YeGne7v09jW3mtoefZsH85tPWxwF2yHvH8VlseNkvEYnahc2uEKGR1sMsIALPHaUW3uPWxoOz3wBKkoeDYyg4/Hsia/llPi4DPmfSw3cw+kP/5g3GKBhbq2CJPwSkmfSQdWiwK0UrkktVJOaFDnqqPUuByDKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U2p641UF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U2p641UF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vbgQSpwLiN23ZFyAT4xgeAAvMjoXTalRrJzies8wmYU=; b=U2p641UFAqafJssWfbrxUlfsV9
	+ALoEky47nqLTJU069Bgi1LHB3KG/HkbGEDId1PBFct5nNGL9Pw1sOF/Unh9a25ymrz6266A9SZwb
	J1fSGMzgQc+yITlbtS3HLEx5R3YSy3uzlBlt36zL5ErBS3CA6749Vg9UjEEgOaemqkl/fYsF0CLBy
	d6lAVuVFxRaKluOzCxUZ5yBZI053JPPxhMUKGn5ChwCbxp6H33PU6rV3c1dxbTMKXic90iGrWHG3O
	3lAxmdI+G+IElxmJVdxQmwWWE4hqfNOrmOFLgD31AxJ1uoiP+NSYmqsoIh+nmXFEZePzLAtzj8Qe6
	cSCkb7HQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vD89A-0000000HQQ6-0aNJ;
	Sun, 26 Oct 2025 21:19:28 +0000
Date: Sun, 26 Oct 2025 21:19:27 +0000
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
Message-ID: <aP6QX_gNpY9UDtub@casper.infradead.org>
References: <20251023080919.9209-1-hch@lst.de>
 <20251023080919.9209-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023080919.9209-2-hch@lst.de>

On Thu, Oct 23, 2025 at 10:08:54AM +0200, Christoph Hellwig wrote:
> +/*
> + * Make the first allocation restricted and don't dump info on allocation
> + * failures, for callers that will fall back to a mempool in case of failure.
> + */
> +static inline gfp_t try_alloc_gfp(gfp_t gfp)
> +{
> +	return (gfp & ~__GFP_DIRECT_RECLAIM) |
> +		__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
> +}

Comparing to the kvmalloc code:

        flags |= __GFP_NOWARN;

        if (!(flags & __GFP_RETRY_MAYFAIL))
                flags &= ~__GFP_DIRECT_RECLAIM;

        /* nofail semantic is implemented by the vmalloc fallback */
        flags &= ~__GFP_NOFAIL;

it's quite different.  I am by no stretch of the imagination a GFP
flags expert, but it seems to me that we should make the two the same
since they're both "try to allocate and we have a fallback if
necessary".  I suspect kvmalloc() is called with a wider range of
GFP flags than bvec allocation is, so it's probably better tested.

Is there a reason _not_ to use the kvmalloc code for bvec allocations?
