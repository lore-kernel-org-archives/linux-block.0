Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504AD266
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mUM4+N4j"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB81AC
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 23:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AH8WGhcd8CqS7z1U6ywDEtvegIwXVO5zjhXjAFO8dYw=; b=mUM4+N4jWFDLb7D/TwQGIW1CHE
	WlZ4xw97srF1hcJc9hL/FTvLBEWtomUJ5G4v6+G/okG7RUBxT6Z5W32k8lReojnpVXb7mJPeezXqs
	mJ6kK38kDnvxQXl6PtGjQHrWIV31O7y/wpdjc9nbx749dJgX1giOeppFOKKWx0pZWKqPuabCH2/kq
	B9D9Od9ZqqtlsWf9ZNY6fYr7LkO37C+eTlMGv6gcw5A+jVijtZrVZnmrqse/YFAlE4SV3yO1oHVbj
	qTgWJr1zjLG67OoMTENbhucFUwgaPUYzNa6S4nmA8eaeVVVh6bD8otIGzJoMs2VdlPMqlMP/zHGdv
	vyJSklbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0czG-003BFs-0p;
	Wed, 08 Nov 2023 07:28:30 +0000
Date: Tue, 7 Nov 2023 23:28:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH] block: try to make aligned bio in case of big chunk IO
Message-ID: <ZUs4njXE7xpg04Yi@infradead.org>
References: <20231107100140.2084870-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107100140.2084870-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 07, 2023 at 06:01:40PM +0800, Ming Lei wrote:
> In case of big chunk sequential IO, bio's size is often not aligned with
> this queue's max request size because of multipage bvec, then small sized
> bio can be made by bio split, so try to align bio with max io size if
> it isn't the last one.

I have a hard time parsing this long sentence.

> +	/*
> +	 * If we still have data and bio is full, this bio size may not be
> +	 * aligned with max io size, small bio can be caused by split, try
> +	 * to avoid this situation by aligning bio with max io size.
> +	 *
> +	 * Big chunk of sequential IO workload can benefit from this way.
> +	 */
> +	if (!ret && iov_iter_count(iter) && bio->bi_bdev &&
> +			bio_op(bio) != REQ_OP_ZONE_APPEND) {
> +		unsigned trim = bio_align_with_io_size(bio);

Besides the fact that bi_bdev should always be set, this really does
thing backwards.  Instead of rewding things which is really
expensive don't add it in the first place.

