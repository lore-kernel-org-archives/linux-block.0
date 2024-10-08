Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D542139CFF
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366998; cv=none; b=rBSmlv7diOIpLpjENf2KA1Q0BFkkFLBDIqIjTskdc6v4pLduxiP/tm432hZltU/6nBYZDfTqqJQvulziP0Mst+DhnGW1xPZYpq5LV9hd4tE811K1ihhbUd7lwOeLLKW0aRDOiueG+R7Miuc1/C/aaf8rdwIlUfK2bbmQPNhAOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366998; c=relaxed/simple;
	bh=DSRyihH5yADdOcch3uxd68dw/m0f6oVj6DOReuhntHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGkbRwANhO8wY0lQs98KhmGZ7xTuIl0+CYE3TmviVg1JA9YLMefw58GnQiXAQJ43No/9r4+XVVaK/Mn7NvEnRkHMAO7p77pPDVsJaz5NzBS+yHujrfuQLI05tDH1Ns5uPserLXCNZ9f7V7ehygKsaQDH+rs9S6Uxl0B5CG6icRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d9PKzZg7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d9PKzZg7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fdLM9Da5aK6+wtUbI1e1dHo2rTh0UZXhAR+baycD3+8=; b=d9PKzZg7OacdmMWNE/NAgSHKgp
	7TE5NxKH6Pt55D3ICvb/+IcQI39ep370ZkgNH0g7TU62aZ3Cw/1/EzXsG6U6cH7k9ImfhF+KQyc9/
	U9O8j54MqJE1qIwKU11udDYGaVGe8TKhSTSVjpt2F7NH8cFMLDiDZRvTRd674/EcQuybr9jBSrPRe
	lYlYd+U3tJTnCzgdOkyzpGvedyR05PfNk5bE8qxRcKk9lJCMbdNaHYvczgRacx6RGmiSEt9f0O5dB
	mO1ZZZDSWZMaX3d1TAsz9RQFnaTFxG6QZn9EvpvYi18DQJ9GPDe9B2TZA/T8SUfbwYd0RZsLsO1CW
	iu6RRgaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3Cx-00000004b97-3BQQ;
	Tue, 08 Oct 2024 05:56:31 +0000
Date: Mon, 7 Oct 2024 22:56:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <ZwTJj5__g-4K8Hjz@infradead.org>
References: <20241003085610.GK11458@google.com>
 <b3690d1b-3c4f-4ec0-9d74-e09addc322ff@vivo.com>
 <20241008051948.GB10794@google.com>
 <20241008052617.GC10794@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008052617.GC10794@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 08, 2024 at 02:26:17PM +0900, Sergey Senozhatsky wrote:
> Didn't copy one more backtrace here, there are two mutexes involved.
> 
>   schedule+0x554/0x1218
>   schedule_preempt_disabled+0x30/0x50
>   mutex_lock+0x3c/0x70
>   sr_block_release+0x2c/0x60 [sr_mod (HASH:d5f2 4)]
>   blkdev_put+0x184/0x290
>   blkdev_release+0x34/0x50
>   __fput_sync+0xa8/0x2d8
>   __arm64_sys_close+0x6c/0xd8
>   invoke_syscall+0x78/0xf0
> 
> So process A holds cd->lock and sleeps in blk_queue_enter()
>    process B holds ->open_mutex and sleeps on cd->lock, which is owned by A
>    process C sleeps on ->open_mutex, which is owned by B.

Oh, cd->mutex is a bit of a problem.  And looking into the generic
CD layer code this can be relatively easily avoided while cleaning
a lot of the code up.  Give me a little time to cook something up.

I also wonder if simulating a cdrom removal might be possible using
qemu to help reproducing some of this.
