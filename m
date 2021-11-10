Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA75C433F5
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 07:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DCF61051
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 07:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhKJHg2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 02:36:28 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:27125 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhKJHg2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 02:36:28 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HpxNp5XvLz1DJJb;
        Wed, 10 Nov 2021 15:31:22 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 10 Nov 2021 15:33:36 +0800
Received: from [10.174.177.69] (10.174.177.69) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 10 Nov 2021 15:33:36 +0800
Message-ID: <3190660d-452e-690c-371f-e75744d37785@huawei.com>
Date:   Wed, 10 Nov 2021 15:33:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH -next] blk-mq: fix tag_get wait task can't be awakened
Content-Language: en-US
References: <dddba25b-82d3-39c7-a58d-9d2b1adda8ae@huawei.com>
To:     <ming.lei@redhat.com>, <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <martin.petersen@oracle.com>, <hare@suse.de>,
        <asml.silence@gmail.com>, <bvanassche@acm.org>
From:   QiuLaibin <qiulaibin@huawei.com>
In-Reply-To: <dddba25b-82d3-39c7-a58d-9d2b1adda8ae@huawei.com>
X-Forwarded-Message-Id: <dddba25b-82d3-39c7-a58d-9d2b1adda8ae@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.69]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Ming,

On 2021/09/26 20:48, Ming Lei wrote:
 > Hi Laibin,
 >
 > On Mon, Sep 13, 2021 at 04:12:48PM +0800, Laibin Qiu wrote:
 >> When multiple hctx share one tagset. The wake_batch is calculated
 >> during initialization by queue_depth. But when multiple hctx share one
 >> tagset. The queue depth assigned to each user may be smaller than
 >> wakeup_batch. This may cause the waiting queue to fail to wakup and
 >> leads to Hang.
 > In case of shared tags, there might be more than one hctx which 
allocates tag from single tags, and each hctx is limited to allocate at 
most:
 >
 > hctx_max_depth = max((bt->sb.depth + users - 1) / users, 4U);
 >
 > and
 >
 > users = atomic_read(&hctx->tags->active_queues)
 >
 > See hctx_may_queue().
 >
 > tag idle detection is lazy, and may be delayed for 30sec, so there 
could be just one real active hctx(queue) but all others are actually 
idle and still accounted as active because of the lazy idle detection. 
Then if wake_batch is > hctx_max_depth, driver tag allocation may wait 
forever on this real active hctx.
 >
 > Correct me if my understanding is wrong.

Your understanding is right. When we add lots of users for one shared 
tag, it will make wake_batch > hctx_max_dept. So driver tag allocation 
may wait forever on this real active hctx.

 >> Fix this by recalculating wake_batch when inc or dec active_queues.
 >>
 >> Fixes: 0d2602ca30e41 ("blk-mq: improve support for shared tags maps")
 >> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
 >> ---
 >> block/blk-mq-tag.c | 44 +++++++++++++++++++++++++++++++++++++++--
 >> include/linux/sbitmap.h | 8 ++++++++
 >> lib/sbitmap.c | 3 ++-
 >> 3 files changed, 52 insertions(+), 3 deletions(-)
 >>
 >> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c index
 >> 86f87346232a..d02f5ac0004c 100644
 >> --- a/block/blk-mq-tag.c
 >> +++ b/block/blk-mq-tag.c
 >> @@ -16,6 +16,27 @@
 >> #include "blk-mq-sched.h"
 >> #include "blk-mq-tag.h"
 >> +static void bt_update_wake_batch(struct sbitmap_queue *bt, unsigned
 >> +int users) {
 >> + unsigned int depth;
 >> +
 >> + depth = max((bt->sb.depth + users - 1) / users, 4U);
 >> + sbitmap_queue_update_wake_batch(bt, depth);
 > Use the hctx's max queue depth could reduce wake_batch a lot, then 
performance may be degraded.
 >
 > Just wondering why not set sbq->wake_batch as hctx_max_depth if
 > sbq->wake_batch is < hctx_max_depth?
 >

__blk_mq_tag_busy() will add Users and __blk_mq_tag_idle() will decrease 
Users. Only changes in Users will affect each user's max depth. So we 
recalculate the matching wake_batch by 
sbitmap_queue_update_wake_batch(). sbitmap_queue_update_wake_batch() 
will calculate wake_batch by incoming depth. The value of 
sbq->wake_batch will only be changed when the calculated wake_batch changes.

static void sbitmap_queue_update_wake_batch(struct sbitmap_queue *sbq,
                                             unsigned int depth)
{
         unsigned int wake_batch = sbq_calc_wake_batch(sbq, depth);
^^^^^^^^^^^^^^^^^
         int i;
         if (sbq->wake_batch != wake_batch) {
             ^^^^^^^^^^^^^^^^^^
                 WRITE_ONCE(sbq->wake_batch, wake_batch);
                 /*
                  * Pairs with the memory barrier in sbitmap_queue_wake_up()
                  * to ensure that the batch size is updated before the wait
                  * counts.
                  */
                 smp_mb();
                 for (i = 0; i < SBQ_WAIT_QUEUES; i++)
                         atomic_set(&sbq->ws[i].wait_cnt, 1);
         }
}

 >
 > Thanks,
 > Ming

Thanks
Laibin
