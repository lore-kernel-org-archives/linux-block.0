Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795220295;
	b=iZnoBfH/e3pLPUUxv3yuNVmVhXpLN9kNLgSyIBAhMPIXDxXNw1oT2mEUlHj/Y2B9Tmlq
	 flcWmOHC1jWHagYG4GHinq3pdBTax2RFxfVQFNoipRKfLiYr5UB5zvK+KW1NV57meO324
	 Eqbgj+90YtfWQvsPe3ezxrZzKcqwFPpTx0Q98jHSFnvyiFUGBOQ8iOXVaghRem+9SKlNW
	 wXVVhuPHYmRmN/qlyVJ1vBHl4qZV66NlSl2j/rbT9ONJQwaTeg57A71nTnWTURDD/cBTl
	 Csn1IN5dTSD/rsw4r1QzhD8170AcsqMP68lTGW5qsU73cAd/GfiS3pe5kKweesGxDPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220295;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=bUl/Ij4WWZ2sDRqLSl72pLi8NgdFF2M/VvXuv124Cck=;
	b=2Ldf9xcPk2+3AXkcclHnhPn0FTiZpFDhGDq+vuUX/xQ5XWGNsKQykC88zhdj5SEG83Yg
	 fjTqfJI4cKV4T1U5qe1zabaPOUhfxoTJEukcwp6FHh3NsswvuD50yiay+2sA+F7v7Bs1k
	 /FdwkFJXAOsVMAjCV3sR7LLLP0rM3nNgJ71EY713Y2CcCnHjHGiBwORsbMJoaM2VbdTGi
	 cxMF3R6pxPih+JpCVmDCugj0WpzIPbGrk3XuYmVCQRUMlCs+gZAhM5ZTxy5il70WyJQUe
	 i1Nsb4Atu1+Roo58U54wNPWualoWDOmqq9lp8ifLsv5791MsuQzzNGGWQfNnoY5eF4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OtbhHZ9U;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE089606A334;
	Sat, 21 Nov 2026 00:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE089606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OtbhHZ9U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bUl/Ij4WWZ2sDRqLSl72pLi8NgdFF2M/VvXuv124Cck=; b=OtbhHZ9UuSt9mJO0ewG2QhQWgO
	oSqprS52u2KjqNy76GCV5uICjvfRhKWsVd1D41IaEhRvCdz65NDCmoTqkA/ZRaP5UAoF49PiVMc3H
	+r/j1/w5AaqjOhyFYzWOZpNjTyGhxGGCl1jnKcf9v0xQLeVn4WAjhnPxj/2venBjhpwuX38wA5dl7
	ILQ6RcrovZJ7rX56M2hF4Ek8bqFeiK7FHrW3LzcPEuKGw7+7wqD2YLlihGdNDjxdayeYOx4SZNKbI
	tEzJZWJ5qP5BHFSRtARUoToGqC5uif5VkoycPAUwycF/HMSa7dQ09D3WHkGPsWHbVoixCWhewDeGM
	NFDVzhqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUYo0-0000000GUgX-1yjV;
	Sat, 21 Nov 2026 00:18:12 +0000
Date: Fri, 20 Nov 2026 16:18:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/t10-pi: deduplicate
 blk_reftag_remap_{prepare,complete}()
Message-ID: <awDjRMv-TSvZKDdS@infradead.org>
References: <20261120064806.752251-1-csander@purestorage.com>
 <awBuiVyOQj_YHCZD@infradead.org>
 <CADUfDZonvcOkM7DD76Gg=Z6NHhM87a+n0xPirfTYS+wLLnHfmQ@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZonvcOkM7DD76Gg=Z6NHhM87a+n0xPirfTYS+wLLnHfmQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 20, 2026 at 10:29:18AM -0800, Caleb Sander Mateos wrote:
> Sure, happy to switch to an if statement instead of the ternaries to
> initialize from and to. However, the code generation is worse with the
> 2 calls to blk_reftag_remap()/blk_tuple_remap(). The compiler doesn't
> notice that the calls are identical except for the swapped arguments
> and emits 2 out-of-line calls to the function instead of inlining it.

Add a __force_inline tag to blk_tuple_remap and see if that fixes it?

