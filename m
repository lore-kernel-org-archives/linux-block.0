Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771E1FAA;
	Fri, 16 May 2025 05:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747371995; cv=none; b=q3tn5KBRd2rhXLgIhILiKRp/bHjTWcc1OCrxRkwQuUStKP04Tndb8gf5N3HUkva2M246dIdHCJ8woH404NvBHVxc0jdcYhBMP4h4ZhAJQIOk2N8KYabV27iez2hkwfLbO+IG8S+DVi+oqLEb2Fus4itl1Tq9/QmPcxvm9LEOVRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747371995; c=relaxed/simple;
	bh=YdryWNyIKuDW1Oc5I6PriD/WKRFUP15ge9Pd6nr4mVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRiTurT5+fUCnazSMpSiyXb0ohvQ6ptSbMwfMXM0VwOOx0AzVZDm8DvnJLeilaMWHWm2g/ASZJGfnRpTdET+LC5DM4QWom+iecW6zup2lM0IbY/s9IDt4wakYx16XbpZStqG2RBNc84Y7GHKIu9DunLv98EmFn9hKt6cFJzwlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EPPlPlGI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EPPlPlGI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c/kXnQe3xBJvxiLTBwNnRGNRT5ysZ3DFWAv0O+/UyX4=; b=EPPlPlGISmDCej/eoIP/GfC61v
	auBL/4dTZMPc5zVdfq7mq4ssKnR96MpKhEfNOu7Vo2W1AyVA6tB0IMqrN+9ajUdN1JS6lEc1ZaKWg
	FNIyYFIhOy0uvxcav7UhhM1Tnhp0/vUUokzZsIRNoZ0o/NkXveE/ZeB87WPWRvjZIbCsM19n7XFDM
	GNMneNUObX71OdbKfyUvQjtiLILGKmyUNa8h6TqZHNRT9FgRxxBMT4mT+YOml01XWIZ1wHPprzajv
	E8L+1kdVBHoZF1zKnvT/E3+KvV7YL67g+/BAT23jVR8ALFx6eElHSRo5QuvkGkUT+xC5eil4YakEG
	8EsHlWog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFnHB-00000002Ubj-25zH;
	Fri, 16 May 2025 05:06:29 +0000
Date: Thu, 15 May 2025 22:06:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v2 2/4] relayfs: introduce dump of relayfs statistics
 function
Message-ID: <aCbH1eA8Iicg_Fq_@infradead.org>
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
 <20250515061643.31472-3-kerneljasonxing@gmail.com>
 <aCbBEg-DFYvx0Dpa@infradead.org>
 <CAL+tcoBtLu6_E1qKL9VHOiCe_RVpEGzMiMqA3GpPi1Z88aMiWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL+tcoBtLu6_E1qKL9VHOiCe_RVpEGzMiMqA3GpPi1Z88aMiWw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 16, 2025 at 01:02:59PM +0800, Jason Xing wrote:
> Do you mean make it inline in include/linux/relay.h like how
> relay_write() works?
> 
> Will do that.

Just drop the extern, which is not needed:

size_t relay_dump(struct rchan *chan, int flags);

> >
> > This export seems unused even with the entire series applied.
> 
> My initial thought was to provide a symbol for some kernel modules to use.

The only user is blktrace, which can't be modular.  Or you plan to
submit a modular user soon, like in the next merge window/  If so
note that and add a pointer to it in the cover letter.

