Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE892BAEB
	for <linux-block@vger.kernel.org>; Mon, 22 Apr 2024 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767147; cv=none; b=GI96H7vwlUc6S8dLMZqFgGWgpYZ85e49IV+2eQRYZwoKz6Qujz2tgwVed8kvAlcs8qiYxkGCSkBz576zwg7lsSUmT+o5ZXYfaWqs//tjNDJK4S3D3q/3LCauc7SmyMPo4oAUTkXRMZ5zx1/IyDd+TyCxfoVJrhbI+BQbClYOZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767147; c=relaxed/simple;
	bh=46NveoZmPlG/neMODdgViBL6AIH2O74Mav/7o74Pa9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG6al4I9G2XOthVQMwD1rtMlm8+vEN7w2LZFdPFFSAPvciQsF8JpsJlAMkeE4l4utDgoxSZ/et/fbdXZ9YzqDfqKaj3uK9syBS9ZALlUqy8CAcfkyOa0cTDWkAyUy+xUnxrg06RPYF5D0k6dAuovZlev/z0YJsS5Sqj7pRhZG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P0TBATMD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P0TBATMD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CHguVWfUMKB3Qjrk9RmkmtKBco//X27nvRhqD65HIek=; b=P0TBATMDL+NZatf0/i8gBw7ko4
	DLVw0KtcLKNeynxNYQjORN6G5Y5IJFl6koVp1tu+TCv4VS9tB1Ba+SQlL3Rf8gpqwSr+YC6C0y243
	CEzvCYqLOaC4SyUhuTpkDKsVkwBnpgci3+8vQz5lfG+QZClh82VJ6wJwRmictDwkZyRSKEVxsNy27
	2s0sTYmFqvuuT/Inpk+dtHG1m5M7de7vSqzecdkYLRZdnRBrhfHGtvkhbz2r2s29LPoh1pJo6+iwY
	7MA+4H3VONblHVcFRMOgkujel6bF+pDQKdbYh3SuHGMsTbbO1mNBjFySv+9/zkKoajPEztc9GlcMY
	Pj0Ml4Jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryn7Z-0000000CFPC-275x;
	Mon, 22 Apr 2024 06:25:45 +0000
Date: Sun, 21 Apr 2024 23:25:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] block: use a per disk workqueue for zone write
 plugging
Message-ID: <ZiYC6c100oNWFa0y@infradead.org>
References: <20240420075811.1276893-1-dlemoal@kernel.org>
 <20240420075811.1276893-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420075811.1276893-3-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Apr 20, 2024 at 04:58:11PM +0900, Damien Le Moal wrote:
> A zone write plug BIO work function blk_zone_wplug_bio_work() calls
> submit_bio_noacct_nocheck() to execute the next unplugged BIO. This
> function may block. So executing zone plugs BIO works using the block
> layer global kblockd workqueue can potentially lead to preformance or
> latency issues as the number of concurrent work for a workqueue is
> limited to WQ_DFL_ACTIVE (256).
> 1) For a system with a large number of zoned disks, issuing write
>    requests to otherwise unused zones may be delayed wiating for a work
>    thread to become available.
> 2) Requeue operations which use kblockd but are independent of zone
>    write plugging may alsoi end up being delayed.
> 
> To avoid these potential performance issues, create a workqueue per
> zoned device to execute zone plugs BIO work. The workqueue max active
> parameter is set to the maximum number of zone write plugs allocated
> with the zone write plug mempool. This limit is equal to the maximum
> number of open zones of the disk and defaults to 128 for disks that do
> not have a limit on the number of open zones.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Should the zone write plug submission do non-blocking submissions as well
to avoid stalling in the workqueue thread all the time?
