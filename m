Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2608C382295;
	Wed,  8 Jul 2026 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500352; cv=none; b=mcmLJKeshdGP2x/M/K9bdxZhAGt2KDNZ2QiImulpU+GV4k9zeIo1Geb4yQo7HqOsmGBJ/bJrNNGVxhDIVmEXMrTWPthWk4QU52GhbC/rXJuT1h1Ma91q5unR0z1DStnfY1koEuZHslete68sRhhsl3nHkYdDobP3EQczU0T9Y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500352; c=relaxed/simple;
	bh=3JZNr1RDCfSuvxhXYox0x+V1sVb4J8CXnx8ZGRkTw8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHRmKXem3KElDd2DpgXoxrHjfdIsQJXjKJX0wT8G6H/u62os+Jh3wJYgkHwCd42vgL5/QrWMXjTatGWiRRSY0zb0MScGwYiGR4yPTDdiTJuU8ZRe7TTrBVywIYmenfkOhE66ya8gAtBeFzwbL6kP1qHnKttOLMj/e073xsgxsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B09F68B05; Wed,  8 Jul 2026 10:45:47 +0200 (CEST)
Date: Wed, 8 Jul 2026 10:45:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baokun Li <libaokun@linux.alibaba.com>
Subject: Re: [PATCH] block: fix bio_alloc_bioset() percpu cache fallback
 for non-reclaim contexts
Message-ID: <20260708084547.GA3591@lst.de>
References: <20260708011413.1710118-1-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708011413.1710118-1-joseph.qi@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 08, 2026 at 09:14:13AM +0800, Joseph Qi wrote:
> This causes virtio-pmem flush (async_pmem_flush) to fail with -ENOMEM
> whenever the percpu bio cache happens to be empty (common right after
> boot), making the device effectively unmountable:

Please fix that to not sure GFP_ATOMIC instead.  Flushes are used
in file system writeabck and must not use potential failing allocations.

Even if you slightly increase the chance of it not failing, it still
can and this code is simply broken.

> Fix this by restructuring the allocation so that the percpu cache is
> tried first when applicable, and the slab allocation is always attempted
> as a common fallback path when the bio is still NULL.

I don;

> 
> Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  block/bio.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index f2a5f4d0a9672..9e7939861b94a 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -553,6 +553,11 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
>  		 */
>  		opf |= REQ_ALLOC_CACHE;
>  		bio = bio_alloc_percpu_cache(bs);
> +		if (!bio) {
> +			p = kmem_cache_alloc(bs->bio_slab, gfp);
> +			if (p)
> +				bio = p + bs->front_pad;
> +		}

But even if we wanted this, this code should not be duplicated by
share the common version.

