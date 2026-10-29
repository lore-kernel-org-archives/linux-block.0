Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278588;
	b=WrkALYsg3IOeUhChhHVWSMQ4zHtIKsmM8u1xWcSAp3I8E/vOY9PRrtqLrvCx6rDmM7t8
	 ryPpb2Ox0b/H2OlkisEQ2KaCnTUgrV3AK54kbOYs0X11S0Pc267URcool/TPATCnVSgoo
	 I5IQtE9iwy55OLnBM9M6aKian2HAS5P/1LqZwLu5X0Ut/GR5oYhcrXrgEvPx79CBFTkF+
	 J7G0y2eqLhRdkAgdGDBS6hEORLZ8jWN6fO5GSEZMP0lcoWRkEoIyFA5Fxos+Bns7Nfwgi
	 Go1kzRWzsKkLof4vP9tTZoN5O4up9TPuKamdg9nWPZ7pkI7YnkTS+Y/P9s1lgUAnuiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278588;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=LsilWeIWvzlUsJ9wb0wZ5qqhbXkIjzuamB5Z0CFKPtg=;
	b=UjEeAgvf5FQXuLBnrKK0W0eUX7TCQG7zpBvK4bpIarHgSEiIN3dC0tFXkhBGvFsYV7RK
	 gb0KH7EZtKmqTXSfshXRgMGRVAWmW7IpPcg3rLigstLopz0pxfuHA3eyHu3WEQufLk3o0
	 bVEmJ2lyF3ZF1l4ymDxGsNwgwn1hT9zumwrawriup+A3aZ9LFVbvpjE0aTlt6j0rCM6YN
	 y7dS/WUWBsz7pfdZtwTxBsAopWkOEbxICkkXEumgHJQ9vg1w4iR3+CM4+5E5W1ST7eEeq
	 QHYWlA/nhr42bSAI5DEIlnBEFqA9fU7XHmLiehLhKk+QPwsRZMT/7e02rN/RntVmeaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C2BMfNN9;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE88606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEE88606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C2BMfNN9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LsilWeIWvzlUsJ9wb0wZ5qqhbXkIjzuamB5Z0CFKPtg=; b=C2BMfNN9I+9anCSsFGaxdK49GH
	X55nwKyoK7oxcIYdq49QxP3X/IFz5h2EdQwqfWv3d8jT3+svGK/51wvQx7BZIa4CFZGMvRiasj2fQ
	9KSh1nbYcN2DAsdLr4Oj/YiIxnb52sOM2VVAYG3zxtdlFOBa1YIZ4++MDnylMuygaj2Y7ROCZOC5P
	2f53jCDYT2R/z/fIJ3vMe7mFIgZuyYy026l1PKVDwl7hXvU90E3ToyHJTaB1Y8giQdMNZ1ZmlnHlY
	8pS+YCRgbLCvVCb49h6C0te7edbVyVMXcyFrhf2zDmYk/BmgQpQSaRRz0d6MC3/kwRsizviORzx/T
	HXodfb4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPgB-00000009G7L-1zSz;
	Thu, 29 Oct 2026 12:56:27 +0000
Date: Thu, 29 Oct 2026 05:56:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 20/98] mtip32xx: don't mark the disk dead in the irq
 handler
Message-ID: <auNCe0bpskQc2gqU@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-21-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-21-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Not objections against the quick fixes, but maybe we should use as a
pretext to remove the driver?  The hardware is also supported by ahci
(with reduced performance) and the driver is unmaintained and pretty
gross.

