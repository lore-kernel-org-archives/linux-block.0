Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278526;
	b=Srdrk7fwkrFwmq8qtetBYO6VWs6KHvvL8t0TSNEwXKBBiwWiRhJdoFT884aEpZB6lCI1
	 2dhSfKTj/8Cp2VA3iS5zyYj9OiWT+t56ScVUS4A6BRnhOgJ5PFd4rTa6DilkXgHh9RuAY
	 v6I2hkAsm3ESwsDw2t9Hxr1A+NaaWGaXx54xia74OkngvsusN0+YOaHnFJmfp48WlTRci
	 ehOq/O2FeW+AfFvYSBNmABZ80mxAh0gfQt6qWcWsgSOjcmaX6d+z+n1+QZfM/BPc72bvE
	 lKE1vMH1v0cbnV2eu/HBKb5TrsRvHDsqOimE3CVLiCLej6xU7ZTBoIW6CmZhmW+85bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278526;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=4q8QlLrnaEJ6xCHUBf76Vj7nDAPm3MV7HzOgOBzC2nk=;
	b=EtuuDZtGYBmOUDf8KJscpFIlxdSfKR+Kn3C2wMhpWaEKmC2jAyHo7JHo+7XG3ljv/gdH
	 HNbY3FHPBoUesv4kFK3tVJflL3xR4Zn/PSCS4+uZcEGInTPd22QbBVaCuMs8GDTf4zKsw
	 OGOYtiSKO5HeH05lmAEjZkqYrQ3LoOw5u0FFwL9I/fllUE80UIjr0IrGdknwC+A8WMZ/L
	 obcICqeLJgRJPA0zlTr0b+xbN57Mdk4fi3utT08NqCgtd/a5fUrbtZi68pKaf6dGwgiET
	 1dLfjesAvuyKo9Xa+rVtUOaA1ibuDVczItXo0+LFPvUzlzY6u8D88mBUK3isrQeRSsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rbkbEPqb;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F0606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F5F0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rbkbEPqb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4q8QlLrnaEJ6xCHUBf76Vj7nDAPm3MV7HzOgOBzC2nk=; b=rbkbEPqbtjc+yyUCbOqv3p6+HS
	2ELrLpliGW0WaWF3IpE1GAscxv4yoq6EtLgydkQ9yLVa5gyraPrlQ3FeND3uEEYvM8IzlBxdXLw2G
	sCqV/iYjwtuvklJ+y+2CNUdfNbFPuO0PEyCSNwhAYg2efhVbhkrl+N8WywufuvP8HAB6W40Fu1ihK
	N7rIVSP/qZARyX1gkUPtCyscy6iAMQKglKrlOneMr2vfsaVNI2ynjXg60tZErBcSEfIG4l+gTZUFC
	wL9Mbs9yr7tyZfAfS75BpZiraTXL0mIkwPDG66AZS5LuezOZkf5MH6QTO3wVj65dWQKesNtZTGY6z
	Bsh8gW/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPfB-00000009G12-3EXd;
	Thu, 29 Oct 2026 12:55:25 +0000
Date: Thu, 29 Oct 2026 05:55:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 15/98] zloop: refuse zone files without read/write_iter
Message-ID: <auNCPdXOjqneFNsd@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-16-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-16-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:18AM -0600, Jens Axboe wrote:
> +		return file;
> +
> +	/* Zone files are accessed with ->read_iter() and ->write_iter(). */
> +	if ((oflags & O_ACCMODE) == O_RDWR &&

I don't think this checks makes any sense.

The proper fix here is to copy and paste loop_check_backing_file from
loop.  I an prepare a patch for that.

