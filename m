Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278669;
	b=JYBzlIWJxHdx3srl3H/2+s76ju/l6t3OaA3I8Qkpe3nWhO+XWcH13Ms+7Pk5BbTan4E3
	 Fz4lva2y8mYKtw+WELvXctgsZj12xAYipfRR2/+mhBcSkDwDO9ry91d/7xQ9uimNEKqsJ
	 kVsYAKRu8LFui6LA6mLdul2LtT4SR6DCrc9wCZA3P2eiIdvzAXJgEVuIrgXPFilVq978u
	 rnTsWroiX0aJaKydJLSeS6AotD186v0Iv07Llh0Vzdg9fTvwP5M/ps11uYaqj3VdX8FfV
	 qVxdn76LvU3oFyA1fHecdmaEaXV1rEHocrD0MUlJrSAhUrn2C2wDnmelIOt2tlzaNhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278669;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=UpK1Glv2OCpm3Q/dhFDM1cuCsoatsfTZE3OoAACac40nYCw3ILOndWBYV+mOw5F5SC6H
	 3z351p0vp0y3Ftxc/X4M/JMRYddi8PQyjp2rkawFEP3j8m3csXU3j1PPOkCjgDyH1WK8Z
	 mB4VbDcCrHKi7LXSJeoM0C7iRr6YODH5DbzsaCaa1ZhyVINQTM4bg1eDQpWOD0GRqMdPv
	 F3kg4EHoOMSXSSqqHJvC9L97Nt1hOZzio/3UPUXK5NRyFw1ezAXQDb3GXRazZP0Ybz51U
	 /MhJx6GwLa0rm1ngIfk4mvKLdL1PngWYXLUC+0IsIB93k0YCZe/YsM6Iw2MKeL4FXwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3Kq7rd0i;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A39606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A39606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3Kq7rd0i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3Kq7rd0i7dMOIZq6o9bpeQwoOx
	eTnivHmWwCZThgXjfJGicC1I08dQsWZdNdiqYz08SLpJIAoOzQ1WQlO6lWO2i8wgRDeIRu/jKNQTA
	FLwXernhwUApf/luOCfnYGKeP2txMSDbcxKPQDQhXn+8dEIZZtCm7XyXSbLf2a/xMk7K0RB6PKydL
	EdPlwDnAssGXQNSAN7njKPIJLlPF2icqUk+7WfGUD0X2cpUE7OVfcsxRx13HRST1dPi+pj67g6knt
	viy8X1C9PL5F53x6VL7X7da3jRlLsHyzT7wR26w+klc0OOiLQq0sniWVSgh/Ntl85X1Ipv22YuJ0u
	YZ7WzSOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPhU-00000009GEM-0CqN;
	Thu, 29 Oct 2026 12:57:48 +0000
Date: Thu, 29 Oct 2026 05:57:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 29/98] blk-mq: keep sharing tags fairly after a queue
 update
Message-ID: <auNCzHy2ho9bUojq@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-30-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-30-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
