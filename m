Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2678F29
	for <linux-block@vger.kernel.org>; Sun, 10 Aug 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754837994; cv=none; b=LM5ztGsQWutBt8rPkY9HL7XovlGIPVezKuU26GYJuH9a6+pFX0UY7co2CKlTKWZ1qDR1MxBiu/v6j8Y4uHNJTIyo6ba94aBon9k5PvUBLbJK23qIkSelzL641hVK1xat/yCI6YmVvfwO7M9xc6SxqT6lcxSuMQc1s7qDods18T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754837994; c=relaxed/simple;
	bh=qfNV725Mr8CnUuDbS1sS1EoBoNJ33DFbCSgn70RJHCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA4D5C5NaUKG/Y96cNTbsHdlqWF4ridCMb+bkVlZLSYNwyK/xu7uosYjFIMDxIuDxGgr/yN4lUM9MstBRwprZ3SYPLsb45R0zwWlgL+hR6IhWa8p7FQyHLJfb2iXi0lFKDpZjip5LL2f4JgBNqDi3fqSoK3ywYis5slKoO1sCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EDD8768BEB; Sun, 10 Aug 2025 16:59:47 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:59:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] nvme: remove virtual boundary for sgl capable
 devices
Message-ID: <20250810145947.GB5444@lst.de>
References: <20250806145136.3573196-1-kbusch@meta.com> <20250806145136.3573196-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806145136.3573196-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	lim->max_segment_size = UINT_MAX;
> +	if (!nvme_ctrl_sgl_supported(ctrl) || admin ||
> +	    ctrl->ops->flags & NVME_F_FABRICS)
> +		lim->virt_boundary_mask = NVME_CTRL_PAGE_SIZE - 1;
> +	else
> +		lim->virt_boundary_mask = 0;

We start out with a virt_boundary_mask by default, so the else branch
here can go away.  This would also benefit from a comment explaining that
we only need the virt_boundary_mask for PRPs, and that as soon as SGLs
are supported for a given queue we don't set it because we don't want to
pay for the overhead it generates.

>  	if (nvmeq->qid && nvme_ctrl_sgl_supported(&dev->ctrl)) {
> -		if (nvme_req(req)->flags & NVME_REQ_USERCMD)
> -			return SGL_FORCED;
> -		if (req->nr_integrity_segments > 1)
> +		if (blk_rq_page_gaps(req) & (NVME_CTRL_PAGE_SIZE - 1) ||
> +		    nvme_req(req)->flags & NVME_REQ_USERCMD ||
> +		    req->nr_integrity_segments > 1)

And this would also really benefit from a comment explaining the high
level rationale behind the checks.

