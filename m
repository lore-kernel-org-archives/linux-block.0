Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A33F3806A6
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944312; cv=none; b=Lh37pcZSPQlS0cR1HVlFRKiWJZdS+5yj9pAfCPUHl8WbwPxMUNv1mZeSkos5EpJn1thi4irhG8gGjgLY9AHDJhWDH43PBukiRyc7VJjTVh9r5RYfWumVpnpjYuVxaqypgHMObXWir49/i/a/5BWGPzTc1MmW1VhziMxTsY28SMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944312; c=relaxed/simple;
	bh=7pPXLeFa33Wz5yS4mu/MoMLo6ShzVntXA0UFhAXHAiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZDoIxsp7YKWrYqur4vydqSZbEd3Mt0SKRz2aNXTE9akykhtgNgy92U7fuk9nugFKpDDc4a2vqZvySnlTIeJfg9Hr6YiznWtuG797k2A194WK15Q2jbMcPewu5urSF4D5qZ8X1jBr04yVTURefEP0XAkEbAPFXm3VMLEsQoVxTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wuSe2xUa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wuSe2xUa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hc6BXqUlZv/077Dk8bf/Xz2t4gMACAKlvJMJEbHEjLE=; b=wuSe2xUabgGCdr7mu1g1UHe5ro
	Jds/a33mY36xt09XnyJDimmAGpERQnl4bcsg/rAmWpepHYIEKZFi+n8+KtMyjxqhh5NMNNF0PzeyJ
	T/L3mPTWrmKarupLKipHcwYVcradakpgShR5EoSGrrgw+oLQXuMMVgsQ7zG4fNlDlt/mj3KXenHEY
	BnxzGKgVgBowQDFffDxnLUq6WePck4mTG+NMbHtEHNL7C8nWtbT9bfSDptKVUC7yJoKpmTTA5bhrb
	9VJSqcXU52p44txukUcntrqq8kmk09e2NKG721dxhoQ70TX6RGtZ3x/yUdKda/TP95xr3O1vhh2Pd
	6Stw+suQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuteu-00000002G2B-2Fj7;
	Tue, 24 Feb 2026 14:45:08 +0000
Date: Tue, 24 Feb 2026 06:45:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 02/62] blk-ioc: Prepare for enabling thread-safety
 analysis
Message-ID: <aZ25dOkJERXR2rCl@infradead.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
 <20260223214950.2153735-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223214950.2153735-3-bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 23, 2026 at 01:48:50PM -0800, Bart Van Assche wrote:
> The Clang thread-safety analyzer does not support testing return values
> with "< 0". Hence change the "< 0" test into "!= 0". This is fine since
> the radix_tree_maybe_preload() return value is <= 0.

This is a series with 62 patches, of which only some and not the cover
letter made it to linux-block.  You're doing something seriously
wrong in your patch submission.

