Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F01262FF1
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931869; cv=none; b=pzSGo17vmqgkpicEsEp3tbN68R8Gvdwspwv7wZWtADGwu3GNSkObovrSjpItU+xu4m1dIbVnvKdcdhzpkFIQLz9I8e+b0zLclIe8fwSFsifvsq6XhJfegVFd70dLQ0Ii2y4lRVYDIrMvAzoPDmw3BKixUy7kbsROALx31+H0yLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931869; c=relaxed/simple;
	bh=Ecj87zoz6oG5gEz5gvHsxO9dOS+oW9Yi3vJa1BWXwkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQj+UaQUbPtEm94Iu+jaLlDiHvOFkP6KUqhWJUgYbTSosuDcYkukv9n+v9ak+stsB68JgeXtkwhB6INs+lEAnKB1z+kSr3Yz5YcKFsZGiJ//B5rhv0/IBBrHizAxvJzhXvDocKdgXmrVNGNg//aPFgNhm4ieWIcE5/nS5dUkjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xchs4eKm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xchs4eKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F4EC4CEED;
	Mon, 11 Aug 2025 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754931868;
	bh=Ecj87zoz6oG5gEz5gvHsxO9dOS+oW9Yi3vJa1BWXwkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xchs4eKmNggSJdqfNvpFpse1O/4VGIDeVv5P7Yr470BhGmhcnvDGlrwOJEaMwHjd0
	 sNOIv3+i2eHmnALzkCJ6+E/Fbpyd2sRW9gkPasFvOH6h2KXfA/jv1z3o89ip6oL5wT
	 Lwk+ShVALh8PBhz4zLRbhj7H8u+7TMffylcfsJjMKf2HU5MHF7Sl02SdDJ5nw1TQPD
	 bHJ+jxuj9WhfGrVnKgBxYL6PQashl7UmTN4ZFfedgm32fNxP1NgF32wQma5+9uhEg8
	 5tSji9+ezJ4uQzwgj00aINh2ufAKBJN9wpSzwVcYjIBQnKl36M3Xv1Jvse54WoUXpv
	 XRy9X9ClG5QVw==
Date: Mon, 11 Aug 2025 11:04:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	joshi.k@samsung.com
Subject: Re: [PATCHv5 2/8] blk-mq-dma: provide the bio_vec list being iterated
Message-ID: <aJoimodJJqodW7Kl@kbusch-mbp>
References: <20250808155826.1864803-1-kbusch@meta.com>
 <20250808155826.1864803-3-kbusch@meta.com>
 <20250810140747.GB4262@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810140747.GB4262@lst.de>

On Sun, Aug 10, 2025 at 04:07:47PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 08, 2025 at 08:58:20AM -0700, Keith Busch wrote:
> > +static struct blk_map_iter blk_rq_map_iter(struct request *rq)
> > +{
> > +	struct bio *bio = rq->bio;
> > +
> > +	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
> > +		return (struct blk_map_iter) {
> > +			.bvec = &rq->special_vec,
> > +			.iter = {
> > +				.bi_size = rq->special_vec.bv_len,
> > +			}
> > +		};
> 
> These large struct returns generate really horrible code if they aren't
> inlined (although that might happen here).  I also find them not very
> nice to read.  Any reason to just pass a pointer and initialize the
> needed fields?

I initially set out to make a macro, inpsired by other block iterator
setups like "bvec_iter_bvec", but I thought the extra cases to handle
was better implemented as an inline function. I am definitely counting
on this being inlined to produce good code, so I should have annotated
that. No problem with switching to take a pointer, but I doubt the
resulting assembly is better either way.
