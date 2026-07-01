Received: from mailrelay-egress5.pub.mailoutpod3-cph3.one.com (mailrelay-egress5.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340963A4F33
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896651; cv=none; b=bqbiMySwFkZrqjeQXCZnjlPbUjn5kNAhJRXa2rjWwP8SLcX4t23n2Tt6Dm9f5Vcrq6PPw2ySdw3eHeB6am6U6WDBIAfixiEqcflLoA8GQJGWQW+DrjrgsYza8NOnDIj2pY51VcLN7FRWDc590azTgnphykRDq7Np1OzkjtnrPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896651; c=relaxed/simple;
	bh=Co7b14wHeeCKY9BLoZpBso1LTqtBm/7vBRyRF4b6Igw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gcZq3EMW+C4/gWZOQWoyUqF7yFCPKwNRF9ssTH8sNQlWzrqb1L3rSciq9mw8NmA++sQU6QozBoG5dYxTYJ70s+XFuMEx6XbQAefWey3MgHYT3VCrfcXUkThlGuqSVS7HOqPeVb8Q4JDObRTSSs1szCb//fHqctIJfRcqTRI0AIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=M8LfqDYd; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=aAtI26ZD; arc=none smtp.client-ip=46.30.211.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="M8LfqDYd";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="aAtI26ZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1782896637; x=1783501437;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=2I4SEOxas6X0x5H7zz6wH0Lfb6ZZgh0f8mcYajOzvc4=;
	b=M8LfqDYdrxNmY6wM9ssCGtFKfo1sypg4ZbtkSenfafxQDvH9IMfhD44UynTuwLB9Hw0Qwgfo2ICZu
	 eWUKJC1nUMJOxNA0nFml8AZRouIEJmvI3l3V4ihlgsIuwchepcql0xdoV3ElGLLF/xQzEO1SFlJCkc
	 cYYOyzbyOM4KsieeNmZf3FtPPrqRuwjCOU0Q8+8Gtxjn6klEuht74qQhWj6hwx+BrRM/NXfwDM6qNe
	 eTcuo2bRWcx5vg7tGRgEQyxANAeyjs62txgoWVpDfbmAQGKbwA5VK+KzR3YkAkywY4i6kZZkZ5T9z0
	 G1zVpQgRIMP84CiwE6HCAw3ZZY1XARg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1782896637; x=1783501437;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=2I4SEOxas6X0x5H7zz6wH0Lfb6ZZgh0f8mcYajOzvc4=;
	b=aAtI26ZDbZmqTZCwHgKvV78ZV6Jz/T53rPuFdKmoYl8nQ3SZmDExBtXiXcfeM5nDrzylNZWcSD9kT
	 rKHZcHHAg==
X-HalOne-ID: ca031a73-752b-11f1-9565-314137fccf3e
Received: from localhost.localdomain (c213-102-77-204.bredband.tele2.se [213.102.77.204])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id ca031a73-752b-11f1-9565-314137fccf3e;
	Wed, 01 Jul 2026 09:03:57 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-mm@kvack.org,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: Re: Re: [PATCH] mempool: optimize mempool resizing
Date: Wed,  1 Jul 2026 11:03:51 +0200
Message-Id: <20260701090351.869635-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260625131738.b7c10540e5c598cc9b60e19d@linux-foundation.org>
References: <20260625131738.b7c10540e5c598cc9b60e19d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Andrew,


On Thursday, June 25, 2026 at 10:17:38 pm +02:00, Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Thu, 25 Jun 2026 21:49:15 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:
> > 
> > From: Vitaly Vul <vitaly.vul@partner.samsung.com>
> > 
> > Resizing mempool to a bigger size currently requires a new allocation and a
> > data copy to a new larger elements array which doesn't go well with the
> > idea of having a fast and deadlock free memory allocations during exreme VM
> > load.
> >
> > This patch introduces a new parameter max_nr for a part of the mempool API,
> > which denotes the maximum size of the pool. With it in place we can avoid
> > any allocations in mempool_resize() since we can either grant the resizing
> > request or reject it basing on thr maximum allowed size of the elements
> > array. For those few users of the mempool API that actually use
> > mempool_resize() it is a clear upgrade because the maximum number of
> > elements is known upfront.
> >
> > Derivative APIs (like mempool_init_kmalloc_pool()) are mostly left intact,
> > substituted by the new mempool_init_kmalloc_resizable_pool() API where the
> > pool is actually meant to be resizable.
> 
> Thanks.
> 
> It would be helpful to have a description of what inspired this work.
> Presumably there is some observed problem in nvme or in zone-blockdev
> use? Can you please describe the problems and also describe what
> effect the patch had upon them?

We are using mempool for a variable number of large buffers, the maximal size of the pool is always known. However, as these buffers are large, we don't want to waste too much memory on a saturated full sized pool.

Besides, it takes a lot of time (seconds!) to saturate such a pool and we would absolutely love to avoid that.

Basing on the above, one can conclude that we're using mempool_resize() quite often. And for that to be efficient, we need to know if we can grow the pool  without having to re-allocate the elements array and copy the data. 

Since all the existing users of mempool_resize() actually know the maximum pool size for their respective cases, the easiest way to implement this is to introduce the hard maximum, and that is what this patch is doing.

<snip>
> Seems strange to return -EINVAL if new_min_nr is too low, but -ENOSPC
> if it is too large.
> 
> Also, (pet peeve), ENOSPC means "No space left on device". If this
> errno ever makes it back to userspace, the operator will be running
> `df' and wondering what the heck happened.

Hmm, I see your point. Let's go with -EiNVAL in both cases.

> Also, AI review had things to say:
> https://sashiko.dev/#/patchset/20260625194915.387663-1-vitaly.wool@konsulko.se

Sashiko is doing a great job indeed. My 2c on that:

1. mempool_create() should create pools with max_nr = max(min_nr*2, 1); and this will be fixed in the next version of the patch.
2. There were no forward-progress guarantees during pool growth in mempool_resize(), this patch just makes things simpler and more obvious.
3. pool->min_nr update will be fixed in the next version of the patch.

Thanks,
Vitaly
