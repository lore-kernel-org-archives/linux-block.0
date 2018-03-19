Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:41572 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754258AbeCSCek (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 22:34:40 -0400
From: tang.junhui@zte.com.cn
To: colyli@suse.de
Cc: mlyle@lyle.org, linux-block@vger.kernel.org,
        linux-bcache@vger.kernel.org, tang.junhui@zte.com.cn
Subject: Re: [PATCH] bache: put all the sorted bucket in heap into thefree_inc queue
Date: Mon, 19 Mar 2018 10:39:05 +0800
Message-Id: <1521427145-16511-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Coly

Thanks for your response. I modify this code because I find some times
buckets would run out of during GC. I need more buckets to be used.

>On 17/03/2018 4:58 PM, tang.junhui@zte.com.cn wrote:
>> From: Tang Junhui <tang.junhui@zte.com.cn>
>> 
>> We make a lot of effort to sort buckets in heap, but we only pull
>> half of buckets into free_inc queue, it's too wasteful.
>> 
>> And in incremental GC, we may run out of all buckets in free_inc
>> queue during GC, so it would be useful if we have more buckets
>> in free_inc queue.
>> 
>> This patch enlarge the size of free_inc queue as much as the heap.
>> 
>> Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
>> ---
>>  drivers/md/bcache/super.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index b4d2892..6f428c0 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -1835,7 +1835,7 @@ static int cache_alloc(struct cache *ca)
>>          !init_fifo_exact(&ca->free[RESERVE_PRIO], prio_buckets(ca), GFP_KERNEL) ||
>>          !init_fifo(&ca->free[RESERVE_MOVINGGC], free, GFP_KERNEL) ||
>>          !init_fifo(&ca->free[RESERVE_NONE], free, GFP_KERNEL) ||
>> -        !init_fifo(&ca->free_inc,    free << 2, GFP_KERNEL) ||
>> +        !init_fifo(&ca->free_inc,    free << 3, GFP_KERNEL) ||
>>          !init_heap(&ca->heap,    free << 3, GFP_KERNEL) ||
>>          !(ca->buckets    = vzalloc(sizeof(struct bucket) *
>>                        ca->sb.nbuckets)) ||
>> 
>
>Hi Junhui,
>
>I feel the original code might be better. ca->heap is not a strict
>ordered list, it just makes sure at some location in the heap list, all
>prios before this location are larger than all prios after this location.
>
Can we make sure that all the prios of buckets in the heap are smaller 
than the rest of buckets? If so, I think we can reclaime those buckets. 

>If ca->heap is x2 size of ca->free_inc, it means there is chance to
>invalidate 50% buckets of higher prios. And the buckets with lower prios
>can still stay in ca->heap until they have chance to be selected.
>
Yes, but why we sort them this time, but not the next time? since in 
the next time they would be sorted again

>If ca->free_inc is set to same size as ca->heap, we need to know that
>not all buckets in ca->heap can be invalidated, so after iterating all
>buckets in ca->heap, maybe we can not make ca->free_inc to be full. In
>this case, gc thread needs to be waken up. This will be a bug because it
>is very probably that not all buckets from ca->heap can be pushed into
>ca->free_inc, then gc thread is just frequently waken up for nothing.
I don't think so. All buckets are sorted into heap can be invalidated,
because we check them first before putting them into heap, see code:
	for_each_bucket(b, ca) {
		if (!bch_can_invalidate_bucket(ca, b))
			continue;

		if (!heap_full(&ca->heap))
			heap_add(&ca->heap, b, bucket_max_cmp);
		else if (bucket_max_cmp(b, heap_peek(&ca->heap))) {
			ca->heap.data[0] = b;
			heap_sift(&ca->heap, 0, bucket_max_cmp);
		}
	}

Thanks.

Tang Junhui
