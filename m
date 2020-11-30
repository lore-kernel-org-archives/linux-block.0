Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CF4C5519F
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 07:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5DC206ED
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 07:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgK3HFP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 02:05:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:36092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgK3HFO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 02:05:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 145BAAC8F;
        Mon, 30 Nov 2020 07:04:33 +0000 (UTC)
Subject: Re: [PATCH V1] block: Fix use-after-free while iterating over
 requests
To:     John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Pradeep P V K <ppvk@codeaurora.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     stummala@codeaurora.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <1606402925-24420-1-git-send-email-ppvk@codeaurora.org>
 <c94fcada-7f6d-a1e3-4c88-d225af1a676e@acm.org>
 <693ea723-aa9e-1166-8a19-a7787f724969@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0c925db8-e481-5f21-b0fe-f691142b0437@suse.de>
Date:   Mon, 30 Nov 2020 08:04:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <693ea723-aa9e-1166-8a19-a7787f724969@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/20 5:49 PM, John Garry wrote:
> On 26/11/2020 16:27, Bart Van Assche wrote:
>> On 11/26/20 7:02 AM, Pradeep P V K wrote:
>>> Observes below crash while accessing (use-after-free) request queue
>>> member of struct request.
>>>
>>> 191.784789:   <2> Unable to handle kernel paging request at virtual
>>> address ffffff81429a4440
>>> ...
>>> 191.786174:   <2> CPU: 3 PID: 213 Comm: kworker/3:1H Tainted: G S
>>> O      5.4.61-qgki-debug-ge45de39 #1
>>> ...
>>> 191.786226:   <2> Workqueue: kblockd blk_mq_timeout_work
>>> 191.786242:   <2> pstate: 20c00005 (nzCv daif +PAN +UAO)
>>> 191.786261:   <2> pc : bt_for_each+0x114/0x1a4
>>> 191.786274:   <2> lr : bt_for_each+0xe0/0x1a4
>>> ...
>>> 191.786494:   <2> Call trace:
>>> 191.786507:   <2>  bt_for_each+0x114/0x1a4
>>> 191.786519:   <2>  blk_mq_queue_tag_busy_iter+0x60/0xd4
>>> 191.786532:   <2>  blk_mq_timeout_work+0x54/0xe8
>>> 191.786549:   <2>  process_one_work+0x2cc/0x568
>>> 191.786562:   <2>  worker_thread+0x28c/0x518
>>> 191.786577:   <2>  kthread+0x160/0x170
>>> 191.786594:   <2>  ret_from_fork+0x10/0x18
>>> 191.786615:   <2> Code: 0b080148 f9404929 f8685921 b4fffe01 (f9400028)
>>> 191.786630:   <2> ---[ end trace 0f1f51d79ab3f955 ]---
>>> 191.786643:   <2> Kernel panic - not syncing: Fatal exception
>>>
>>> Fix this by updating the freed request with NULL.
>>> This could avoid accessing the already free request from other
>>> contexts while iterating over the requests.
>>>
>>> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
>>> ---
>>>   block/blk-mq.c | 1 +
>>>   block/blk-mq.h | 1 +
>>>   2 files changed, 2 insertions(+)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 55bcee5..9996cb1 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -492,6 +492,7 @@ static void __blk_mq_free_request(struct request 
>>> *rq)
>>>       blk_crypto_free_request(rq);
>>>       blk_pm_mark_last_busy(rq);
>>> +    hctx->tags->rqs[rq->tag] = NULL;
>>>       rq->mq_hctx = NULL;
>>>       if (rq->tag != BLK_MQ_NO_TAG)
>>>           blk_mq_put_tag(hctx->tags, ctx, rq->tag);
>>> diff --git a/block/blk-mq.h b/block/blk-mq.h
>>> index a52703c..8747bf1 100644
>>> --- a/block/blk-mq.h
>>> +++ b/block/blk-mq.h
>>> @@ -224,6 +224,7 @@ static inline int __blk_mq_active_requests(struct 
>>> blk_mq_hw_ctx *hctx)
>>>   static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
>>>                          struct request *rq)
>>>   {
>>> +    hctx->tags->rqs[rq->tag] = NULL;
>>>       blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
>>>       rq->tag = BLK_MQ_NO_TAG;
>>
>> Is this perhaps a block driver bug instead of a block layer core bug? If
>> this would be a block layer core bug, it would have been reported before.
> 
> Isn't this the same issue which as been reported many times:
> 
> https://lore.kernel.org/linux-block/20200820180335.3109216-1-ming.lei@redhat.com/ 
> 
> 
> https://lore.kernel.org/linux-block/8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com/ 
> 
> 
> But I never saw a crash, just kasan report.
> 
And if that above were a concern, I would have thought one would need to 
use a WRITE_ONCE() here; otherwise we might have a race condition where 
other CPUs still see the old value, no?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
