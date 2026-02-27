Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983926B777
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200207; cv=none; b=sc6UNX5Lk169rITLzvts07GoXFFWnATtf0C4muiu1NlCv8kGk3MWlgwfWIsz3k3BQyqus1iQuVq4IRq25y/Z8Kzoo23aVswVeAHHHgmABXt9Kakvw3caZJdEDdnz2FvoJXVAXppDp/yWf0RLarF+vgs7fJqMOCEIiJ3GejEDGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200207; c=relaxed/simple;
	bh=sScidmNzDEXtPQ+5cIXJ6dRwS4wQCMx/7w9tOWSBO5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoLA4m0BQW+qdLiNCkXjqQMg+PQEQh/eDfPwxbglmiVx85wWAp/iF95nRwqfJbUlj5xikE6y68ZAkjRnXVvalO6b3KDPltRWkWAz3Hi3jYZV0k2P9q/ZSSwoEMx/puoXFaXeVK7aKKsGIztfso6nLYtt/6CTD6Jt2UvoXn3+i7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zQdCkxMQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zQdCkxMQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sScidmNzDEXtPQ+5cIXJ6dRwS4wQCMx/7w9tOWSBO5c=; b=zQdCkxMQbKaIfawW4QFB/5pmJU
	TH/0XTGVzx+0ifm+BovUQn17g0YilSPYQG1lWVDEAGKXcYF/vNbL2w2HGbGtrPFLymy6o2wroM+kx
	y94tt9ciZ/VmMo9uqC6tlUaADRdJzJM5M3R/XgjOJnyNXmzE00seTyE6PUssomcAi0DYQp5ldTO4q
	AIlMfVRxLg1C0RF3la0uQ3voCBLexGIRIgmw51Bc+LlHh1gjaGgWbyg4JDNXKYJwIkW4EcB9X+7PS
	AnQHB5sTl4SqBFGk1n+t/9Pkd3Lvp0wNdcZtuSPV2YXGwb+ku7KTFhKksAiqx0BI5hR4ZzlVM1dA1
	/f0tVhDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvyEH-00000008P65-1JOw;
	Fri, 27 Feb 2026 13:50:05 +0000
Date: Fri, 27 Feb 2026 05:50:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 1/8] block: fix zone write plug removal
Message-ID: <aaGhDUUM-imJehVP@infradead.org>
References: <20260227131951.2464150-1-dlemoal@kernel.org>
 <20260227131951.2464150-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227131951.2464150-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

You're reposting way too fast for me to keep up, but as this is
unchanged from the last round, also here:

Reviewed-by: Christoph Hellwig <hch@lst.de>

