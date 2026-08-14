Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC7370D54
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689141; cv=none; b=cPT+DhVos2FS72Y9UDYu7wN1YpZ27ITTeqoJzZqM29XKVE/B6e3Fz7flQR3FPX8aFFE0n4P0H+0C5ROo3G/+1yNVrHZFHydlDI6jVjs93DSz+XuOrq3xI1L2WLxcws+blmte/pjJp2nrAsqfCoQ/06riFpeO72fBTYdqqfcK9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689141; c=relaxed/simple;
	bh=DRSNK1wKDZAmaI2XeL2pqV+DdlP3Lp6BPUBlJED5kdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgjuL+52s1FXWj0nOR25zx6kCX4u+3IcpZiPCc2nx7zLPLb55b/rZFWraIdwDQMik94KcgqI7Q4ZBBZNuBzHcEmJ2ipNs/2VSprNvMZeGQteZIaprqubSzsAxZDNrGYdSJtK9BTDoju4ZITGQIayjPGVQeMGCwq/dyODqzg2kxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hn3IMF43; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hn3IMF43"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=u///HWNI4mgPk+4q+0zZufEZU8xZSR7toOSYtOaz2EU=; b=Hn3IMF43BGs/DpvGLOSA3ZNZDE
	xhGsSQBWlyCVxqFSE22sBMaXX1rhzzSAMUxGGldiy4rwlZbPNfh8029N7mNDSoRn1w046/S/nzIA4
	BQeajgU7ekJ3zeY22HgX3swo63cdtuunBcWADGKWA2WE5wWkbM/kWCYbBMwJiK4GnFrGFt7Y+ZBO3
	TUGYJa32DqTVVn8EaIzuDenbyQd+f3WAbB96dQPi9JWewBWwqygLf0JMIVPY66Sd7rY3PwY6mwjjj
	ueJfTRo0nzfOuSTZlgMq2eH74oVzeEfIoHGlAzg7GYwSIPDOeBURAB3i+WMG7PUaVQh726CxPo/sR
	66OiIS7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wulSh-000000022Tv-2arT;
	Fri, 14 Aug 2026 06:32:15 +0000
Date: Thu, 13 Aug 2026 23:32:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: =?utf-8?B?6ams5oyv5YWI?= <mzx199711@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Zhenxian Ma <mazhenxian@xiaohongshu.com>
Subject: Re: [PATCH] block: skip redundant flush for O_DSYNC direct writes
Message-ID: <an62b2b-swCOA1ql@infradead.org>
References: <20260812130335.60354-1-mzx199711@gmail.com>
 <anyicCnbACxAiTTD@infradead.org>
 <CAAth02BEXd7uy4LpXS7t42bH2kvkFDEcsLdHHAUizaV++zWzEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAth02BEXd7uy4LpXS7t42bH2kvkFDEcsLdHHAUizaV++zWzEQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 13, 2026 at 03:35:13PM +0800, 马振先 wrote:
> > But looking at this, the original logic here actually is very fishy.
> > If we have a driver that does not actually support FUA, emulating it
> > for every write command is a bad idea.  So this should be fixed to
> > only do FUA when actually useful, and then return from the non-fallback
> > implementations if that actually happened.
> 
> Let me make sure:
>      blkdev_write_iter() then only skips generic_write_sync() when
>      the direct-IO path actually issued REQ_FUA (i.e. iocb_is_dsync(iocb)
>      && bdev_fua(bdev) && the write completed without falling back to
>      buffered).  Is that the direction you had in mind?  If yes, I'll send patch

Yes.  If you want you can probably do this as an incremental patch
on top of the new version of this patch.

