Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156D61B424D
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034401; cv=none; b=pfMkbOeeJ8UWnUWHC+dsvMZK+NsgVg2Xun5N1aOrYyz2nRyvISk3QkwHDN6Se6T/h84kxceNHDGlP3EvzEvZ3O/ISviLgffGslWMU/DmznVkoAQSwYNgkGfBL3z7OPJuBWE1SKBY4j3ocLFVNbNuE6LkiUmsnV7fyHNtmv+ra3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034401; c=relaxed/simple;
	bh=Edh8voQ4gmeg1dBuUeiB1DKi9ai5QuPoPRTDedT6MRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIEi2w5Z7OqnZ9aHhLX/Fc6wKVxg8shFhwL2cQZfoyTMMq8qWMamGf0M7Kk2wvSo47CZ3PlY5jxszrK1SHUN0WGhiz8rxMB/ZoKcx/ttOsgxbVStJ/hj5dtgtBC0AdTYFF/6U52Q+Q5MmHJkAye52miYyx5AAUwpYVpE12peYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nBok7peZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBok7peZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jefGzqc9rh2Y8cnlq2OWjsGY/uxUJ6PhqTLPAWKQO0M=; b=nBok7peZ8+zr9am2tVBKHCl6Rk
	Oxs/L65NbgGufm1yQ2WjWf96l8aXYd6l2TeqP9o3HF/4ceTqHJ8hmS+5kAh6JBBureUBb+oQiVWRQ
	ujjoXOEksMJwz1OQWyzrlVGlKZFDZSSwxiqBjurFGUW3hwya8OcEaolrRjrOwvfeyG4+ZiugEA0CK
	J3nER/36OIHI+cw8ZLjmMSCjxch/fZ/WRQiI0pE6ypqWeW2QwrEG6PLZR0RYn3RmZL9nMPRtFJ1pN
	Lc+wCOCwwtcLsjECHBuYI7CQXxRLAYumrZMVkQ0dFNrR3/FeeGVeAjsttv9C7vZgEB/XNmtfGscCB
	kVQ/eIyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1n11-00000000dNi-4BVx;
	Mon, 07 Apr 2025 13:59:55 +0000
Date: Mon, 7 Apr 2025 06:59:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sean Anderson <seanga2@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	Zhihao Cheng <chengzhihao1@huawei.com>
Subject: Re: bio segment constraints
Message-ID: <Z_PaW2QS3OXTXHSO@infradead.org>
References: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
 <Z_N5nxLDOBb5NDAM@infradead.org>
 <Z_PXONJyuv4Z8ATr@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_PXONJyuv4Z8ATr@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 07, 2025 at 02:46:32PM +0100, Keith Busch wrote:
> > > - Is is possible to have segments not even aligned to SECTOR_SIZE?
> > 
> > No.
> 
> O_DIRECT only requires each user iovec be a multiple of the logical
> block size with the address aligned to the dma_alignment. If the
> dma_alignment is smaller than the logical block size, then this could
> create bvec segments that are smaller. For nvme where we have 4-byte
> dma alignment, you could have the first segment be the last 4 bytes of a
> page, then the remaing 508 bytes from a different page in the next
> segment.

Oh, right - with a smaller dma alignment this can actually happen.

