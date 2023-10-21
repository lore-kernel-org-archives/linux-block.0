Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E809CC001E0
	for <linux-block@archiver.kernel.org>; Sat, 21 Oct 2023 07:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjJUHdC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Oct 2023 03:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUHdB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Oct 2023 03:33:01 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E9C1BF
        for <linux-block@vger.kernel.org>; Sat, 21 Oct 2023 00:32:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SCCpq0Cfyz4f3lVd
        for <linux-block@vger.kernel.org>; Sat, 21 Oct 2023 15:32:51 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3gtKifjNlq0soDg--.60305S3;
        Sat, 21 Oct 2023 15:32:51 +0800 (CST)
Subject: Re: [PATCH] block: Improve shared tag set performance
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20231018180056.2151711-1-bvanassche@acm.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <31ca731b-7ffb-185a-fdbc-9e4821e2b46f@huaweicloud.com>
Date:   Sat, 21 Oct 2023 15:32:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20231018180056.2151711-1-bvanassche@acm.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3gtKifjNlq0soDg--.60305S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1kJF45trWDtr1fKFW7Arb_yoW7Gr1kpF
        Wfta12kw1xtr4UuayxtanxuF1F9wsxGrn8J3WSq34Fvr1a9rs7XFnY9rWFvryFvrZ5CF42
        qr4jyry5Aws8W37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ÔÚ 2023/10/19 2:00, Bart Van Assche Ð´µÀ:
> Remove the code for fair tag sharing because it significantly hurts
> performance for UFS devices. Removing this code is safe because the
> legacy block layer worked fine without any equivalent fairness
> algorithm.
> 
> This algorithm hurts performance for UFS devices because UFS devices
> have multiple logical units. One of these logical units (WLUN) is used
> to submit control commands, e.g. START STOP UNIT. If any request is
> submitted to the WLUN, the queue depth is reduced from 31 to 15 or
> lower for data LUNs.
> 
> See also https://lore.kernel.org/linux-scsi/20221229030645.11558-1-ed.tsai@mediatek.com/
> 
> Note: it has been attempted to rework this algorithm. See also "[PATCH
> RFC 0/7] blk-mq: improve tag fair sharing"
> (https://lore.kernel.org/linux-block/20230618160738.54385-1-yukuai1@huaweicloud.com/).
> Given the complexity of that patch series, I do not expect that patch
> series to be merged.

Sorry for such huge delay, I was struggled on implementing a smoothly
algorithm to borrow tags and return borrowed tags, and later I put this
on ice and focus on other stuff.

I had an idea to implement a state machine, however, the amount of code
was aggressive and I gave up. And later, I implemented a simple version,
and I tested it in your case, 32 tags and 2 shared node, result looks
good(see below), however, I'm not confident this can work well general.

Anyway, I'll send a new RFC verion for this, and please let me know if
you still think this approch is unacceptable.

Thanks,
Kuai

Test script:

[global]
ioengine=libaio
iodepth=2
bs=4k
direct=1
rw=randrw
group_reporting

[sda]
numjobs=32
filename=/dev/sda

[sdb]
numjobs=1
filename=/dev/sdb

Test result, by monitor new debugfs entry shared_tag_info:
time	active		available
	sda 	sdb	sda	sdb
0	0	0	32	32
1	16	2	16	16	-> start fair sharing
2	19	2	20	16
3	24	2	24	16
4	26	2	28	16 	-> borrow 32/8=4 tags each round
5	28	2	28	16	-> save at lease 4 tags for sdb
...
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Yu Kuai <yukuai1@huaweicloud.com>
> Cc: Ed Tsai <ed.tsai@mediatek.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-mq-tag.c |  4 ----
>   block/blk-mq.c     |  3 ---
>   block/blk-mq.h     | 39 ---------------------------------------
>   3 files changed, 46 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index cc57e2dd9a0b..25334bfcabf8 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -105,10 +105,6 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>   static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
>   			    struct sbitmap_queue *bt)
>   {
> -	if (!data->q->elevator && !(data->flags & BLK_MQ_REQ_RESERVED) &&
> -			!hctx_may_queue(data->hctx, bt))
> -		return BLK_MQ_NO_TAG;
> -
>   	if (data->shallow_depth)
>   		return sbitmap_queue_get_shallow(bt, data->shallow_depth);
>   	else
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e2d11183f62e..502dafa76716 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1760,9 +1760,6 @@ bool __blk_mq_alloc_driver_tag(struct request *rq)
>   	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
>   		bt = &rq->mq_hctx->tags->breserved_tags;
>   		tag_offset = 0;
> -	} else {
> -		if (!hctx_may_queue(rq->mq_hctx, bt))
> -			return false;
>   	}
>   
>   	tag = __sbitmap_queue_get(bt);
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index f75a9ecfebde..14a22f6d3fdf 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -407,45 +407,6 @@ static inline void blk_mq_free_requests(struct list_head *list)
>   	}
>   }
>   
> -/*
> - * For shared tag users, we track the number of currently active users
> - * and attempt to provide a fair share of the tag depth for each of them.
> - */
> -static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
> -				  struct sbitmap_queue *bt)
> -{
> -	unsigned int depth, users;
> -
> -	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
> -		return true;
> -
> -	/*
> -	 * Don't try dividing an ant
> -	 */
> -	if (bt->sb.depth == 1)
> -		return true;
> -
> -	if (blk_mq_is_shared_tags(hctx->flags)) {
> -		struct request_queue *q = hctx->queue;
> -
> -		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> -			return true;
> -	} else {
> -		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> -			return true;
> -	}
> -
> -	users = READ_ONCE(hctx->tags->active_queues);
> -	if (!users)
> -		return true;
> -
> -	/*
> -	 * Allow at least some tags
> -	 */
> -	depth = max((bt->sb.depth + users - 1) / users, 4U);
> -	return __blk_mq_active_requests(hctx) < depth;
> -}
> -
>   /* run the code block in @dispatch_ops with rcu/srcu read lock held */
>   #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
>   do {								\
> 
> .
> 

