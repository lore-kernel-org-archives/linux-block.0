Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8F101EE
	for <linux-block@vger.kernel.org>; Sat,  7 Dec 2024 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537856; cv=none; b=AVhKVHhNt0PfGQKLRaDEN4JGNrtti6iULVbim5ap56ZRHcANiWcbqO/ePy/OWexUqWTuKJCN4wL/qwETov+IoVulRBWgKcxjTM88rDOYpNaDnqnljXtD3lmjiBiMu39ucFI8pBkU2nsOJkAVOc59kY6RWm7pNJGBJQSImhXmjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537856; c=relaxed/simple;
	bh=2uYHA0TjDDtm7StEcgANXzA8wqkBwLHBcQNhqUY+N/k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aG6GFcwO4R7JztGiQShys4+ySeWiyScLFjS19RbajqUADWfyDY1LXWJ4Coy+5XhsTBGkOqVTRI11slDT+W7LeW28jHr6HDdSP4tBN1PrE84h1Vnn4tnlcqfo12qDsodvJAuoywuxKAE0ka6hTbvu9/OJO8TMhOEgDr4lvz9/zGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y4sFx6QFdz4f3jtQ
	for <linux-block@vger.kernel.org>; Sat,  7 Dec 2024 10:17:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 013D51A0568
	for <linux-block@vger.kernel.org>; Sat,  7 Dec 2024 10:17:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4cwsFNnNYuGDw--.56808S3;
	Sat, 07 Dec 2024 10:17:21 +0800 (CST)
Subject: Re: [PATCH v2 2/2] block/mq-deadline: Fix the tag reservation code
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240509170149.7639-1-bvanassche@acm.org>
 <20240509170149.7639-3-bvanassche@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8df3fd04-08ef-7aab-77d0-a919a09838a0@huaweicloud.com>
Date: Sat, 7 Dec 2024 10:17:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240509170149.7639-3-bvanassche@acm.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4cwsFNnNYuGDw--.56808S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr45Gw4fCFyfuF17Ww48Zwb_yoW5KF4DpF
	4UJa12kr48JF1v9a1Fy39xurn5uw4furyfXF1aqw1Skr98Xan7XFn5tFW5ZFy2vrWxGa1j
	gr4DXwn8GwnFqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Bart

ÔÚ 2024/05/10 1:01, Bart Van Assche Ð´µÀ:
> The current tag reservation code is based on a misunderstanding of the
> meaning of data->shallow_depth. Fix the tag reservation code as follows:
> * By default, do not reserve any tags for synchronous requests because
>    for certain use cases reserving tags reduces performance. See also
>    Harshit Mogalapalli, [bug-report] Performance regression with fio
>    sequential-write on a multipath setup, 2024-03-07
>    (https://lore.kernel.org/linux-block/5ce2ae5d-61e2-4ede-ad55-551112602401@oracle.com/)
> * Reduce min_shallow_depth to one because min_shallow_depth must be less
>    than or equal any shallow_depth value.
> * Scale dd->async_depth from the range [1, nr_requests] to [1,
>    bits_per_sbitmap_word].
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags for synchronous requests")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 94eede4fb9eb..acdc28756d9d 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -487,6 +487,20 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	return rq;
>   }
>   
> +/*
> + * 'depth' is a number in the range 1..INT_MAX representing a number of
> + * requests. Scale it with a factor (1 << bt->sb.shift) / q->nr_requests since
> + * 1..(1 << bt->sb.shift) is the range expected by sbitmap_get_shallow().
> + * Values larger than q->nr_requests have the same effect as q->nr_requests.
> + */
> +static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int qdepth)
> +{
> +	struct sbitmap_queue *bt = &hctx->sched_tags->bitmap_tags;
> +	const unsigned int nrr = hctx->queue->nr_requests;
> +
> +	return ((qdepth << bt->sb.shift) + nrr - 1) / nrr;
> +}
> +
>   /*
>    * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
>    * function is used by __blk_mq_get_tag().
> @@ -503,7 +517,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
>   	 * Throttle asynchronous requests and writes such that these requests
>   	 * do not block the allocation of synchronous requests.
>   	 */
> -	data->shallow_depth = dd->async_depth;
> +	data->shallow_depth = dd_to_word_depth(data->hctx, dd->async_depth);
>   }
>   
>   /* Called by blk_mq_update_nr_requests(). */
> @@ -513,9 +527,9 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
>   	struct deadline_data *dd = q->elevator->elevator_data;
>   	struct blk_mq_tags *tags = hctx->sched_tags;
>   
> -	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
> +	dd->async_depth = q->nr_requests;

We're comparing v6.6 and v5.10 performance in downstream kernel, we
met a regression and bisect to this patch. And during review, I don't
understand the above change.

For example, dd->async_depth is nr_requests, then dd_to_word_depth()
will just return 1 << bt->sb.shift. Then nothing will be throttled.

The regression is a corner test case that unlikely to happen in real
world, I can share more if you're interested.

Thanks,
Kuai

>   
> -	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
> +	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
>   }
>   
>   /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
> 
> .
> 

