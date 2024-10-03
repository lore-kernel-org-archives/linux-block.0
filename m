Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6D1993A9
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960979; cv=none; b=u26JpsxNb69nm+HBIcQLad6n8VgaqWSCr1pvWA0XzNZ+G0dXW8RNlxaPdAnidUmolZ2WvjOpU7Xw1GgSVNOlDLGkX2ikFOXO9Wx7+FMEFgC9nTdGMrg0+i5q58n4mfGUgUDMPcvEXr02Y7gGdJLqrfMF3iZZUN+dsfm/cBvc8Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960979; c=relaxed/simple;
	bh=6ot1C/0xB35/OGQlchw/L0Fm0BWxrCzzOlzWfJzlSg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idzUlhG7nTB2TzNDgK4CqJbqDrxl/rcGS3DAsdWfpzNJQkEeQaHxrKq8JYVNQepssU57lGxGEyuGpH+mGEVBYEPT1xOxGiyQi6PBckfBa4tCujt0tZAA/Fbv+I6KSBDbQmV8EjUbZt9mr2zt8agUwGpJTS+OWASG2cAqMakGDEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JqNB9et5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JqNB9et5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l0HwdFz0uGkcdi0D0eMo2TTtGmqiOPbl/04p6QVoDPI=; b=JqNB9et5ov90gklsDiaXjLbKee
	PhB/wxz+OVvYj5ejLgrDocJRuQYsOGxhif+qkPsPGXMfAoFbi4prIS9cWLZHC8sisilcpGLfKlbgf
	P6ViT3BqRKicASVaHaBMWmG0x/ILqblM3Yh5Scd95JzkPNuArJJJdoZmiNw0hxAR8Xw2vXnOSVFQP
	tDE3RxlRg/n4GXBw5xsMWJtmKFDnFLsISNNgMtzIjuZHnX/7A5N4PTE6iQP+JBFTKnlx3N4I/RyoD
	iM0cGy8uiRqaxccazSvcai+vhZ0jA2BmLHyV1k/ppzmeiH2orw7ZZE+txlohZYew3nLZWKAHwoYuP
	DB8C6BiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swLaL-000000097CS-2W1Y;
	Thu, 03 Oct 2024 13:09:37 +0000
Date: Thu, 3 Oct 2024 06:09:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: move iostat check into blk_acount_io_start()
Message-ID: <Zv6XkXyAQ4yiaJGE@infradead.org>
References: <550fc8a0-3461-49ac-879e-32908870f007@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550fc8a0-3461-49ac-879e-32908870f007@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

>  static inline bool blk_do_io_stat(struct request *rq)
>  {
> +	return rq->rq_flags & RQF_IO_STAT;
>  }

I'd kill this somewhat oddly named wrapper now that it is a single
check.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

