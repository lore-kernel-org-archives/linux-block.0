Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AEF17741;
	Tue,  4 Jun 2024 04:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717476386; cv=none; b=uUVp4FQLNIyzwHjKjX6BRbU6CPND6yShEVPwWBU+9BC78vsZ4wPI8LVRG9izNdITF6Zoh42g9QpUni0WB2yMtDme2voiY++aV5lml1Eqj3g97hHr00fFSNlBrFfEzt9nNX30zpI9c3k2gmAFFd3gCB/InD1W6m8IIuzLPeIdHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717476386; c=relaxed/simple;
	bh=lF+3ndP0Ib1DsiimtVj/EelNOErTHudK0jOBHFzWKcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqwhkNbmyGiCcGsvVQQde+S0ShYxEKcgFo0DPQeazCsRnO+FZ8MDfwcSU0cJFgT6zJoIWbfKcOQrr6JO3MjcEPONYsIMFObUYklpDH5ob/O0vHFBiBSJQx2TG62vOU07wDMlu8A5JBgdzkII0UwKV9W2U2usgvsZgOpXxx+2jZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l2GdXoju; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l2GdXoju"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ytAhbThPNjXTfUodETZzpPMZu1FR/UjRFuF7PD2TYzI=; b=l2GdXojuHsJXgJ4rpXKIfG1a0T
	s7k0GA6kXT4jmAJ4e0Ji7+4860jftg8sUu+AXLp8nzI++WuKr1gNaxLjPSoYudHkKFHheYsHGC9ic
	bfbqBQIYxPUg7DXSrg1+c1Vmo9/UPjMZt9P8SbdxRNoiC4JzzeFhy4B64YZAimVs9cYeozmZqb3dE
	1npH6HwmFfaIJXkk8Fl31/PP0I6EqXzHHRy9/u+sZvwjmrInqX6VSlXKRoW73Mtk7SNkXtrXQZMK9
	rRO7LuuSfij1iEx9iK8a/xLDCzO5OMksMrSCd+wuQ4mqf6kztx6PqvwSueR3zhUyaBkLIW1cHAm4l
	ZzMQiSVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEM3w-00000001CWj-48dY;
	Tue, 04 Jun 2024 04:46:20 +0000
Date: Mon, 3 Jun 2024 21:46:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] null_blk: fix validation of block size
Message-ID: <Zl6cHI48ye7Tp1-C@infradead.org>
References: <20240603192645.977968-1-nmi@metaspace.dk>
 <Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 03, 2024 at 01:47:17PM -0600, Keith Busch wrote:
> On Mon, Jun 03, 2024 at 09:26:45PM +0200, Andreas Hindborg wrote:
> > -	dev->blocksize = round_down(dev->blocksize, 512);
> > -	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
> > +	if (blk_validate_block_size(dev->blocksize) != 0) {
> > +		return -EINVAL;
> > +	}
> 
> No need for the { } brackets for a one-line if.

or the != 0.

> 
> It also looks like a good idea if this check was just done in
> blk_validate_limits() so that each driver doesn't have to do their own
> checks. That block function is kind of recent though.

Yes.  We already discussed this in another thread a few days ago.
