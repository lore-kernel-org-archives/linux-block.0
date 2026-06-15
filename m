Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3AE3D9680
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516257; cv=none; b=CEHZcUX2wuOY05vvp3IDjKVP8ImRGqo8vXsLON5ws22gfRwcxfim37pb5mGlZ4dkvDdyAQtkH6c5XRBWn/fqjQhOyaaBmtFhiC/tT5bkxY52X7kGIDdhrDcnbMqQIieYX5+emIV51UIpR3Qi+Cg6CL2CeiZURVglVUKpL6i14a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516257; c=relaxed/simple;
	bh=loO7NKvVN2w4jdLRqXCSQgo+PxShILO2+o1PEOYLT9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9ZxENqqX5x4LAQP4VU/PXrEZlzsy5fypI7TpbFyQzH7JGi2J/ay/P5lGpwCleZudYsaQAv4R0n0SMwfMpXCUMr7RdY3TaHXi/40/feBOWZZwLIqHoYnx0E7pHvnsGJKmbBVnfC1F8s+u+s1Ol3KjExfPZewYE/Qpd55CBReDTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG9tM7zJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG9tM7zJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA88E1F000E9;
	Mon, 15 Jun 2026 09:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781516256;
	bh=WR/YhRIjrcgfhabCmiKbG77MgKVQDcqKJj7Fb/dEAuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aG9tM7zJVCKWgX1rNb1qNjvT2o8vLChR43pnjWb3zCckGeC+iM1p5d5LcVw38bKPQ
	 DBm6Fu4BJ16c94vHEjxEBlPhWBTrFZTUJwx7Rq97bdq1rvnDWdIEckJ5wql6yc95VF
	 VitMGe/KPNBu2oGr0/Pd2QnWhncwBOwMCj9GUGPWnLjC0CCya/G7LMDUY/T/VVd4Ps
	 XfxCarovthpAwBHel+ttx9ojRLp1CuH8uxiJ6tinWb1ILozoLXJY3pu3Mk76t1sxFf
	 hxPiyt17zkQQObbwxwxC6B+CCBUZ675qc7IdX02t402ry+CvE9hW7mBeQkP4D8b2Vx
	 4r5jQje/vDcww==
Date: Mon, 15 Jun 2026 11:37:31 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: check bio split for unaligned bvec
Message-ID: <ai_HjZqVRX2Xuf1E@nidhogg.toxiclabs.cc>
References: <20260612223205.465913-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612223205.465913-1-kbusch@meta.com>

On Fri, Jun 12, 2026 at 03:32:04PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Offsets and lengths need to be validated against the dma alignment. This
> check was skipped for sufficiently a small bio with a single bvec, which
> may allow an invalid request dispatched to the driver. Force the
> validation for an unaligned bvec by forcing the bio split path that
> handles this condition.
> 
> Fixes: 7eac33186957 ("iomap: simplify direct io validity check")
> Fixes: 5ff3f74e145a ("block: simplify direct io validity check")
> Reported-by: Carlos Maiolino <cem@kernel.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Jens was quick enough but if needed anyway, I've tested this locally,
so:

Tested-by: Carlos Maiolino <cem@kernel.org>
Reviewed-by: Carlos Maiolino <cem@kernel.org>

> ---
>  block/blk.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 1a2d9101bba04..004048fa0c5a8 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -404,6 +404,8 @@ static inline bool bio_may_need_split(struct bio *bio,
>  	bv = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
>  	if (bio->bi_iter.bi_size > bv->bv_len - bio->bi_iter.bi_bvec_done)
>  		return true;
> +	if ((bv->bv_offset | bv->bv_len) & lim->dma_alignment)
> +		return true;
>  	return bv->bv_len + bv->bv_offset > lim->max_fast_segment_size;
>  }
>  
> -- 
> 2.52.0
> 
