Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A634D4EA
	for <linux-block@vger.kernel.org>; Sun, 21 Jun 2026 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782066844; cv=none; b=aIrZgixrMxjsAnlMARAYgx0QViCTTxDG8aIiVASDeO3ZjfW9+/8lbmKY/cm89omMss+qx4tggruefqZaYKXJt1OXzLleaAd29IBf1bHm4Hzdu2d0nwoq53LN34ZJQM/M9vN6lHq2xvYAGPRMKWLZN6ftSpxqV0Ek12s9H4/V9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782066844; c=relaxed/simple;
	bh=5QlDLf8SQDOeoIfSCkdH2+1gK99hn1dAn40S+rifjd8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OcMa4KeI/3ZOvnu40Xd8YIXRsY91FJJ1OpbUyE+uQJzvJV4lliUPU5srQHNGiTb8lU8lQVd7EtLurVsg6etOyEk5rQo/Xr5/IiRq0+1IsBr1iTtc7tr/2vTeB52jZ7wjsxbd9YouXqyIznI4j/1h6FHe8IChtcNySBLGf5P3iFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FxKLKXmv; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FxKLKXmv"
Message-ID: <02d53444-a0f6-4135-9e94-8ace2d89b0c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782066840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2cZkl4yw2fKXXfmszC3Jt+fvYCWM7AKjOfb2EHPKc8=;
	b=FxKLKXmvQ9yNLZnr8L1aPNBPdcXzFvfAZkOtO+34GXggY+mjdcPQ+VQ05q3uxJH0rlp4vd
	ejjw51qNey4ncRhRsjQySrCRr+oCFz/S3HUrvHbDxG1u2tDVqY+ZEIeJM00VbMqXW/3tIh
	ll8IvNvPYAS1Co4CUdFn/2UMZT09QjM=
Date: Mon, 22 Jun 2026 02:33:28 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] block, bfq: protect async queue reset with blkcg locks
To: Cen Zhang <zzzccc427@gmail.com>, Yu Kuai <yukuai@fygo.io>,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jens Axboe <axboe@kernel.dk>, Arianna Avanzini <avanzini.arianna@gmail.com>,
 Paolo Valente <paolo.valente@linaro.org>
References: <20260621135930.2657810-1-zzzccc427@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260621135930.2657810-1-zzzccc427@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


Nice catch. The race is real, and the fix lines up with how the rest
of the blkcg code already protects blkg_list walks — the new nesting
(blkcg_mutex -> queue_lock -> bfqd->lock) is the same order
blkg_free_workfn() and bfq_pd_offline() use, so no inversion.

Reviewed-by: Tao Cui <cuitao@kylinos.cn>

在 2026/6/21 21:59, Cen Zhang 写道:
> Writing 0 to BFQ's low_latency attribute ends weight raising for active,
> idle and async queues. The async cgroup path walks q->blkg_list, converts
> each blkg to BFQ policy data and then reads bfqg->async_bfqq and
> bfqg->async_idle_bfqq.
> 
> That walk was protected only by bfqd->lock. blkcg release work is
> serialized by q->blkcg_mutex and q->queue_lock instead, and
> blkg_free_workfn() can call BFQ's pd_free_fn before it removes
> blkg->q_node from q->blkg_list. A low_latency reset can therefore still
> find the blkg on the queue list after the BFQ policy data has been freed.
> 
> The buggy scenario involves two paths, with each column showing the order
> within that path:
> 
> BFQ low_latency reset:              blkcg blkg release work:
> 1. bfq_low_latency_store()          1. blkg_free_workfn() takes
>    calls bfq_end_wr().                 q->blkcg_mutex.
> 2. bfq_end_wr_async() walks         2. BFQ pd_free_fn drops the
>    q->blkg_list.                       final bfq_group reference.
> 3. blkg_to_bfqg() returns           3. blkg->q_node remains on
>    the stale policy data.              q->blkg_list until list_del_init().
> 4. bfq_end_wr_async_queues()
>    reads async queue fields.
> 
> Fix this by taking q->blkcg_mutex and q->queue_lock around the
> q->blkg_list walk, then taking bfqd->lock before touching BFQ async
> queues. The mutex serializes against policy-data free and queue_lock
> stabilizes the list. Move the async reset out of bfq_end_wr()'s existing
> bfqd->lock critical section so the lock order matches blkcg policy
> callbacks.
