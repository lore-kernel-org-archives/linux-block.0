Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4313403E0
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383018; cv=none; b=fuu+Qraqza8x9DvyLSeJeZ4vJ/fBvVBMmTU13NbA7L5U3dlvzvKPTZb0JvFxHjtZ+abNqpmTEbqC49gc3++02/GuqBh3IZBSvgVeda72zuQuX2IKV261gtgJ1i6CJagyhBldCtRzt4l+GnJGMSK5JZO4rFEm2qS+QpQwUqXRlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383018; c=relaxed/simple;
	bh=e7YvS4j678Ou4a+6R8a+miN5ecqPE4nRWduFuaUTYic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWJ0JWhOwHFLt7U2TTKgDcOov3z5OHldFTlWBXuyjozKsi5Y1TmXDijI+D3ADWrEX346hJWRPtsMHSncvXB3w5qd0EJVLUr8Kl3A/RgXMEj7v3f3W1vh5BXLRvxy0Da9qtMzEYWzYU//hmGizM2sAj+HuNkoYp49c/ioUG8n/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hIizP+tW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hIizP+tW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KkkcSoOi9f07lBzknwF7AgMopgLZDilHFojYbdHd0NQ=; b=hIizP+tWsSJ72P7WBFXR+h+XpV
	oATVkFD4OdQ5FgEVswwE4RX1yeCSVsyd+c/wPCP4TFu4WFOpYEkMfbZKVQFH4p+2vg3gZ1fQiwsQw
	HDpPUbE0H6gHjW7jMENvMji0XbnuqnzE3z+5UNCBHKaiyodHh3TZd0NfcTyt6C0hQHn53RI1nXCeY
	vFOyOMfCAEbp/iSAQx4QQ3zgwxyqvVCq3sY2XKGFGhf7Hb9rZU7tkkF2dsOSlbHejE++L0VA0tkqp
	AfLOd69OWPC3suhcvJiP3nJ4f8NdGyuCLGKFvbsgZljYBv1Ud+OTqQqN2dwxeePhoxl5eTyoVBYYc
	czJ2tInQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtTpF-0000000CWx9-0yY9;
	Mon, 10 Aug 2026 17:30:13 +0000
Date: Mon, 10 Aug 2026 10:30:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	Keith Busch <kbusch@kernel.org>,
	syzbot+ac00e7bf7ac8c91af921@syzkaller.appspotmail.com
Subject: Re: [PATCH] loop, zloop: fix dma_alignment for large or unreported
 limits
Message-ID: <anoKpXNErXHEEVic@infradead.org>
References: <20260810164218.3721636-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810164218.3721636-1-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 10, 2026 at 09:42:17AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A file system sets STATX_DIOALIGN with zeroed alignments when the file
> can't be used for direct I/O. The zero underflowed to UINT_MAX and
> triggered a queue limits validation warning. Fall back to the block
> device's limits when dio_mem_align isn't reported.
> 
> A file system with a block size larger than PAGE_SIZE may also report a
> memory alignment that can't be expressed as a queue limit. File systems
> fall back to buffered I/O for requests that don't meet their alignment,
> so cap the reported limit to the largest possible value.

In general having separate patches per driver would seem nicer than a
batched up one like this, but the changes do look good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

