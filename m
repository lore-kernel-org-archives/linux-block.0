Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921A22EED;
	Sat, 29 Jun 2024 05:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719637677; cv=none; b=HsAFKM/Nd/WoNEfPq2LcAOdDnNhiSTys06gRjMqJUY3oHuvTU19IIhfy6mcG8ZlCvxoI+649Qr5JE12DmoglaqBNAoepG87dC2txfpcmPk4BezuOpvAyeauEicfjHf5BtKxhZkC/t4WHiRIAHNKnspKDRtHnKg337T7806IsNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719637677; c=relaxed/simple;
	bh=JiGa0hM0IJCfmGk8pEs5BdhbltrxovzTV/1aDiuYmBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsBpQRAhgfDKtkx6UkJaZg0ynDhY1chV10Qb/Pb9Ugz97Qr9OBOYu5lkW/Bs4h+SntbcbQVLfWmGDoED+fDkvFRrlrfBRUck9eOCd/mpYd9+5kJBRzGZV0x1ynoM/HKpyMN5DlTxd3yfExcml5UJq1L0zEqiGf7+h5uAK8H6ypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FakoS15h; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FakoS15h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x/HYiLGQ3SOLxAS6bivKppuZ/MDeziKeAXkLEabBkL4=; b=FakoS15hg/TtOqQf8cSf/fAnUq
	vtIKLozCEJWWXJKKv1384bi6C739JgRQjQyN/4RzdP7bUqWTJL2R7w361hJLwk21bABqpt8EBjZFc
	fRMKLTooEbrh/nBzyxrBIQ7qJzaNiikhfxkqwD9MnLdsoQOcccpAtJ+ZHWA/mghyYfJG5VceHnpAI
	ddbg7v02JW7FsWfoyVV/cFrcPAjf05rpCY0FDPKGEm5F+SxNXpjYJgzCug3jV8uS0uaxWr9OAE8X8
	UpTlZ68BBXYdkGOUkeZlNASaCy/Xy5YtvlSyDUoAuMTZvqpgkFkWY9+lvGO376TeAPeTSM795WBHl
	aeTXiaPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNQJS-0000000Fuht-3oFz;
	Sat, 29 Jun 2024 05:07:50 +0000
Date: Fri, 28 Jun 2024 22:07:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] null_blk: fix validation of block size
Message-ID: <Zn-Wpq2AzBo6rcgd@infradead.org>
References: <20240603192645.977968-1-nmi@metaspace.dk>
 <Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com>
 <Zl6cHI48ye7Tp1-C@infradead.org>
 <8f8f8f78-fcd4-4e71-8dd5-bae03a627a34@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8f8f78-fcd4-4e71-8dd5-bae03a627a34@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 28, 2024 at 03:30:00PM +0100, John Garry wrote:
> On 04/06/2024 05:46, Christoph Hellwig wrote:
> > > It also looks like a good idea if this check was just done in
> > > blk_validate_limits() so that each driver doesn't have to do their own
> > > checks. That block function is kind of recent though.
> > Yes.  We already discussed this in another thread a few days ago.
> Has anyone taken this work? I was going to unless someone else wants to. 4
> or 5 drivers directly reference blk_validate_block_size() now.

I haven't look at it yet, so from my point of view feel free to tackle
it.
