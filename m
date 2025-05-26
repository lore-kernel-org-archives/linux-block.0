Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0433DF
	for <linux-block@vger.kernel.org>; Mon, 26 May 2025 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748236712; cv=none; b=S7/U+XICVYdv8YUD0lgskoPiMo6FvcNjvPj5F33WM3L8PrkF5Lhk/kyw/wM/eh16w9JGKHVY9hpWKIckOm576qug7jjTsMctYI+HB6iee9zq1B7MBltASHSbBjQsWtd/7+9jTdPnAoGw6Er+8VHwODeDjm/agFQ+gsS6z1MVby4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748236712; c=relaxed/simple;
	bh=EXV6x/KlPnDX2ADwVvVKwNZDRQoaCsDznKJQSOe06PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew9tgexZIy98Wc3kBbbkHzxIOzIDOsZP8NgP89V3xfMXENK4v/fJzpeg7tI5VaODtGFJnaMOomij5wysnb7knGfKjG8awQXUeE+VyL3HW7QCELaEV5/3/j1smd4o8D8h/M3nLVdhia94J97MGUWb9FcrTWaN/0q2cLEKRRqJ9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZTl0L4GW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZTl0L4GW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4wwc8UauzmXQBUl64dv+5rxzntTNKpq3jYtuHurAEEQ=; b=ZTl0L4GWJG2nuxMijuOgpKon6d
	DWlyesu+ygbgoHO1alZzrWVhY+MNij5fTziwk1PFUp6fLpYrmQf1eLOmFe0vETUFXus7XTV98lzXZ
	881lPLOYlZT+NIb+DFZzERjrW54cbGEVWX1SFFetOLAfYhvCdg47DBmzkoWi83ihZn4EMrW8dDi1B
	SSfd+d21bhfsFuvRAQkx0yNm5Qo3aC1/hIRv0bX6eiXSDfVcOXANDFUV2N+Wrke7PliFUYQMqV2ju
	nOb5wkMo09+x5oYb2h6m4P6hbWdTp+ULUCJTeGokSuBxoRYYM50hUHCsJVfFzyxeox0EV7WxNu+VF
	YVJaxRgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQEF-000000085mq-2XLo;
	Mon, 26 May 2025 05:18:27 +0000
Date: Sun, 25 May 2025 22:18:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDP5o1qb02iwgw-V@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
 <aDCqGLY4irp-6N5M@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDCqGLY4irp-6N5M@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 23, 2025 at 11:02:16AM -0600, Keith Busch wrote:
> > Maybe having common code is good to avoid copies, but I suspect most
> > real users would want their own.
> 
> But the end goal is that no host memory buffer would be needed at all.
> A buffer is allocated only in the fallback path. If we have the caller
> provide their buffer for that fallback case, that kind of defeats the
> benefit of reduced memory utilization. So it sounds like you might be
> suggesting that I don't even bother providing the host instrumented copy
> fallback and provide an API that performs the copy only if it can be
> offloaded. Yes?

Well, I'd expect most uses cases of things like GC to use the "fallback"
for now - because copy isn't actually that often supported, and when it
is performance might not be good enough.  So we'll need to optimize
for both cases.  Maybe a fallback code is useful, but I'd leave the
buffer management for it to the caller so that it can reuse them.  Or
maybe don't bother given how trivial the code is anyway.  The use case
for common code would be strong if it refactored existing code and
showed that existing callers actually have enough common logic that
it's worth the effort.

