Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAB1D2F46
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804849; cv=none; b=XDWekWW8x9hwnMJl8EkEOT5Bi68J+zYu5E5rlTqv9vxfksR1Xn723Kh7hnUNf2oX4CmHmF7iOjw1Po05/DE0QF/6hly+/yDX6uanyhrxNQYHFpdABd9GIs8oqLnbWXd5jclG2MiB5PMt88M4kDcV2xUH7a1SYgY3C2WYRGrYgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804849; c=relaxed/simple;
	bh=0UTtxMe/wXh/DXRcmwgTQp3zqxNkzYeGvXtA88ILtSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fatuwaWXvdVf6/kblZgyyKs+exFedIuK6k35HFdYEx8Xca2vYkovyYW0/xJ1gu9qKF58gcKCzh3TvWnccYgvZOV0MwmEJCkumyYyitgEsOiJxtfA23Z9wEbsDDm4WTnVmRcsVNtAXGoiL/ySVcjNcIM2+3GjN2IsOLH5KP7ociI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XkBuF1Jl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XkBuF1Jl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0UTtxMe/wXh/DXRcmwgTQp3zqxNkzYeGvXtA88ILtSU=; b=XkBuF1JleOhYUg3+tjsfIgWKge
	ZjcHtqf2yhNbr9DxSYuK4k4DV+Md57IAIb45Xsoowm+6vgDaGuw/+XVm9aLXBTG7PRJuem/3A6aOA
	FTKyqg8ZeyLaJRPXZZcx2f4zrDFzkL0xbPChnhqp3thIUujrSRqC2nW/P+YxKQ7Q65BouWgQGo20i
	V5gIcZXTsOZj/9S62EI4LaKVjSxdw1M5QX2wrZ90lMWwUAZg4CY/u/FIF69D14Vla+K9BR/8LQIVB
	As4zN9s+ZWxXXSOJ0GykF73R668HNG6Pzs7i6dFVP0RvZYw2PGAeLiRnv+uFllul4lMSa+IO/4SK3
	V390asfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t8HPD-0000000GmuX-1NSr;
	Tue, 05 Nov 2024 11:07:27 +0000
Date: Tue, 5 Nov 2024 03:07:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: LongPing Wei <weilongping@oppo.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix the initial value of wp_offset for npo2 zone
 size
Message-ID: <Zyn8b12XCJyjr0rr@infradead.org>
References: <20241105101120.1207567-1-weilongping@oppo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105101120.1207567-1-weilongping@oppo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 05, 2024 at 06:11:22PM +0800, LongPing Wei wrote:
> The zone size of Zoned UFS may be not power of 2.

.. which is not supported by Linux to start with.

