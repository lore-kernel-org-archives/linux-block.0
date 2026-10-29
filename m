Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277148;
	b=V2MBvjE0BWbCPjQvnUT2K3H9OJMgp6Q9Tl96FwGD5pa/q4m0fMfQUiyZXhCDSmEwlXlx
	 1o22yNhnRZshvMUSfgkCfog0x726og4HDjlMq3eoZIyQJWKrvjF0fVUz4JaM/Slp/OI45
	 6GCQkSJp/1qXRcRCAyb1Bu9nT1U9DfNiuaOyVN2n81J0dnkp1jZoGMCzQJ656tmT9sOxo
	 ElEpIhmyF9jYxZ2G0RBu25XEgnfyIaWZyvJkrYH72XbkvDiu7mb5vYDV1HonfAD/iulV+
	 S9dGVoNxlRLfDF15M3ep2k2Tl+UX55PQWDiXyBx7LzHjb8qZtJPpWvr80NQwucLjiFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277148;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=OUzz9lpEtB7D300h9CjfQ/mLszNoKz35rsWOZdqtYG1J7Vg55t6XHqOqyDXfvvFD44Sy
	 /faJneAZrUbiPsD7AY2dEn3ntKq3YlI9RzW2oeuZr0U50Nv5uOYi4saFpMGe6Wy14BR9+
	 UCNVfwvfD5Nr+mrHSP5VSaomBj6mP665DqgCgYLxZxNk7sjlsI7YxtFB8tYSqk2QER71r
	 oL0U3TlijpJpLezBtZ7QEDX4CiZ2UAdhtHEhEO0WzdUzEWSYD7b2O2BVU19heEpmHM0ZK
	 bLJdk2iITw89g7sP07JhJB9N7Kc0kcEl5W6oTk+xBD5pBDQ+NGwkzmUtldayNruSP5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oTTsY+9h;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25C3606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A25C3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oTTsY+9h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=oTTsY+9hcUMp1sghL8DsMfHIO9
	BNwQvkrcVAzE7xslTrEBoblmrRlRbVKfMbaH3MOsMVwbnDrQFvzxnAV8INUogVTlHS3PUBNwrMWrC
	iTWtJJh8mICluFqbXgFM4uSy7WEiTNMgP42ZLk3VJ2INRpLC1Cpwa+/44QOgeVYsO2CEvOoEuEtb2
	RB54n/bWQsyiOHjClsIbEFLbX3EYHZbK3S5LMhs2XryRYzYvl9OyTAR9fiMmJMGeLpM3uxf6Rkcjl
	10+2Duqd85MkuXON1PTLrv9AwFLkt+mf5fn2n0JphCEzTUk/jNKOgduJ01t6jNZvLMNRmgDSY+NkO
	Z7lHfpuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPIw-00000009AGQ-2G6m;
	Thu, 29 Oct 2026 12:32:26 +0000
Date: Thu, 29 Oct 2026 05:32:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 05/98] block: don't lose the status of a failed flush
 request
Message-ID: <auM82nFI1UesZSW9@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-6-axboe@kernel.dk>
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
In-Reply-To: <20261028164415.1262013-6-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

