Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A133F368
	for <linux-block@vger.kernel.org>; Thu, 25 Jun 2026 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782418661; cv=none; b=gb5/o961aof/xBfcBJsnEBySyeurc0stgF2cqQhINvV1vr7FXaLz+SqSJrfxKMluGFbzEoYzxpaTZA/lsU0IKbY86byGCqPhgwgMBLm0G3ZQkua6zokdnESpIHKv1/f5aLxjUR+LTsACYgzGT+LGNkwyyatzm44vJQqwZPePcFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782418661; c=relaxed/simple;
	bh=Izc0NVSPXXcD4NJ1yqxEXCHH7gi6Ol9B/Vcu1im+tKs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ku7t7JFNANxrue0Q5AZyupJ9CrbHUbq6LL9sHrzboQjF5+9QNvEte6Iw1rfJ2xQZIDENqzl6gOVd5+yJZH1znbdQJ5+FNnCNfIJ7xicltpBSCuw12O/yxJ4hzxRqgumlZ6Twt6OHGdax7nrcifHRtq/prJM1qRGyXRcFcjmUDpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B8tC+7/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B8tC+7/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C6D1F000E9;
	Thu, 25 Jun 2026 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782418659;
	bh=f3fZrNlOuQ3bmippvymiqUka8ZXELB1zwP/Z4jmtZxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B8tC+7/YZb8RcTEoQ/5cWlPL9lj5H6f2CzNa02Mv0pY93VfgylwXhnsWBfbEJdZqP
	 u5Wlo1R4fT7HuUxAQVjQGf3NptkLZ0KOA8+dRa+wrLuF/0CkWtj86OTo4Twipu/6+L
	 NWCkxmdJHc/dRXsQKJXwz8vKsnVSjfjFP83NmX7A=
Date: Thu, 25 Jun 2026 13:17:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo
 <harry@kernel.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mm@kvack.org, Vitaly Vul
 <vitaly.vul@partner.samsung.com>
Subject: Re: [PATCH] mempool: optimize mempool resizing
Message-Id: <20260625131738.b7c10540e5c598cc9b60e19d@linux-foundation.org>
In-Reply-To: <20260625194915.387663-1-vitaly.wool@konsulko.se>
References: <20260625194915.387663-1-vitaly.wool@konsulko.se>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 21:49:15 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:

> From: Vitaly Vul <vitaly.vul@partner.samsung.com>
> 
> Resizing mempool to a bigger size currently requires a new allocation and a
> data copy to a new larger elements array which doesn't go well with the
> idea of having a fast and deadlock free memory allocations during exreme VM
> load.
> 
> This patch introduces a new parameter max_nr for a part of the mempool API,
> which denotes the maximum size of the pool. With it in place we can avoid
> any allocations in mempool_resize() since we can either grant the resizing
> request or reject it basing on thr maximum allowed size of the elements
> array. For those few users of the mempool API that actually use
> mempool_resize() it is a clear upgrade because the maximum number of
> elements is known upfront.
> 
> Derivative APIs (like mempool_init_kmalloc_pool()) are mostly left intact,
> substituted by the new mempool_init_kmalloc_resizable_pool() API where the
> pool is actually meant to be resizable.

Thanks.

It would be helpful to have a description of what inspired this work. 
Presumably there is some observed problem in nvme or in zone-blockdev
use?  Can you please describe the problems and also describe what
effect the patch had upon them?

>
> ...
>
>  int mempool_resize(struct mempool *pool, int new_min_nr)
>  {
>  	void *element;
> -	void **new_elements;
>  	unsigned long flags;
>  
> -	BUG_ON(new_min_nr <= 0);
> -	might_sleep();
> +	if (WARN_ON(new_min_nr < 0))
> +		return -EINVAL;
> +
> +	if (new_min_nr > pool->max_nr)
> +		return -ENOSPC;

Seems strange to return -EINVAL if new_min_nr is too low, but -ENOSPC
if it is too large.

Also, (pet peeve), ENOSPC means "No space left on device".  If this
errno ever makes it back to userspace, the operator will be running
`df' and wondering what the heck happened.

Also, AI review had things to say:
	https://sashiko.dev/#/patchset/20260625194915.387663-1-vitaly.wool@konsulko.se

