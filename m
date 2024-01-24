Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21117BD5
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088751; cv=none; b=hncQT00tIhHL73Go4781fWjTRtmBqp20bGXM1tkzCgH4UdepJVDlSWOzBMtF48VDwSYQq7FnZl3ut1zceAnbo1e9ZfTyKNxNTBnar9AyHYvJtHKacyY6sLnRIV5KuOumb1PxYSGetzW//sJgmJNMzHapm/eq5ObpYOAwnDyYZn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088751; c=relaxed/simple;
	bh=h/aVBgqDYfD++lXGhbAHqMkwUauFOGOdnfWCyQG5Onk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgzANBCsA1Srjji5Yi5oKxD/QdpfWy7e0UjxV4ps9+TnoylfFzPKlT194SZLXGtGciZeWLaLdeNtXDqO3/HxFZJ7OXglHq4SwVEsY7K8rpc7a7JLeX1n201PBw84DATJLgJBW0ykxlyPkdRow4BT7H+Aj3TuUZaqOw1tvqrmF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=5D3X/vnH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="5D3X/vnH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G32e2zluIm5Xbr48OGPYliQPPUwqVD1ZYggar/Epkmo=; b=5D3X/vnHNaJ8o2mdWwvkfe26Yd
	Hv4JRUFTzrAIU9qI74pTMqxgu3eWLLXHEp/C+0YAz0CHY6qyi6TQ7adqLMixVZhPbyIKgKlCVh9x5
	RaIlpJR3V79ROyCjIsZ4RNtnSMZtdEF+tSNZvw9kX5WHkgg/jMKiFKK+9LW3zciFbGuMlezOE+3qW
	3AaE/P67Xogs8NxykNs7IDVyE6zOUAea5MylRNEsRnk79GP2F1y4DD6du4Osa9YK78rAEOqUkPSpC
	rsaGmZwDqgAic8G2xfb98442MwWC90rzs0Bfr4ab8jR18Y6s8vuOOrK6RWXKWH9K/pnkzqYRIM5Qg
	z/2MFdbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZcT-002G1V-1X;
	Wed, 24 Jan 2024 09:32:29 +0000
Date: Wed, 24 Jan 2024 01:32:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] block/mq-deadline: skip expensive merge lookups if
 contended
Message-ID: <ZbDZLUDwA8ObY+9O@infradead.org>
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-4-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123174021.1967461-4-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 23, 2024 at 10:34:15AM -0700, Jens Axboe wrote:
> We do several stages of merging in the block layer - the most likely one
> to work is also the cheap one, merging direct in the per-task plug when
> IO is submitted. Getting merges outside of that is a lot less likely,
> but IO schedulers may still maintain internal data structures to
> facilitate merge lookups outside of the plug.
> 
> Make mq-deadline skip expensive merge lookups if the queue lock is
> already contended. The likelihood of getting a merge here is not very
> high, hence it should not be a problem skipping the attempt in the also
> unlikely event that the queue is already contended.

I'm curious if you tried benchmarking just removing these extra
merges entirely?

