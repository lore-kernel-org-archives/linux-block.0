Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523858ABC
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 04:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725424497; cv=none; b=Fx0graz7KDORoyVAicltpjTDSju006fRXKKXwlzsyTY1UQFH/19sOL9JaNgQ8P9AwhZC4igDxY+qntXUx3n8IF7PmJwxDNt8hbYPD8e5z9V4792BMjY7O2odRlslYdqQpboap0aMgCYNnqSOy23t30U8NTg8z/ldXZAdK3ExeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725424497; c=relaxed/simple;
	bh=+k6Nj5dkibEe+Qv9O0H9IO720XE/C+et0fZLEIMlp60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDosFs4xDUa5cgmo9k0NvRYki0NVLZNMW9fR5tiwYqJ3b82lHeMzbNnVV6Ya6PY9oLOyM0ETIcF7Kt+AkIUKtIwG6Ur7u4pRz7bWjbovhLwlh2Y7E2X4ks8Dhk4ZOF9b12FKMqcZcUBYtJ/HCHe8LekDujmkKEx7A/OILzJSprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dg9iIc24; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dg9iIc24"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B/X+Sb7lXKE4U+CGzHVXeninhCtwxxVMyYsi/9F9S4U=; b=dg9iIc24MlcLqAJVMGvLdAbRR8
	C30JCxkbhyZLcAJz/4f1WNoslGeYemF6Qms4C98GDtMjOyOPLxjWADEN4s369i5UqhoQmdG40tnJ3
	8Y9vYDjqsL3BJoOvBkwbYb/U+myZzyQVkpHR/twoUFm4BZ307RwuYbbrprb8mPOSYN1EuyerrL61A
	TumPviHbcRoCc5ziD88LUfyjj4W7lTmJJD4SerOhlUgKaeVo5W+X+I5yUi8hEX+5o9lK8WD55maw5
	g4JA9t78IDcAQRfimh4OxGwUEo2UDPu6Yb/d6dKBX/vd6lRAsEaR4vHXaI8OltwWDxelGN36GHCzN
	EX8a9atQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slhjL-00000002o5I-1MdS;
	Wed, 04 Sep 2024 04:34:55 +0000
Date: Tue, 3 Sep 2024 21:34:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] blk-mq: set the nr_integrity_segments from bio
Message-ID: <Ztfjb8UlOfHYtMTT@infradead.org>
References: <20240903191325.3642403-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903191325.3642403-1-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 03, 2024 at 12:13:25PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This value is used for potential merging later.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
> Check the bio actually has integrity before counting the segments. I
> previously tested v1 with additional experimental patches atop that
> addressed the problem differently and didn't notice the obvious API
> requirement.
> 
>  block/blk-mq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 36abbaefe3874..3ed5181c75610 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2546,6 +2546,10 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
>  	rq->__sector = bio->bi_iter.bi_sector;
>  	rq->write_hint = bio->bi_write_hint;
>  	blk_rq_bio_prep(rq, bio, nr_segs);
> +#if defined(CONFIG_BLK_DEV_INTEGRITY)
> +	if (bio->bi_opf & REQ_INTEGRITY)
> +		rq->nr_integrity_segments = blk_rq_count_integrity_sg(rq->q, bio);

Hmm.  The current model is that drivers are supposed to
clal this, which they should stop doing now that the block layer
maintains this count.  So I think this needs a bit more work, after
which blk_rq_count_integrity_sg is also unexported, nad preferably
also has a name that drops the incorrect _sg.

