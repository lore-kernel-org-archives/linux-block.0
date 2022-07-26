Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CCDC43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 03:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiGZDOu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 23:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiGZDOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 23:14:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B362A42C
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 20:14:48 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LsMP916cKzWfGQ;
        Tue, 26 Jul 2022 11:10:53 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 11:14:25 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 11:14:24 +0800
Subject: Re: [PATCH] blk-mq: run queue after issuing the last request of the
 plug list
To:     Ming Lei <ming.lei@redhat.com>
CC:     Yu Kuai <yukuai1@huaweicloud.com>, Yufen Yu <yuyufen@huawei.com>,
        <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <hch@lst.de>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20220718123528.178714-1-yuyufen@huawei.com>
 <YtZ4uSRqR/kLdqm+@T590>
 <0baa5b04-7194-54fa-08a5-51425601343e@huaweicloud.com>
 <Yt66HebQ9//2ahq6@T590> <ab899ae0-91fc-48db-cc32-fdc57f61963a@huawei.com>
 <Yt9HkP2mzH0ZTL1l@T590> <ba2b30f2-66d9-3acb-787d-fae1894fa5a6@huawei.com>
 <Yt9SMuSlCtwwzyEz@T590> <f91f136c-f109-3027-a666-29fe882d3426@huawei.com>
 <Yt9ZOFtzm9kfKWhc@T590>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <6b070c7d-473a-cc96-def3-49826ca08aea@huawei.com>
Date:   Tue, 26 Jul 2022 11:14:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Yt9ZOFtzm9kfKWhc@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Ming

在 2022/07/26 11:02, Ming Lei 写道:
> On Tue, Jul 26, 2022 at 10:52:56AM +0800, Yu Kuai wrote:
>> Hi, Ming
>> 在 2022/07/26 10:32, Ming Lei 写道:
>>> On Tue, Jul 26, 2022 at 10:08:13AM +0800, Yu Kuai wrote:
>>>> 在 2022/07/26 9:46, Ming Lei 写道:
>>>>> On Tue, Jul 26, 2022 at 09:08:19AM +0800, Yu Kuai wrote:
>>>>>> Hi, Ming!
>>>>>>
>>>>>> 在 2022/07/25 23:43, Ming Lei 写道:
>>>>>>> On Sat, Jul 23, 2022 at 10:50:03AM +0800, Yu Kuai wrote:
>>>>>>>> Hi, Ming!
>>>>>>>>
>>>>>>>> 在 2022/07/19 17:26, Ming Lei 写道:
>>>>>>>>> On Mon, Jul 18, 2022 at 08:35:28PM +0800, Yufen Yu wrote:
>>>>>>>>>> We do test on a virtio scsi device (/dev/sda) and the default mq
>>>>>>>>>> scheduler is 'none'. We found a IO hung as following:
>>>>>>>>>>
>>>>>>>>>> blk_finish_plug
>>>>>>>>>>        blk_mq_plug_issue_direct
>>>>>>>>>>            scsi_mq_get_budget
>>>>>>>>>>            //get budget_token fail and sdev->restarts=1
>>>>>>>>>>
>>>>>>>>>> 			     	 scsi_end_request
>>>>>>>>>> 				   scsi_run_queue_async
>>>>>>>>>>                                         //sdev->restart=0 and run queue
>>>>>>>>>>
>>>>>>>>>>           blk_mq_request_bypass_insert
>>>>>>>>>>              //add request to hctx->dispatch list
>>>>>>>>>
>>>>>>>>> Here the issue shouldn't be related with scsi's get budget or
>>>>>>>>> scsi_run_queue_async.
>>>>>>>>>
>>>>>>>>> If blk-mq adds request into ->dispatch_list, it is blk-mq core's
>>>>>>>>> responsibility to re-run queue for moving on. Can you investigate a
>>>>>>>>> bit more why blk-mq doesn't run queue after adding request to
>>>>>>>>> hctx dispatch list?
>>>>>>>>
>>>>>>>> I think Yufen is probably thinking about the following Concurrent
>>>>>>>> scenario:
>>>>>>>>
>>>>>>>> blk_mq_flush_plug_list
>>>>>>>> # assume there are three rq
>>>>>>>>      blk_mq_plug_issue_direct
>>>>>>>>       blk_mq_request_issue_directly
>>>>>>>>       # dispatch rq1, succeed
>>>>>>>>       blk_mq_request_issue_directly
>>>>>>>>       # dispatch rq2
>>>>>>>>        __blk_mq_try_issue_directly
>>>>>>>>         blk_mq_get_dispatch_budget
>>>>>>>>          scsi_mq_get_budget
>>>>>>>>           atomic_inc(&sdev->restarts);
>>>>>>>>           # rq2 failed to get budget
>>>>>>>>           # restarts is 1 now
>>>>>>>>                                             scsi_end_request
>>>>>>>>                                             # rq1 is completed
>>>>>>>>                                             ┊scsi_run_queue_async
>>>>>>>>                                             ┊ atomic_cmpxchg(&sdev->restarts,
>>>>>>>> old, 0) == old
>>>>>>>>                                             ┊ # set restarts to 0
>>>>>>>>                                             ┊ blk_mq_run_hw_queues
>>>>>>>>                                             ┊ # hctx->dispatch list is empty
>>>>>>>>       blk_mq_request_bypass_insert
>>>>>>>>       # insert rq2 to hctx->dispatch list
>>>>>>>
>>>>>>> After rq2 is added to ->dispatch_list in blk_mq_try_issue_list_directly(),
>>>>>>> no matter if list_empty(list) is empty or not, queue will be run either from
>>>>>>> blk_mq_request_bypass_insert() or blk_mq_sched_insert_requests().
>>>>>>
>>>>>> 1) while inserting rq2 to dispatch list, blk_mq_request_bypass_insert()
>>>>>> is called from blk_mq_try_issue_list_directly(), list_empty() won't
>>>>>> pass, thus thus blk_mq_request_bypass_insert() won't run queue.
>>>>>
>>>>> Yeah, but in blk_mq_try_issue_list_directly() after rq2 is inserted to dispatch
>>>>> list, the loop is broken and blk_mq_try_issue_list_directly() returns to
>>>>> blk_mq_sched_insert_requests() in which list_empty() is false, so
>>>>> blk_mq_insert_requests() and blk_mq_run_hw_queue() are called, queue
>>>>> is still run.
>>>>>
>>>>> Also not sure why you make rq3 involved, since the list is local list on
>>>>> stack, and it can be operated concurrently.
>>>>
>>>> I make rq3 involved because there are some conditions that
>>>> blk_mq_insert_requests() and blk_mq_run_hw_queue() won't be called from
>>>> blk_mq_sched_insert_requests():
>>>
>>> The two won't be called if list_empty() is true, and will be called if
>>> !list_empty().
>>>
>>> That is why I mentioned run queue has been done after rq2 is added to
>>> ->dispatch_list.
>>
>> I don't follow here, it's right after rq2 is inserted to dispatch list,
>> list is not empty, and blk_mq_sched_insert_requests() will be called.
>> However, do you think that it's impossible that
>> blk_mq_sched_insert_requests() can dispatch rq in the list and list
>> will become empty?
> 
> Please take a look at blk_mq_sched_insert_requests().
> 
> When codes runs into blk_mq_sched_insert_requests(), the following
> blk_mq_run_hw_queue() will be run always, how does list empty or not
> make a difference there?

This is strange, always blk_mq_run_hw_queue() is exactly what Yufen
tries to do in this patch, are we look at different code?

I'm copying blk_mq_sched_insert_requests() here, the code is from
latest linux-next:

461 void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
462                                 ┊ struct blk_mq_ctx *ctx,
463                                 ┊ struct list_head *list, bool 
run_queue_async)
464 {
465         struct elevator_queue *e;
466         struct request_queue *q = hctx->queue;
467
468         /*
469         ┊* blk_mq_sched_insert_requests() is called from flush plug
470         ┊* context only, and hold one usage counter to prevent queue
471         ┊* from being released.
472         ┊*/
473         percpu_ref_get(&q->q_usage_counter);
474
475         e = hctx->queue->elevator;
476         if (e) {
477                 e->type->ops.insert_requests(hctx, list, false);
478         } else {
479                 /*
480                 ┊* try to issue requests directly if the hw queue isn't
481                 ┊* busy in case of 'none' scheduler, and this way 
may save
482                 ┊* us one extra enqueue & dequeue to sw queue.
483                 ┊*/
484                 if (!hctx->dispatch_busy && !run_queue_async) {
485                         blk_mq_run_dispatch_ops(hctx->queue,
486                                 blk_mq_try_issue_list_directly(hctx, 
list));
487                         if (list_empty(list))
488                                 goto out;
489                 }
490                 blk_mq_insert_requests(hctx, ctx, list);
491         }
492
493         blk_mq_run_hw_queue(hctx, run_queue_async);
494  out:
495         percpu_ref_put(&q->q_usage_counter);
496 }

Here in line 487, if list_empty() is true, out label will skip
run_queue().
> 
> In short, after rq2 is added into ->dispatch, the queue is guaranteed
> to run, the handling logic isn't wrong. That said that the reported
> hang isn't root caused yet, is it?
> 
> 
> Thanks,
> Ming
> 
> .
> 
