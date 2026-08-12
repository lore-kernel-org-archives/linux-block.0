Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1546EC7F
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552955; cv=none; b=LleLJxtazSNIOSt5RNM2PYj6Lj60fa+BqpMS1oMcEEFUy1ts9z0KivCD3+SeFEAslya7Bp0FpsFHnNCLzF5rCkyhKyE4O/hewHXXto+Y/NJDIvLQxAhsmiUlkJ7Th7d1ilYyqf5+I7zrNh9y/Ufnroeni6T5OhweoYFAhodpDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552955; c=relaxed/simple;
	bh=VCF2MY1+kIo1Tw1P6EI2FDgUHxg+MJ/dvPqj1xGd3AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHaPfoJCaZ9hz3IjMwAwb5R+x8AK/5BfPHSXpGrl0vt7D3JaxUDzOLNkt6/QMRUPQ/eFfhaqviY+JurbKM7a2EyjkrSPMp9zGK2qiHPTuJgQ9OMVNnIfeExd8XnRiyv0SYK47esNebYawKgzVVtoMH5hMKY6AoCxUe6Y0EYY3x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xZo2asio; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xZo2asio"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zYyVv/VSkCBeNUPda/8HISzWhGOHn8iVKa5zI9HhCI8=; b=xZo2asioaIKCmZIrbYPLgQIL2y
	DkClwmBkCjDth54b1ExW8T7Zs5ZBt9s5QUDgojHMBgQqPYqK/aQEM+gbq9Wjt0m8PHMNnwsbR8gCs
	BifuM1o8xwz8QYFgKgFJyvcLPsq2HzMk0RHLzrrsR9bq/alRpNed71T1alr67Uyf1g4jv2LTVVFCT
	0atExC/Bjg3fQCGF6WIHNI0KOK4S7BgY/eK9a7EzhBGQntoUsHQR4D6dmA/vYa918nTHzySoThlf3
	A0bWOpSHrUdljbVJaxTKjb4uW1Po5VhXs6K187CJEQ/U9brQgyS4NH01IvExBhhYVKBkGIup5Q7LN
	nQ6qLmTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuC24-0000000Gc3W-0fyc;
	Wed, 12 Aug 2026 16:42:24 +0000
Date: Wed, 12 Aug 2026 09:42:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhenxian Ma <mzx199711@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Zhenxian Ma <mazhenxian@xiaohongshu.com>
Subject: Re: [PATCH] block: skip redundant flush for O_DSYNC direct writes
Message-ID: <anyicCnbACxAiTTD@infradead.org>
References: <20260812130335.60354-1-mzx199711@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812130335.60354-1-mzx199711@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	bool dio_fua_done = false;
>  	ssize_t ret;
>  
>  	if (bdev_read_only(bdev))
> @@ -763,9 +764,13 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  	if (iocb->ki_flags & IOCB_DIRECT) {
>  		ret = blkdev_direct_write(iocb, from);
> -		if (ret >= 0 && iov_iter_count(from))
> +		if (ret >= 0 && iov_iter_count(from)) {
>  			ret = direct_write_fallback(iocb, from, ret,
>  					blkdev_buffered_write(iocb, from));
> +		} else if (ret > 0 && iocb_is_dsync(iocb)) {
> +			/* FUA from dio_bio_write_op() already made it durable */
> +			dio_fua_done = true;

This is kinda the wrong way aroud, it should just have a need_sync
variable that is only set for the fallback.

But looking at this, the original logic here actually is very fishy.
If we have a driver that does not actually support FUA, emulating it
for every write command is a bad idea.  So this should be fixed to
only do FUA when actually useful, and then return from the non-fallback
implementations if that actually happened.

