Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED95D529
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482643; cv=none; b=ZNGcj9W2Bgh6888onLugiyxSyyFCfvKt1KbVio6X7x/jy0nnISfW6vmzc0O/rSJ9cX0iJlvD2c4/EcfcevBkV3Hw/fXUhxBKfZSCLmj1nI0zeZCdqVE3LYLY6ZPVH2EbxVMHjnnZQzFU0FQPpC445SDMD8pRbfWZYVrhwd/ci3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482643; c=relaxed/simple;
	bh=SGJYuvVvlizQN84B3YZcC/vQSagm3AeNbAySn/aItZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4EOTQuHg95cGoxVisFQhT4s7dII7EB/b+h3R0cl0sqf8eqgJrqZ944/NySpWvJqH/TJMmJeIIVV6Ub/mbjz4GNN3SE5kcKT4lz6IB/ZQIViST83KLK/xIW4JPRh8jIwV+Jdik67n8GBtDdSRHU2jajai9cHZZq0ariiC5eI70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=blmJwe51; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="blmJwe51"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GG3FJeEHDewsF2Sq8Tnhaa9BBxNFOorqsXD3T6FK9OY=; b=blmJwe51xAQWHX7M0pFaF8e9s7
	zo9WNu5Tp9MstLHq0WcsafZbiaXqYG0cBUNKqGa/4ZaszZHWcfPu3IZTjoHZUfyXpoAaYCXESqXgR
	+DhsCy07ql/y417z5PNCpKnNe0OZV1S/H4H2ESR+IaMHw+VgoGj/sctIZMhHffaABwc7zJXhbrWGp
	FihbcM+Whr4xzL/ztryuj7LAAGLExE6yBmJqjpowaRYm2vGxzyB5Ra9gwCoHw+U55w+8UIqKDtrnv
	+jd4/AwrIxVxy4wjSSRUQSzVNZQlca9sKHBNdxFolCTr0muae3HIOYQlBvAuY11kuL1jr78OK/xMA
	KnBTUDEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7rll-0000000DIvv-2iAF;
	Thu, 24 Apr 2025 08:17:17 +0000
Date: Thu, 24 Apr 2025 01:17:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	martin.petersen@oracle.com
Subject: Re: Block device's sysfs setting getting lost after suspend-resume
 cycle
Message-ID: <aAnzjeG9JvMS_atz@infradead.org>
References: <32c5ca62-eeef-5fb5-51f5-80dac4effc98@applied-asynchrony.com>
 <aAiKM0-1JJulHLW7@infradead.org>
 <cceea022-a5e3-97b3-62ed-7ead174565a3@applied-asynchrony.com>
 <aAkTDtmOQhBP4NBa@infradead.org>
 <cacb5382-3352-9835-9774-e7c17b5e93fc@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cacb5382-3352-9835-9774-e7c17b5e93fc@applied-asynchrony.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 23, 2025 at 07:05:26PM +0200, Holger Hoffstätte wrote:
> There may have been a misunderstanding. I first noticed this on an old
> machine with SATA SSDs where I *do* have an udev rule for readahead.
> I only used my laptop with NVME drive (from ~2021) to reproduce the problem
> and send the email. On that machine I do not have any udev rule to set
> readahead since it's plenty fast.

Ah.

> Not sure if that matters, as it was a valid bug after all and now
> it's fixed, so thanks again!

I usually try to understand what happened to properly document it and
create test cases if needed.

With your above information I dug a bit deeper and found the likely
culprit.  Before scsi was converted to the atomic queue limits API, it
did not use the proper blk_queue_io_opt API, so it never updated the
ra_size based on the optimal I/O.  Which means the user value did
stick around for SCSI but not the other drivers before.

