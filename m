Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE531547F2
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074469; cv=none; b=p21+Uv0/jTb7RkidUK2Xt1A2dar20qFXeiCnv9xmsYd5akT73UdWdAId2wrSzli9jgHXfQB4ZgRRAF4Gy2ZBJ1msxX3e4vTO6cB8VCyLlRbsgYkC0cmetbGRP/eeWzYCTT6FL7hzg2W/CoXThTWHoiU44ZQw9yoebXSN6PCZ20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074469; c=relaxed/simple;
	bh=YfCRXc/C9XtPqQIh2Wer9izWZTYk0OHESxxgMaKNAdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFVbphbRlrw8HXQy1t57bHPIojXNEGK/V1IXnuBBlb4WG4J7ubqXIVd+rkpbR3niEyHiPXiP4DQWMdxTgQuA3pjUw6EtSxJUzadsWYVC0FCjg+5uMHtAYri6nLFpIapkWGZQKBY99SHDJeqlKEFd5Rl/6RJ8udi/11ez8LH94Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B16D227AAD; Fri, 10 Oct 2025 07:34:23 +0200 (CEST)
Date: Fri, 10 Oct 2025 07:34:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 1/2] block: accumulate memory segment gaps per bio
Message-ID: <20251010053422.GA16037@lst.de>
References: <20251007175245.3898972-1-kbusch@meta.com> <20251007175245.3898972-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007175245.3898972-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 07, 2025 at 10:52:44AM -0700, Keith Busch wrote:
> +static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
> +					struct bio_vec *bv)
> +{
> +	return __bvec_gap(bvprv, bv->bv_offset, U32_MAX);
> +}

I find this helper (and the existing __bvec_gap* ones, but I'll send
patches to clean that up in a bit..) very confusing.  Just open coding
it in the callers like:

	 gaps |= (bvprvp->bv_offset + bvprvp->bv_len);
	 gaps |= bv.bv_offset;

makes the intent clear, and also removes the pointless masking by 
U32_MAX.

> +	/*
> +	 * A mask that contains bits set for virtual address gaps between
> +	 * physical segments. This provides information necessary for dma
> +	 * optimization opprotunities, like for testing if the segments can be
> +	 * coalesced against the device's iommu granule.
> +	 */
> +	unsigned int phys_gap;

Any reason this is not a mask like in the bio?  Having the representation
and naming match between the bio and request should make the code a bit
easier to understand.

> +
> +	/*
> +	 * The bvec gap bit indicates the lowest set bit in any address offset
> +	 * between all bi_io_vecs. This field is initialized only after
> +	 * splitting to the hardware limits. It may be used to consider DMA
> +	 * optimization when performing that mapping. The value is compared to
> +	 * a power of two mask where the result depends on any bit set within
> +	 * the mask, so saving the lowest bit is sufficient to know if any
> +	 * segment gap collides with the mask.
> +	 */

This should grow a sentence explaining that the field is only set by
bio_split_io_at, and not valid before as that's very different from the
other bio fields.

> +	u8			bi_bvec_gap_bit;

Aren't we normally calling something like this _mask, i.e., something
like:

		bi_bvec_page_gap_mask;

