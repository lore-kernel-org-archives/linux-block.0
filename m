Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279309;
	b=IFh8Fg5mDjgcxF6IaXHPQICxtZCEBcynG//faWGcaNIFDJQxeT0ppVGI9wG9OyBDm16q
	 puJwYE09aPXnB3QS1P4juIHSG8SG8A4A48E+6czvDIuAgEYxcdySuAeKkuyur36Nv55Bz
	 4TTdrZb4pq+x+rOC3IG7d/z9Pf6Aaprqk+CNHYzYhmLnAjUO91gB9RN/Tnj6xZjZ3CGSt
	 VA1RLWr4TMKNFM6gVl5Of/HfWuUf/e23uiV/JaYOPneNXNWAuCBWcvTaFjO+MyGip80p1
	 nlo83j3+fW9jMAHKZqVELCjDbr6kR4hZRjciHIsywvDKLBSde0i898SkvjNzTENwVVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279309;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=XHyRSw/o5F/GlnvSeHCxHbrXbFC5i3sO1tVeLLLCVEIkSX7eh8HUXOX+l8kRv/xw4Ipi
	 IujJsi55P99/zC+ULJj4YP5s9mojbn/oU48u6zOiLRlit35AUkomZ5bjrMe7NqFN/qo+X
	 aeyK5ZS+gFNevx2c6jc8nnOcD2IDIV/p7cSc4hV/+GQfyPutdAgTpEjn37ULnbLYighUV
	 39vQNFgASga6iFMmS4oY/90PoDmmZexI5cenAYo8SQwmhBzmHTg7HsYUKFw8kjxDOaUH5
	 QB3yViWBXN1LWhP58AnFPL5WP1Lrn7wNuZUbiz5MP2/o1eg9UYKrCmjCaVE1r0alr0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aY4fOhL5;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A0606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 632A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aY4fOhL5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aY4fOhL5si/2wf6ik/6BahBlBy
	YrAQrdjWd6eVts6hcewqv1oF2VAHolumavvRBigKkMaU5cA4WFuJjVbzGPgD4L9P4WR3XBQBb27BH
	9G62Pulx0efziVt1t1YPYVwRFniWfAdAPbGuKx7+VDILbo69fHJHWAMt4VDiAJ+0k4t/24mFthUxC
	mQIP4XVRhVy+l+82KNqCWfgxebLkz947/i0ekTYYjkUkuCBKYXZ2krYAwfybcbf25/9Bh8hOlgHnP
	ZOF3OVWhhFZk9SWc9ZskvvgWgpI3pFLiZtdE3T2O6laEnDxY+pt0Andna449ciPFLXUpo9Kh6CkkG
	ANxGrjqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPro-00000009HMI-3UnJ;
	Thu, 29 Oct 2026 13:08:28 +0000
Date: Thu, 29 Oct 2026 06:08:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 36/98] blk-mq: quiesce a queue that joins a quiesced tag
 set
Message-ID: <auNFTG8fp5t74v8d@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-37-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-37-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
