Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FBA1DED4A
	for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032006; cv=none; b=HGGNWRR/H2nZ4d9yRi1pnmdVBdP2y+gFx6bGhAiptpUieCkZDQxfM4rXm+2afiItTpzlT2FTB9N0jJlBVUhvJ/xY33Ebr86fmzUZpYbBtNpmScSmaRSj1oKLzSBMfybqZCGXdzsM6Si5sv9p+RuU5c5RTx1eNH4Sk320ejsDkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032006; c=relaxed/simple;
	bh=+nlxG/vCAQeDaHR9RYzS87lp67lL9Lz2cEWUGIPwtik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epCxa/Aubc2O4FOjcytEb8jn0T/pAHgr9X96rIrBXFxo3twegEQBGu0TatGu4pirwFy1rNzLwU6AxmtAj6MRgLgrnnf8P84cWFiRNceNHwoB1tXvd+/kShYV5HOpYS/fCmgWAgCYl1U6E3tDviWy3Mmqoh8RRGgqwZoemzgxai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ToY16hiF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ToY16hiF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZdIgRt4cpJaNanScsdHnNUEaBVAb9/pIhL+HrcTSeuI=; b=ToY16hiFOriqOOc9EoVcdotOkm
	PPxw+r31wB+1Sz7wl1PEaLGpNkwEIvHNJ/6V7svrYh+0oNprJoWlNbdYom6agl92UoYiL2yHPiw3x
	14rhkc+njSG4T/3J+ZmMuONT/rYWQcWKT5vbus+bvTq7QLT9KQBXh/mDgZ+HNUh5MJXanZF2n4H/5
	k2em6axOgEgwjgH0kX4kZZuodiq/WsxoUEz3Za5x4/QODTjixd4o6Ecmi9VdgQWCSPTesd8yFlKko
	JNLZGpXJf4mcknsoHTPa6EhUofNg0b6n8MpC9fZqvnmxffLHLGw1B7TZ2xdsCy1tZgdEmLI55X75l
	TYXlUBng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkzoK-0000000Gtwl-4B1g;
	Thu, 20 Feb 2025 06:13:25 +0000
Date: Wed, 19 Feb 2025 22:13:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Daniel Gomez <da.gomez@kernel.org>,
	Paul Bunyan <pbunyan@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4] block: make segment size limit workable for > 4K
 PAGE_SIZE
Message-ID: <Z7bIBNc1SuTyy6ac@infradead.org>
References: <20250219024409.901186-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219024409.901186-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 19, 2025 at 10:44:09AM +0800, Ming Lei wrote:
> PAGE_SIZE is applied in validating block device queue limits, this way is
> very fragile and is wrong:

It's neither very fragily nor wrong.  If you want to change it to suit
your needs that might or might not be ok but this language isn't.

> - queue limits are read from hardware, which is often one readonly hardware
> property

queues limits aren't read from hardware per definition.  Very often they
are software limits.

