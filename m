Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700320;
	b=1+6B+Gz+PZsUEhNVa2HHxKCqxrpoxfXYdRXsNZMQYi3OtsxI5HW8TTBiqgx7hQQJG9u3
	 9vvs5fkn+AL/Qn1cWTf3noTZ1fsLfL6FcOS1UEOl4NkODbmolZNWO4in8qVLHmJDHmBEv
	 KwRepqZzMyJ2vbA/f/G7Gh5sKY0BIDBju+UZm5sWDZ2/xJ98dJ8IkQRTRc3so+dJcDS48
	 f/4hZH8zHL6XW9v/hITVasTW+nDqOqbpoTKa6PHBbXXYyfWgvgEArIc0/rJIiy4xRjTsM
	 tSt6znVhNZ7aDxgQDXsvVz78SjbJtOigRslJ53xxH0HJFXU7arbjhFFGPWlU7z4cvkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700320;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=C1RNYlnrJtF1LBtKdeDhyZ4r5a1UywmVvEvB9lS2rRBRq9zsb+TrelRzoNwFkkOy2Pr7
	 V2pZUEudL4it2044pupK47J/lebSIQqrEFKGS24Qox8Ey9JPaTIZ5162E3W0IrA8XkolA
	 boyFTNN23nhhX0ZYxsdn0Ww1zNV1p07eY2rjMrzjk91nqpkaK66M3J99lcShB3upjB+aE
	 6tKS4z397CC22u2n4NX7ZGl7DUsLGXdxwbI5w+AWBTA4TSHQ5pAs35/8Trjv4iWGojlOg
	 0kK+pxOszzdSq4cCPmKuOcCIEvIMmkINImpC1GDhkSbYrRA+Gr31+4Q9hMZsQVK59kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jsVe4pos;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377CE606A336;
	Tue,  3 Nov 2026 10:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 377CE606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jsVe4pos
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jsVe4posrYk+k3RoJKio8zNBWI
	H/qfQAmtfidpRSU7SHXAhQ08sqvkpsb45OvnX/3HIgkM7gY7Mtqe34siKFwTaXboeCcHFZMSeoca/
	FGkQ6WMJ9yi1YRtIgjp+aktpfEeIOLHxMitIgTycEpjLOcf1fATXzheNoQdcGJbG0k2KZjOmc2y0T
	OubAiXcKx5GawJz+nm2mzmThIgCS6x5JwAh5omuUqv212ij29+F+1RvK8Xxh7bHR4eTwvycxo0qPn
	sg0uP1QbR+ZnDsTb/T9RtK3tfN4SdCFbVJx3OMogFwlyb9/tGZZYYyfdOQPRGs5WkHIY6H4UYUk0D
	ZyMH61NQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBOJ-00000001sIG-2JMc;
	Tue, 03 Nov 2026 10:05:19 +0000
Date: Tue, 3 Nov 2026 02:05:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jianan Huang <jnhuang95@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: reset queue state on scheduler teardown
Message-ID: <aumx33DDpKcWpeiL@infradead.org>
References: <20261023092611.116795-1-jnhuang95@gmail.com>
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
In-Reply-To: <20261023092611.116795-1-jnhuang95@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

