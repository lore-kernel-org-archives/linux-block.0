Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90983A14
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738043947; cv=none; b=Lyp8eS9/u9sqd1VVyPLx/n3wwbKbX7+zXQ97E8oZGLybVQjA/HDjUjBImXAHSiIVI3ND0fXTdC65foVo2otv5J51QFiFiUFe1BBbXByKxP7qkGdzVb4mHdBHrih6DcSwCR4D3xwY6Ni9D4dByTFnXifb8R4EseKlOUjKYaTW2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738043947; c=relaxed/simple;
	bh=+DbbPfbguYcYxFfZrSXm6XOPP+P7DhV5edPToM31u2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9BwxZusEtBn4AH6w2W/eqtv36hEpQ2Q9MKmnz/44oI0B5b22Pit89+aIzVLrIlA6Tbfk4YlR6Yp99ZtRToUZEuk9u61vMAg87Y97Yzef5g7Q8coHqQjVKYIh7T/ZNNdj/oaxYVNF0Z1OU1O6mwFrZTWosabgSHRUu5xuhB4iJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PgKSQCcx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PgKSQCcx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SSBdSZ2INwaqqK/sdDU1nqFFht5i2SQEyCmf9hQMXnM=; b=PgKSQCcxqC4yoy/gsXgQvmGvYf
	4q/PByUdSMvPd//PweiLNRJVoqBReP2V52RB6E/GXFjI4usWlXzuoZBCPrb3nJF+e8TtjoUKPQ2wW
	qdjjVmeTmgJ2tqQHqg9IIk6VdY5eOJ6gRdgG7YlY6NLNj/gRbW0IV2e2Kra7hJB3ZaloV311zG+36
	4B7jR7AuhxMp39mF3uS4KQ/uz7JhhuULFiJIEfkk9bhDsgMWkka3HSkoiiEZw1oAWC/lUbBVNxzkU
	c2ZTvcy+r2QcRp6hOzumRGKpMaSHfNPiYUi94zH+2mqJIZYPyzjpxU+jv9oMPTInWCLxgMS9IBQMe
	hQjHsrFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcecr-00000004BeQ-4B89;
	Tue, 28 Jan 2025 05:59:05 +0000
Date: Mon, 27 Jan 2025 21:59:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: don't revert iter for -EIOCBQUEUED
Message-ID: <Z5hyKbWbEEcxV8fg@infradead.org>
References: <47af5107-96fb-426c-961e-25d464f3b26b@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47af5107-96fb-426c-961e-25d464f3b26b@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 23, 2025 at 06:18:01AM -0700, Jens Axboe wrote:
> blkdev_read_iter() has a few odd checks, like gating the position and
> count adjustment on whether or not the result is bigger-than-or-equal to
> zero (where bigger than makes more sense), and not checking the return
> value of blkdev_direct_IO() before doing an iov_iter_revert(). The
> latter can lead to attempting to revert with a negative value, which
> when passed to iov_iter_revert() as an unsigned value will lead to
> throwing a WARN_ON() because unroll is bigger than MAX_RW_COUNT.

How did you reproduce that?  Can we add it to blktests?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
