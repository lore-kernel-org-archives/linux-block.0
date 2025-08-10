Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1FAD51
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754834876; cv=none; b=tDWCJdsdpsrJqCsJhNxLswNauk4zYWao5bGZBX93wuxy+Y8Z2zV1qeszk0UebkFqIzHKGEz7ni+zVtbj93DyRerKjtGkCjgV5IwEOTi/wXhs+bQZ7MVSRly7RBHTitrSNIzCBYf+FA8n+QfUA//jyEEUCnTv/w+cY0fjfx/BvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754834876; c=relaxed/simple;
	bh=jabtNIpznrRT7TNrWVX3F3qFbl6GR4LysqElNFXYwFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0MR8KFTijhIEKoTxz48W8Xnk3qxglZlJuwe35UsDUjKgsRB5epDoagHfj5CmUp38h6/T1pnJ+ntnplyGjyU4KjtKpqpHRNqnyM/CAz8uMFLUUkcF3drhFJ6dzryoWk800s3K7m+NAFcjYGOTaiU475wudNiXs9W38ufeWRYVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B3E4E68BEB; Sun, 10 Aug 2025 16:07:47 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:07:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 2/8] blk-mq-dma: provide the bio_vec list being
 iterated
Message-ID: <20250810140747.GB4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 08, 2025 at 08:58:20AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This will make it easier to add different sources of the bvec table,
> like for upcoming integrity support, rather than assume to use the bio's
> bi_io_vec. It also makes iterating "special" payloads more in common
> with iterating normal payloads.

I would call the array a table (or maybe array) and not a list.

> +static struct blk_map_iter blk_rq_map_iter(struct request *rq)
> +{
> +	struct bio *bio = rq->bio;
> +
> +	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
> +		return (struct blk_map_iter) {
> +			.bvec = &rq->special_vec,
> +			.iter = {
> +				.bi_size = rq->special_vec.bv_len,
> +			}
> +		};

These large struct returns generate really horrible code if they aren't
inlined (although that might happen here).  I also find them not very
nice to read.  Any reason to just pass a pointer and initialize the
needed fields?

Also this function probably should be named blk_rq_map_iter_start or
blk_rq_map_iter_init as it only is used for the very first iteration.

