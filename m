Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD53398A;
	Wed, 18 Dec 2024 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485658; cv=none; b=EhajnpVxV8AVrMhIYTjnJUGHR8ltrNnWsKDAmExFx/qZAxUrMulNUd29zCw1hCMjUS5/rYASUlKjYCjDsie8mO05yzfb/6K3yOEi5+6nbSTn7MsHGN60a6ZqrAFF4lv6QMVvE4XARIuSNwHfbjP6iT8FpXC1YdOT4KuerGiwheA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485658; c=relaxed/simple;
	bh=XhAZ5geuVVdsiME21rzxCfeZPMQDqFJa2hXhlUX0RKY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oKscPmSUk+BbhX52i5moRQ6mNiH6KhbgtAszeZT519xsXOA11TEN8HsRZyfCifomGhMZJxmEa+t0e5VB5/GzfvICSsJ/l/aIu5MxY+fu5037qf2xEr2kKQuCm/HwJt8/na4fdjzKKj+cKQk2aOGxjSA3Qosiz7YIMagRkzGADCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YCbNR65GCz4f3jdP;
	Wed, 18 Dec 2024 09:16:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5517C1A018D;
	Wed, 18 Dec 2024 09:16:27 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgB3noJqImJnl06iEw--.62098S3;
	Wed, 18 Dec 2024 09:16:27 +0800 (CST)
Subject: Re: [PATCH RFC v2 1/4] block/mq-deadline: Revert "block/mq-deadline:
 Fix the tag reservation code"
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, akpm@linux-foundation.org, ming.lei@redhat.com,
 yang.yang@vivo.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-2-yukuai1@huaweicloud.com>
 <7e26bf70-3ff3-4cf0-870e-9d0d9c35491b@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9809ecdd-9190-cbd9-4397-5c1f718a9f15@huaweicloud.com>
Date: Wed, 18 Dec 2024 09:16:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7e26bf70-3ff3-4cf0-870e-9d0d9c35491b@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3noJqImJnl06iEw--.62098S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4DXFWktr43GF1rAF4ktFb_yoW5try7pa
	yrAanFkrW5JF1v9r18J3yDZry8tw43Xw13XF1Yq3WFkrWDZF4qqF4FqFWY9FWxZrWkGa1U
	KF4DXr9xZ3ZrZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/18 5:39, Bart Van Assche 写道:
> On 12/16/24 6:40 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> This reverts commit 39823b47bbd40502632ffba90ebb34fff7c8b5e8.
>>
>> 1) Set min_shallow_depth to 1 will end up setting wake_batch to 1,
>>     and this will cause performance degradation in some high concurrency
>>     test, for both IO bandwidth and cpu usage.
>>
>>     async_depth can be changed by sysfs, and the minimal value is 1. This
>>     is why min_shallow_depth is set to 1 at initialization to make sure
>>     functional is correct if async_depth is set to 1. However, sacrifice
>>     performance in the default scenario is not acceptable.
>>
>> 2) dd_to_word_depth() is supposed to scale down async_depth, however, 
>> user
>>     can set low nr_requests and sb->depth can be less than 1 << 
>> sb->shift,
>>     then dd_to_word_depth() will end up scale up async_depth.
> 
> Although this patch fixes a performance regression, it breaks the
> async_depth functionality. If we are going to break that functionality
> temporarily, I propose to do something like this:

Yes, I'll split this patch, and merge the async_depth changes into the
last patch.

Thanks,
Kuai

> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 20a8a3afb88b..4cc7b5db4669 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -487,37 +487,12 @@ static struct request *dd_dispatch_request(struct 
> blk_mq_hw_ctx *hctx)
>       return rq;
>   }
> 
> -/*
> - * 'depth' is a number in the range 1..INT_MAX representing a number of
> - * requests. Scale it with a factor (1 << bt->sb.shift) / 
> q->nr_requests since
> - * 1..(1 << bt->sb.shift) is the range expected by sbitmap_get_shallow().
> - * Values larger than q->nr_requests have the same effect as 
> q->nr_requests.
> - */
> -static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int 
> qdepth)
> -{
> -    struct sbitmap_queue *bt = &hctx->sched_tags->bitmap_tags;
> -    const unsigned int nrr = hctx->queue->nr_requests;
> -
> -    return ((qdepth << bt->sb.shift) + nrr - 1) / nrr;
> -}
> -
>   /*
>    * Called by __blk_mq_alloc_request(). The shallow_depth value set by 
> this
>    * function is used by __blk_mq_get_tag().
>    */
>   static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
>   {
> -    struct deadline_data *dd = data->q->elevator->elevator_data;
> -
> -    /* Do not throttle synchronous reads. */
> -    if (op_is_sync(opf) && !op_is_write(opf))
> -        return;
> -
> -    /*
> -     * Throttle asynchronous requests and writes such that these requests
> -     * do not block the allocation of synchronous requests.
> -     */
> -    data->shallow_depth = dd_to_word_depth(data->hctx, dd->async_depth);
>   }
> 
>   /* Called by blk_mq_update_nr_requests(). */
> @@ -525,11 +500,8 @@ static void dd_depth_updated(struct blk_mq_hw_ctx 
> *hctx)
>   {
>       struct request_queue *q = hctx->queue;
>       struct deadline_data *dd = q->elevator->elevator_data;
> -    struct blk_mq_tags *tags = hctx->sched_tags;
> 
>       dd->async_depth = q->nr_requests;
> -
> -    sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
>   }
> 
>   /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
> 
> .
> 

