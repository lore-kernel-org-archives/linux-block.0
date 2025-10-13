Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F6134BD
	for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391212; cv=none; b=gYZLhMCo6vj3UQEToYvJTqaD/+jduEvpsP1YyqxSrUEO/K7DH3Wtp88JtOM9aJ/79oEcbbUPDU2gzyiVnYNi5Wmy4aK83UMi9uFT+DE/351M8xm/xS2FJhZUP33nAaaZWPYvhM1o3Tt38rrPVcq/M+3ael75YxbRWAzqqyRG+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391212; c=relaxed/simple;
	bh=fVjAtspCNb2rqf+Y3yjxYHV27MVAQ3+/wEk9FKkdcR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsLymPRkPi1Y4zuSXpbsntak/Lyts+KlLJm8eg+4Jkn1dcnZkTKJA5ngYsOnbGx/dysa/XImcNN14YmMmkUISnMuPGrhM+i24kARl7XVTrkQVdbkbgSwClqMIP3DttJ7X7GvDLjxK1Q6r5OxLPwlL5kEuSfZPDxPhH6BKIqX/lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQh7sJ5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQh7sJ5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1989C4CEE7;
	Mon, 13 Oct 2025 21:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760391212;
	bh=fVjAtspCNb2rqf+Y3yjxYHV27MVAQ3+/wEk9FKkdcR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQh7sJ5WpoOuXY6jMTLJr9zMVD9AKDpQq702xFMMD9FUym+FU1riSlFON7Pl/JCFP
	 syOzlJZi5yNkPXdqjMrtZKYvG8ZjYfsCI4QCHs51YkC5CjnpICTlEFvpU9BXPnZ4m7
	 kRo5jAKijTSEJulO2Ec3tfehzIlOdmD30cXzytu1GW4+NYLzQlv4YcA0ppiXttJ7DK
	 OW3mOG307fGWfHcTCGtkR9yylve6B0//JL2puObj4FLX/RaDUJx8tOlv/tTOgmcJvq
	 tV/j9UGPCNkePo6I0Xjc8iUyg5sx94zBYSbZO8jAQNl8CnbZqvQe/vZoaMIG77XwhQ
	 c3qbFRxgxKwOg==
Date: Mon, 13 Oct 2025 15:33:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCHv4 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aO1wKjAeaOmFySCC@kbusch-mbp>
References: <20251007175245.3898972-1-kbusch@meta.com>
 <20251007175245.3898972-2-kbusch@meta.com>
 <20251010053422.GA16037@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010053422.GA16037@lst.de>

On Fri, Oct 10, 2025 at 07:34:22AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 07, 2025 at 10:52:44AM -0700, Keith Busch wrote:
> > +static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
> > +					struct bio_vec *bv)
> > +{
> > +	return __bvec_gap(bvprv, bv->bv_offset, U32_MAX);
> > +}
> 
> I find this helper (and the existing __bvec_gap* ones, but I'll send
> patches to clean that up in a bit..) very confusing.  Just open coding
> it in the callers like:
> 
> 	 gaps |= (bvprvp->bv_offset + bvprvp->bv_len);
> 	 gaps |= bv.bv_offset;
> 
> makes the intent clear, and also removes the pointless masking by 
> U32_MAX.

Sounds good, I'll rebase on your cleanup patch.

> > +	/*
> > +	 * A mask that contains bits set for virtual address gaps between
> > +	 * physical segments. This provides information necessary for dma
> > +	 * optimization opprotunities, like for testing if the segments can be
> > +	 * coalesced against the device's iommu granule.
> > +	 */
> > +	unsigned int phys_gap;
> 
> Any reason this is not a mask like in the bio?  Having the representation
> and naming match between the bio and request should make the code a bit
> easier to understand.

I thought it easier for the users to deal with the mask rather than a
set bit value. Not a big deal, I'll just introduce a helper to return a
mask from the value.
 
> > +
> > +	/*
> > +	 * The bvec gap bit indicates the lowest set bit in any address offset
> > +	 * between all bi_io_vecs. This field is initialized only after
> > +	 * splitting to the hardware limits. It may be used to consider DMA
> > +	 * optimization when performing that mapping. The value is compared to
> > +	 * a power of two mask where the result depends on any bit set within
> > +	 * the mask, so saving the lowest bit is sufficient to know if any
> > +	 * segment gap collides with the mask.
> > +	 */
> 
> This should grow a sentence explaining that the field is only set by
> bio_split_io_at, and not valid before as that's very different from the
> other bio fields.

I didn't mention the function by name, but the comment does say it's not
initialized until you split to limits. I'll add a pointer to
bio_split_io_at().

> > +	u8			bi_bvec_gap_bit;
> 
> Aren't we normally calling something like this _mask, i.e., something
> like:
> 
> 		bi_bvec_page_gap_mask;

A "mask" suffix in the name suggests you can AND it directly with
another value to get a useful result, but that's not how this is
encoded. You have to shift it to generate the intended mask.
