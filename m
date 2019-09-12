Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E21C49ED6
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 03:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0042214AF
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 03:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfILD33 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 23:29:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2266 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726699AbfILD33 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 23:29:29 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B6B12D49C1F8AE5BB4F0;
        Thu, 12 Sep 2019 11:29:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 12 Sep 2019
 11:29:19 +0800
Subject: Re: [PATCH] block: fix null pointer dereference in
 blk_mq_rq_timed_out()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <hch@infradead.org>, <keith.busch@intel.com>, <tj@kernel.org>,
        <zhangxiaoxu5@huawei.com>
References: <20190907102450.40291-1-yuyufen@huawei.com>
 <20190912024618.GE2731@ming.t460p>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <b3d7b459-5f31-d473-2508-20048119c1b2@huawei.com>
Date:   Thu, 12 Sep 2019 11:29:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190912024618.GE2731@ming.t460p>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/9/12 10:46, Ming Lei wrote:
> On Sat, Sep 07, 2019 at 06:24:50PM +0800, Yufen Yu wrote:
>> There is a race condition between timeout check and completion for
>> flush request as follow:
>>
>> timeout_work    issue flush      issue flush
>>                  blk_insert_flush
>>                                   blk_insert_flush
>> blk_mq_timeout_work
>>                  blk_kick_flush
>>
>> blk_mq_queue_tag_busy_iter
>> blk_mq_check_expired(flush_rq)
>>
>>                  __blk_mq_end_request
>>                 flush_end_io
>>                 blk_kick_flush
>>                 blk_rq_init(flush_rq)
>>                 memset(flush_rq, 0)
> Not see there is memset(flush_rq, 0) in block/blk-flush.c

Call path as follow:

blk_kick_flush
     blk_rq_init
         memset(rq, 0, sizeof(*rq));

>> blk_mq_timed_out
>> BUG_ON flush_rq->q->mq_ops
> flush_rq->q won't be changed by blk_rq_init(), and either READ or WRITE
> on variable with machine WORD length are atomic, so how can the BUG_ON()
> be triggered? Do you have the actual BUG log?
>
> Also now it is driver's responsibility for avoiding race between normal
> completion and timeout.

I have reproduced the bug by adding time delay in timeout handle and memset.
BUG_ON log as follow:

[  108.825472] BUG: kernel NULL pointer dereference, address: 
0000000000000040
[  108.826091] #PF: supervisor read access in kernel mode
[  108.826543] #PF: error_code(0x0000) - not-present page
[  108.827059] PGD 0 P4D 0
[  108.827313] Oops: 0000 [#1] SMP PTI
[  108.827657] CPU: 6 PID: 198 Comm: kworker/6:1H Not tainted 5.3.0-rc8+ 
#431
[  108.828326] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
[  108.829503] Workqueue: kblockd blk_mq_timeout_work
[  108.829913] RIP: 0010:blk_mq_check_expired+0x258/0x330
[  108.830439] Code: 01 e9 0a ff ff ff 48 83 05 34 45 dd 02 01 4c 39 63 
40 0f 84 8a 00 00 00 0d 00 00 20 00 40 0f b6 f5 41 89 44 24 1c 49 8b 04 
24 <48> 8b 40 40 48 8b 40 20 48 85 c0 0f 84 90 00 00 00 48 83 05 2f 44
[  108.832246] RSP: 0018:ffffbf7ac18b7db0 EFLAGS: 00010206
[  108.832756] RAX: 0000000000000000 RBX: ffffffffb56e0250 RCX: 
0000000000000000
[  108.833444] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffff9ab7fbb96538
[  108.834149] RBP: 0000000000000000 R08: 000000000000024b R09: 
0000000000000030
[  108.834840] R10: 000000000000004e R11: ffffbf7ac18b7c40 R12: 
ffff9ab7f756e000
[  108.835531] R13: ffffbf7ac18b7e70 R14: 0000000000000017 R15: 
ffff9ab7f6ead0a0
[  108.836228] FS:  0000000000000000(0000) GS:ffff9ab7fbb80000(0000) 
knlGS:0000000000000000
[  108.837026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  108.837588] CR2: 0000000000000040 CR3: 000000013544c000 CR4: 
00000000000006e0
[  108.838191] Call Trace:
[  108.838406]  bt_iter+0x74/0x80
[  108.838665]  blk_mq_queue_tag_busy_iter+0x204/0x450
[  108.839074]  ? __switch_to_asm+0x34/0x70
[  108.839405]  ? blk_mq_stop_hw_queue+0x40/0x40
[  108.839823]  ? blk_mq_stop_hw_queue+0x40/0x40
[  108.840273]  ? syscall_return_via_sysret+0xf/0x7f
[  108.840732]  blk_mq_timeout_work+0x74/0x200
[  108.841151]  process_one_work+0x297/0x680
[  108.841550]  worker_thread+0x29c/0x6f0
[  108.841926]  ? rescuer_thread+0x580/0x580
[  108.842344]  kthread+0x16a/0x1a0
[  108.842666]  ? kthread_flush_work+0x170/0x170
[  108.843100]  ret_from_fork+0x35/0x40
[  108.843455] Modules linked in:
[  108.843758] CR2: 0000000000000040
[  108.844090] ---[ end trace e0ac552505fa1b95 ]---

blk_mq_rq_timed_out() attempt to read 'req->q->mq_ops->timeout', but 'q 
== 0' currently,
which triggers BUG_ON.

>> For normal request, we need to get a tag and then allocate corresponding request.
>> Thus, the request cannot be reallocated before the tag have been free.
>> Commit 1d9bd5161ba ("blk-mq: replace timeout synchronization with a RCU and
>> generation based scheme") and commit 12f5b93145 ("blk-mq: Remove generation
>> seqeunce") can guarantee the consistency of timeout handle and completion.
>>
>> However, 'flush_rq' have been forgotten. 'flush_rq' allocation management
>> dependents on flush implemention mechanism. Each hctx has only one 'flush_rq'.
>> When a flush request have completed, the next flush request will hold the 'flush_rq'.
>> In the end, timeout handle may access the cleared 'flush_rq'.
>>
>> We fix this problem by checking request refcount 'rq->ref', as normal request.
>> If the refcount is not zero, flush_end_io() return and wait the last holder
>> recall it. To record the request status, we add a new entry 'rq_status',
>> which will be used in flush_end_io().
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
>> ---
>>   block/blk-flush.c      | 8 ++++++++
>>   block/blk-mq.c         | 7 +++++--
>>   block/blk.h            | 5 +++++
>>   include/linux/blkdev.h | 2 ++
>>   4 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-flush.c b/block/blk-flush.c
>> index aedd9320e605..359a7e1a0925 100644
>> --- a/block/blk-flush.c
>> +++ b/block/blk-flush.c
>> @@ -212,6 +212,14 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>>   	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
>>   	struct blk_mq_hw_ctx *hctx;
>>   
>> +	if (!refcount_dec_and_test(&flush_rq->ref)) {
>> +		flush_rq->rq_status = error;
>> +		return;
>> +	}
>> +
>> +	if (flush_rq->rq_status != BLK_STS_OK)
>> +		error = flush_rq->rq_status;
>> +
>>   	/* release the tag's ownership to the req cloned from */
>>   	spin_lock_irqsave(&fq->mq_flush_lock, flags);
>>   	hctx = flush_rq->mq_hctx;
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 0835f4d8d42e..3d2b2c2e9cdf 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -905,9 +905,12 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
>>   	 */
>>   	if (blk_mq_req_expired(rq, next))
>>   		blk_mq_rq_timed_out(rq, reserved);
>> -	if (refcount_dec_and_test(&rq->ref))
>> -		__blk_mq_free_request(rq);
>>   
>> +	if (is_flush_rq(rq, hctx)) {
>> +		rq->end_io(rq, 0);
>> +	} else if (refcount_dec_and_test(&rq->ref)) {
>> +		__blk_mq_free_request(rq);
>> +	}
>>   	return true;
>>   }
>>   
>> diff --git a/block/blk.h b/block/blk.h
>> index de6b2e146d6e..f503ef9ad3e6 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -47,6 +47,11 @@ static inline void __blk_get_queue(struct request_queue *q)
>>   	kobject_get(&q->kobj);
>>   }
>>   
>> +static inline bool
>> +is_flush_rq(struct request *req, struct blk_mq_hw_ctx *hctx) {
>> +	return hctx->fq->flush_rq == req;
>> +}
>> +
>>   struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
>>   		int node, int cmd_size, gfp_t flags);
>>   void blk_free_flush_queue(struct blk_flush_queue *q);
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 1ef375dafb1c..b1d05077e03f 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -237,6 +237,8 @@ struct request {
>>   	 */
>>   	rq_end_io_fn *end_io;
>>   	void *end_io_data;
>> +
>> +	blk_status_t rq_status;
>>   };
> 'rq_status' is only for flush request, so it may be added to 'struct
> blk_flush_queue' instead of 'struct request'.

That's a good idea.

Thanks,
Yufen

