Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277334;
	b=a2iRylXwZmHhZHep0v/HbthKSz5voq61C5bQuqRfqFSVY70EzVhc0fLHwYnoUKN0zGlh
	 egZ0onCkaSYG8tMHApJNhXoh/c3GNicZHqLBpsCHp03lxzW8m0Zojbc9YxvtJhMBRCmLQ
	 L2wN0Z/LET98t4htmmrtWLsNaVP4XhEfKsaX/QAsMzWToyYnvxJrAW4sUvzyCWWtVWNI/
	 69qKUY0xQQM/31wF3P0eNm5l4y3ZWKV4cSXv1hxsm+mi+zc13s+CyjbkJDQ9bbbiumN0R
	 uYBXbKG7tBJWWksLBeBCpHPYFvf+t/za59urZTD0hPhg1Xq/j4pnlfVjKURznAPUVFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277334;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=QcY0VDzWBprqp5S1HJIlJs0nDYffvlaxzxcNCEOtbSo=;
	b=dYZk3uN/k8xtyZuFrcycn2EuQ1Watz5q6sUXcyOZPbUUd/r8Lm3DttI2Ji/Sp6qtkEM2
	 9oyKdGFidxSXBETHwQwpCHcUSj+U0ZzMz662fLSRsd7R94IS4ulyMhDHHpfjVWR/6vYtR
	 s0nipdPiqKmAO4/WHB9jWUdzJ6E6zr/+e+1MR+ynAF1lZiQQkEkdtJVO4n399KWuY7+8k
	 ClbwZNTF/t7l0UnOPIhweai+i//GAB9IqxMOaiPAr8YwvCWQTci1n92yjOmpFue3uYni9
	 x3aOhoLiifAHjReydfT3AmL2LjPyz3wstDkpLTFUubTy9P1b6xOm6qzElYHXtHtGAlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=X1PUevgJ;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEB2606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DEB2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=X1PUevgJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QcY0VDzWBprqp5S1HJIlJs0nDYffvlaxzxcNCEOtbSo=; b=X1PUevgJKn1jnB0l4KoMF1DbQ/
	pdTaswgrijAbuEIw0AKXlgdmsJ37c8T8Z116erPodgFsuFiGARWjdE/n3oksRtspHVNee0SxuCvMd
	qZluKcpRwiZ0nU2BXUS1Y7f9s9xoEQ9Uo17wyff7oya6gT0zW4g8fWKJqGssWD4I1wSr5TgKwz6aY
	PVfv/G2CBhR667kcOEHA1JxPS3FO3P74B6R7ru4BEzRqVWtR0TgQG1IhSXwGLT7SvoZBxcO3mbKcX
	j2wmnNXa1D205QWG03M7WKkfwbPSlJZWg7PdJj/n0cWjc8nRri7vVYESXSPcqtCt4cLgE6BClT2Gv
	ZTnHujFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPLx-00000009ANz-2v92;
	Thu, 29 Oct 2026 12:35:33 +0000
Date: Thu, 29 Oct 2026 05:35:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 06/98] blk-mq: don't batch allocate tags from an inactive
 hctx
Message-ID: <auM9leKDJupro64j@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-7-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-7-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:09AM -0600, Jens Axboe wrote:

> +	 * does. The caller falls back to it and will retry on an active hctx.

it I guess is blk_mq_get_tag?  Maybe spell that out.

Or just use the comment from blk_mq_tag which would apply here as well:

	/*
         * Give up this allocation if the hctx is inactive.  The caller will
         * retry on an active hctx.
         */
Otherwise this looks fine.
