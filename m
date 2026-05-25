Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F878F26;
	Mon, 25 May 2026 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689188; cv=none; b=rKg35Li4v1mjHCaOcFgZ7XJlBErGSKLxOyvr+/ozNj7aWUQ+2hbKn9W9WQUsZ0MA2/+W1c+FALp46Uv3WanXRK10kYx49MURxrqiVwMa+eWijEev63a8KcyAu5Xa7gckouaGxa3aneLRWFdwvUY8e1+ecn/ZCn4gp+HDLWNpSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689188; c=relaxed/simple;
	bh=r8SZRu6BVjs8nqCc6dXH7Lbm64FKjj1L9TXIyGMRvDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcdvhXPik5QveVRIwVmNlbS3FejWR4ZuI3OfPk7nfxIGbIjdYkZ+fRGLEuZcvNccNrD/nXzP88t546yOG2l4lc8y+WNspi8m1bPpgOe3bPJ14cPHgSuDTaxLL5yGsRSdvjMwVpeBZfdcDfb3ao+lqq/cmrRJsJXjYbW+uF4KTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UnVWwF+l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UnVWwF+l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=986yaGrKoJSOJhdlfpUSauWqpRksnsFf/VS0QhNcKHk=; b=UnVWwF+l8iuhC/sPfP0CfMEYA1
	L4l7nNP/OKmuR+fWUIaFrGmQcCGlC012IWTFMMdkNwUpX4VL1d5wy4ChhYsV+B26mLd5szFH148cG
	pSfpEZHaH4BaeBnujdXMTk8KrywUoPc1Ar8+zdlp3gvbdW2BZ/wO/oLBrTdyCsJWLqKb+slRiFYhF
	S64MODfMQP3Qe9FsJPvVVoc80V0SC2Z1uOcu/kAM95dPNL15SAxo/YZQVcRtNGJ7CH8l1vejoXVuX
	sy5h2DhsfaM62ooZAUaBqCu53lQakPVca6mBMVlPO+zDFGuXS4zbR7FoSmc1+c8qtpyamIg0ors8X
	GlfNjeKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROSI-0000000GNoL-39ro;
	Mon, 25 May 2026 06:06:26 +0000
Date: Sun, 24 May 2026 23:06:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-mm@kvack.org, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] block: Add bvec_folio()
Message-ID: <ahPm4h2gKgyEEuvV@infradead.org>
References: <20260522182122.2489391-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522182122.2489391-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +/**
> + * bvec_folio - Return the first folio referenced by this bvec
> + * @bv: bvec to access
> + *
> + * bvecs can span multiple folios.  Unless you know that this
> + * bvec does not, you may be better off using something like
> + * bio_for_each_folio_all() which iterates over all folios.
> + */
> +static inline struct folio *bvec_folio(const struct bio_vec *bv)
> +{
> +	return page_folio(bv->bv_page);
> +}

The comment here is confusing.  bio_for_each_folio_all is a helper that
only works in the submitter side, and not for anything using the
bvec_iter required for drivers or anything else sitting below a
potential bio clone/split or using bvecs from an upper layer (like
ITER_BVEC direct I/O).  Additionally bv_page can be a different
page than the fist page due to large bv_offset on split bios.

So I'm not against the function per se, but the documentation must
explain the minefields it is stepping into a bit better.

