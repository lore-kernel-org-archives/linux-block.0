Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E79C64E8A
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 14:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C5120719
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 14:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgK3OzY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:55:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2178 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgK3OzY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 09:55:24 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cl7VD4LYpz67KcS;
        Mon, 30 Nov 2020 22:51:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 30 Nov 2020 15:54:40 +0100
Received: from [10.47.3.199] (10.47.3.199) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 30 Nov
 2020 14:54:38 +0000
Subject: Re: [PATCH V1] block: Fix use-after-free while iterating over
 requests
To:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Pradeep P V K <ppvk@codeaurora.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
CC:     <stummala@codeaurora.org>, <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
References: <1606402925-24420-1-git-send-email-ppvk@codeaurora.org>
 <c94fcada-7f6d-a1e3-4c88-d225af1a676e@acm.org>
 <693ea723-aa9e-1166-8a19-a7787f724969@huawei.com>
 <0c925db8-e481-5f21-b0fe-f691142b0437@suse.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <de707ecc-b34c-93d4-522e-79632eaa9d8a@huawei.com>
Date:   Mon, 30 Nov 2020 14:54:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <0c925db8-e481-5f21-b0fe-f691142b0437@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.3.199]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/11/2020 07:04, Hannes Reinecke wrote:
> On 11/26/20 5:49 PM, John Garry wrote:
>> On 26/11/2020 16:27, Bart Van Assche wrote:
>>> On 11/26/20 7:02 AM, Pradeep P V K wrote:
>>>> Observes below crash while accessing (use-after-free) request queue
>>>> member of struct request.
>>>>
>>>> 191.784789:   <2> Unable to handle kernel paging request at virtual
>>>> address ffffff81429a4440
>>>> ...
>>>> 191.786174:   <2> CPU: 3 PID: 213 Comm: kworker/3:1H Tainted: G S
>>>> O      5.4.61-qgki-debug-ge45de39 #1
>>>> ...
>>>> 191.786226:   <2> Workqueue: kblockd blk_mq_timeout_work
>>>> 191.786242:   <2> pstate: 20c00005 (nzCv daif +PAN +UAO)
>>>> 191.786261:   <2> pc : bt_for_each+0x114/0x1a4
>>>> 191.786274:   <2> lr : bt_for_each+0xe0/0x1a4
>>>> ...
>>>> 191.786494:   <2> Call trace:
>>>> 191.786507:   <2>  bt_for_each+0x114/0x1a4
>>>> 191.786519:   <2>  blk_mq_queue_tag_busy_iter+0x60/0xd4
>>>> 191.786532:   <2>  blk_mq_timeout_work+0x54/0xe8
>>>> 191.786549:   <2>  process_one_work+0x2cc/0x568
>>>> 191.786562:   <2>  worker_thread+0x28c/0x518
>>>> 191.786577:   <2>  kthread+0x160/0x170
>>>> 191.786594:   <2>  ret_from_fork+0x10/0x18
>>>> 191.786615:   <2> Code: 0b080148 f9404929 f8685921 b4fffe01 (f9400028)
>>>> 191.786630:   <2> ---[ end trace 0f1f51d79ab3f955 ]---
>>>> 191.786643:   <2> Kernel panic - not syncing: Fatal exception
>>>>
>>>> Fix this by updating the freed request with NULL.
>>>> This could avoid accessing the already free request from other
>>>> contexts while iterating over the requests.
>>>>
>>>> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
>>>> ---
>>>>   block/blk-mq.c | 1 +
>>>>   block/blk-mq.h | 1 +
>>>>   2 files changed, 2 insertions(+)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index 55bcee5..9996cb1 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -492,6 +492,7 @@ static void __blk_mq_free_request(struct request 
>>>> *rq)
>>>>       blk_crypto_free_request(rq);
>>>>       blk_pm_mark_last_busy(rq);
>>>> +    hctx->tags->rqs[rq->tag] = NULL;
>>>>       rq->mq_hctx = NULL;
>>>>       if (rq->tag != BLK_MQ_NO_TAG)
>>>>           blk_mq_put_tag(hctx->tags, ctx, rq->tag);
>>>> diff --git a/block/blk-mq.h b/block/blk-mq.h
>>>> index a52703c..8747bf1 100644
>>>> --- a/block/blk-mq.h
>>>> +++ b/block/blk-mq.h
>>>> @@ -224,6 +224,7 @@ static inline int 
>>>> __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
>>>>   static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx 
>>>> *hctx,
>>>>                          struct request *rq)
>>>>   {
>>>> +    hctx->tags->rqs[rq->tag] = NULL;
>>>>       blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
>>>>       rq->tag = BLK_MQ_NO_TAG;
>>>
>>> Is this perhaps a block driver bug instead of a block layer core bug? If
>>> this would be a block layer core bug, it would have been reported 
>>> before.
>>
>> Isn't this the same issue which as been reported many times:
>>
>> https://lore.kernel.org/linux-block/20200820180335.3109216-1-ming.lei@redhat.com/ 
>>
>>
>> https://lore.kernel.org/linux-block/8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com/ 
>>
>>
>> But I never saw a crash, just kasan report.
>>
> And if that above were a concern, I would have thought one would need to 
> use a WRITE_ONCE() here; otherwise we might have a race condition where 
> other CPUs still see the old value, no?
 From further looking at the history here, Kashyap tried the same 
approach and preference was to not add anything to the fast path:

https://lore.kernel.org/linux-block/04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk/

I had another solution for this which clears any references when we free 
the sched tags, but never posted as it looked a bit crazy and I was 
busy, below.

---->8------


diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a19cdf159b75..240804617683 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -608,7 +608,7 @@ static void blk_mq_sched_free_tags(struct 
blk_mq_tag_set *set,
  				   unsigned int hctx_idx)
  {
  	if (hctx->sched_tags) {
-		blk_mq_free_rqs(set, hctx->sched_tags, hctx_idx);
+		blk_mq_free_rqs(set, hctx->sched_tags, hctx_idx, NULL);
  		blk_mq_free_rq_map(hctx->sched_tags);
  		hctx->sched_tags = NULL;
  	}
@@ -711,10 +711,9 @@ void blk_mq_sched_free_requests(struct 
request_queue *q)
  {
  	struct blk_mq_hw_ctx *hctx;
  	int i;

  	queue_for_each_hw_ctx(q, hctx, i) {
-		if (hctx->sched_tags)
-			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i);
+			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i, hctx->tags);
  	}
  }

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 32d82e23b095..9622cef0c38d 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -515,7 +515,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
  			return -ENOMEM;
  		}

-		blk_mq_free_rqs(set, *tagsptr, hctx->queue_num);
+		blk_mq_free_rqs(set, *tagsptr, hctx->queue_num, NULL);
  		blk_mq_free_rq_map(*tagsptr);
  		*tagsptr = new;
  	} else {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0015a1892153..6ff815ceae34 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2256,12 +2256,12 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
  EXPORT_SYMBOL_GPL(blk_mq_submit_bio); /* only for request based dm */

  void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
-		     unsigned int hctx_idx)
+		     unsigned int hctx_idx, struct blk_mq_tags *references)
  {
  	struct page *page;

  	if (tags->rqs && set->ops->exit_request) {
-		int i;
+		int i, j;

  		for (i = 0; i < tags->nr_tags; i++) {
  			struct request *rq = tags->static_rqs[i];
@@ -2269,6 +2269,12 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, 
struct blk_mq_tags *tags,
  			if (!rq)
  				continue;
  			set->ops->exit_request(set, rq, hctx_idx);
+			for (j = 0; references && j < references->nr_tags; j++) {
+				struct request *old = cmpxchg(&references->rqs[j], rq, 0);
+			}
  			tags->static_rqs[i] = NULL;
  		}
  	}
@@ -2425,7 +2431,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, 
struct blk_mq_tags *tags,
  	return 0;

  fail:
-	blk_mq_free_rqs(set, tags, hctx_idx);
+	blk_mq_free_rqs(set, tags, hctx_idx, NULL);
  	return -ENOMEM;
  }

@@ -2755,7 +2761,7 @@ static void blk_mq_free_map_and_requests(struct 
blk_mq_tag_set *set,
  					 unsigned int hctx_idx)
  {
  	if (set->tags && set->tags[hctx_idx]) {
-		blk_mq_free_rqs(set, set->tags[hctx_idx], hctx_idx);
+		blk_mq_free_rqs(set, set->tags[hctx_idx], hctx_idx, NULL);
  		blk_mq_free_rq_map(set->tags[hctx_idx]);
  		set->tags[hctx_idx] = NULL;
  	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 863a2f3346d4..bee8c5de600b 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -52,7 +52,7 @@ struct request *blk_mq_dequeue_from_ctx(struct 
blk_mq_hw_ctx *hctx,
   * Internal helpers for allocating/freeing the request map
   */
  void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
-		     unsigned int hctx_idx);
+		     unsigned int hctx_idx, struct blk_mq_tags *references);
  void blk_mq_free_rq_map(struct blk_mq_tags *tags);
  struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
  					unsigned int hctx_idx,
