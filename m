Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AF405EB
	for <linux-block@vger.kernel.org>; Mon, 22 Apr 2024 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767042; cv=none; b=ugEjIWThuWLHaHWAeoi4YOltWfyGTgx4A5iywMfr4u6ZcUXhT5CYTcap4dUoDZy4U8pKDQF8crxBlUfAUk35EJSdklz069cI1g/SJYBtseara0lFlevL85W4YIF+D4rI1tJxqmw+3A/UZh7ZrmOc+SNwtCozJPW1ZhnF8hoLobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767042; c=relaxed/simple;
	bh=Ir5RTHx6IyJp/2bFH7meoGR2S3GRH5p0ilatHLIVF+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA15+OfgyO5GnFo214//8q3F4rjNKpfYjCWVNbmlcVQrnlkJZJCi4cmWKHMi7O5BHclw3AXVWgenPkzn4uN9rovavlSYZgCR16f0Dqk4n8Q+7TeOmuRnd+9o/xwbHf/P0Pp8FZp1Knhho0M6j9OmtKH3/I7ArI9DncFyugtiFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y6FroLVO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y6FroLVO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ir5RTHx6IyJp/2bFH7meoGR2S3GRH5p0ilatHLIVF+A=; b=y6FroLVO+bHLr+QQWjs58Zif08
	Kg2HLTffXxLqpb/ut7sMvX08z0FssjrZvdksBK/AvSugl2lofarn3txB+PzWOKtHAwEUtjfi5d/le
	PTDOOmSISo27bTh3cJd88JH7AMuAzeEDAXCdQ0LwEhGxeyVPGnedL8srEngv6GO4buzyGMnE4c03b
	k2C3QbLv/1/lfRJDxuAtA5zpQIGfh2dsz/JeL2C1CDE+cY7eGdW/9iySMt5Zzj/3ql7bWEFSwiU1Z
	uSmTf7xbWWOvcNFDrB2d4hY2MowXNRj0vuKA+HOedL3GGUPjFNM+6BGrdejGSkrlLS84K6JLF6Mpl
	kCEYw3eA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryn5p-0000000CErD-1rAR;
	Mon, 22 Apr 2024 06:23:57 +0000
Date: Sun, 21 Apr 2024 23:23:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/2] block: prevent freeing a zone write plug too early
Message-ID: <ZiYCfTVpPqIMv8iE@infradead.org>
References: <20240420075811.1276893-1-dlemoal@kernel.org>
 <20240420075811.1276893-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420075811.1276893-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Apr 20, 2024 at 04:58:10PM +0900, Damien Le Moal wrote:
> Avoid this by calling flush_work() from disk_free_zone_wplug_rcu().

Calling flush_work from a rcu callback is just asking for nasty
deadlocks.

What prevents you from just holding an extra zwplug reference while
blk_zone_wplug_bio_work is running?
