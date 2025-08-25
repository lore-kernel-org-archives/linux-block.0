Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC211DB54C
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129619; cv=none; b=OFZ539KFMNi/dbmIkly2XmtulHenZoXBJXdnGnvwzuvhzlRc0ADTqAeG87sdakXi3BZNCtwuCM+07YpbWe10POLTdzLr88i/n5olrD+XjAA73tGX0ompAVT7R74OOHBDy9VOjNhBR8qmAnrTTfrJSZiT/psssWVVXlajY+YGaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129619; c=relaxed/simple;
	bh=Ry04do6buW4cQ98rpi/43eNvs0uz0HJIYqKY1/BXDCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAn6N1uQmQG6k/evW8DPfzF1DMARxUeM292lEM4MW+rHSHUMRmPRgt8L8J0S8CVqBJSjhkS27dPim5ZuGet4fsletWVZTKIA0V8dZ8FEeRhrnG9H6fOl/EbnPZJKZkY9wMFRec+TfBIWxp1hTGS2Gj21asoh250vA1AhFwkJexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=acanBRuE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="acanBRuE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H97IW4yLW8X5kx49pR9Pd/DSwq2doQEkPk1XM5QP8h0=; b=acanBRuEmLIBHqVYdAwgv8pafV
	TwDspYhVvp3PsoR+gqqDu3HEGpU4BIe2zflw5EzXA1pK0fC6VSbRBv7HioGCuhye9+ezjr5wvfV4D
	BT4iilrKH6VF4z30Vg86/cvtwH+KCKn1y+sWwcEO49xnWKWaIKpvZ8aPUuglc+gwTHYf8fpVb6DxP
	QcvsJtSo2B9762oSPVG0gsEFDMWpcGvF7G4wXm7BsYdbQLVoOTEso7jPsxp5egnPr7F0BA7Ax65lO
	uKT3mjAd4yrrHelaj7i2oXG4XbNtSrmW5TxS1UjP0mEKGA6Z/HYJB1edACTmO1gl7Xt4wapP2VNXj
	i1czDSqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqXX8-000000088cd-2phP;
	Mon, 25 Aug 2025 13:46:50 +0000
Date: Mon, 25 Aug 2025 06:46:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <aKxpSorluMXgOFEI@infradead.org>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821204420.2267923-2-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 21, 2025 at 01:44:19PM -0700, Keith Busch wrote:
> +static inline unsigned int bvec_seg_gap(struct bio_vec *bv, struct bio_vec *bvprv)

Nit: overly long line.

> +{
> +	return ((bvprv->bv_offset + bvprv->bv_len) & (PAGE_SIZE - 1)) |
> +			bv->bv_offset;

But what's actually more important is a good name, and a good comment.
Without much of an explanation this just looks like black magic :)

Also use the chance to document why all this is PAGE_SIZE based and
not based on either the iommu granule size or the virt boundary.

> +		if (bvprvp) {
> +			if (bvec_gap_to_prev(lim, bvprvp, bv.bv_offset))
> +				goto split;
> +			page_gaps |= bvec_seg_gap(&bv, &bvprv);
> +		}
>  
>  		if (nsegs < lim->max_segments &&
>  		    bytes + bv.bv_len <= max_bytes &&
> @@ -326,6 +335,7 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
>  	}
>  
>  	*segs = nsegs;
> +	bio->bi_pg_bit = ffs(page_gaps);

Caling this "bit" feels odd.  I guess the idea is that you only care
about power of two alignments?  I think this would be much easier
with the whole theory of operation spelled out somewhere in detail,
including why the compression to the set bits works, why the PAGE
granularity matters, why we only need to set this bit when splitting
but not on bios that never gets split or at least looped over for
splitting decisions.

>  	enum rw_hint		bi_write_hint;
>  	u8			bi_write_stream;
>  	blk_status_t		bi_status;
> +
> +	/*
> +	 * The page gap bit indicates the lowest set bit in any page address
> +	 * offset between all bi_io_vecs. This field is initialized only after
> +	 * splitting to the hardware limits.
> +	 */
> +	u8			bi_pg_bit;

Maybe move this one up so that all the field only set on the submission
side stay together?

