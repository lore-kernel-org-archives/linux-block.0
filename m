Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE72B18DB3D
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612455; cv=none; b=DpGgXjkJMEBMSr0R1WXYRBJgddKfuOPHzlS1VYpqAHYNJD7cpksmBRqi4Wig8gi75k00214//KQRgIoIUHc9gTo7tldTV1icvkobg5FnlG/WdaAGVBuoGnil+gNeDYw3dt0OBUM0FxIWXGJFEbaO3zOm/mVt80aZNFec+kpKluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612455; c=relaxed/simple;
	bh=YbfdiYVNj3CWAA62+jwJBgzDeqrrheox7G9ctMyMPYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tb7TceLULrFfcq6rSSnK6T9KreNhcbARy9JfcNiUHu1IobCCp2j4qfZIssRtZ7yosXnaziAZciipN1HFYA+lsU7qukFMyffjBPyusvYoCnKoGvjODcSVg37KJG9ozkuFLjzAoPymewN4G5xKeJciLaHcMjjY1NUyHbkvHugdDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4xc6LqRw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4xc6LqRw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YbfdiYVNj3CWAA62+jwJBgzDeqrrheox7G9ctMyMPYA=; b=4xc6LqRwZmxKE4PiaoDgK2rX2j
	60aughi/Yz3hWzk1NChv51se5PCZkBILYDu+IKfyj2IBzNfanO4AxUMLq+CsGqqc34bzUA+0I36TS
	E3N8TcDs+trl842ssFarklwoBnrNdlzPSByN5+DvYXYZ0ke4hB1A99zeJig1Hbewf5THlUNlxFEvf
	Df5lY42h+tDhmhC6FYl3waTs0wXli4U2r0AMHUCpfP+ctv55QLNKQV7dpWo+bOnQ2fh6DEH4Q5931
	JIHi7lFJPynzF+kRhxqUXI9O0bnlXezX6U2QgZa04TQAy2RHw8aInHGWWJkt4r5giVFvNT7juEi2u
	xWCm3hFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPC7h-00000008jjY-1udp;
	Wed, 11 Jun 2025 03:27:33 +0000
Date: Tue, 10 Jun 2025 20:27:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Clear BIO_EMULATES_ZONE_APPEND flag on BIO
 completion
Message-ID: <aEj3pfzxUaIY_-jD@infradead.org>
References: <20250611005915.89843-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611005915.89843-1-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 09:59:15AM +0900, Damien Le Moal wrote:
> When blk_zone_write_plug_bio_endio() is called for a regular write BIO
> used to emulate a zone append operation, that is, a BIO flagged with
> BIO_EMULATES_ZONE_APPEND, the BIO operation code is restored to the
> original REQ_OP_ZONE_APPEND but the BIO_EMULATES_ZONE_APPEND flag is not
> cleared. Clear it to fully return the BIO to its orginal definition.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

