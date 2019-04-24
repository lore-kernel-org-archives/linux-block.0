Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03993C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 05:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB19C20685
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 05:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbfDXFzG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:55:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:38564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729244AbfDXFzG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 01:55:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B995BAD14;
        Wed, 24 Apr 2019 05:55:03 +0000 (UTC)
Subject: Re: [PATCH V6 6/9] blk-mq: always free hctx after request queue is
 freed
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-7-ming.lei@redhat.com>
 <63c09210-c20e-6b4a-56fa-b9eac2807cc1@suse.de>
 <20190417125943.GB5007@ming.t460p> <20190422033057.GC21375@ming.t460p>
 <9d93cb74-0683-bb42-2545-b4bb2bfbb831@suse.de>
 <20190423133015.GA31728@ming.t460p>
 <b7e1ad43-9ea1-8ecf-6e1f-97343c45b82f@suse.de>
 <20190424011242.GB634@ming.t460p> <20190424014535.GD634@ming.t460p>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <00ca949c-ba39-0b51-1a69-3852009ed911@suse.de>
Date:   Wed, 24 Apr 2019 07:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424014535.GD634@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/19 3:45 AM, Ming Lei wrote:
> On Wed, Apr 24, 2019 at 09:12:42AM +0800, Ming Lei wrote:
>> On Tue, Apr 23, 2019 at 04:07:49PM +0200, Hannes Reinecke wrote:
>>> On 4/23/19 3:30 PM, Ming Lei wrote:
>>>> Hi Hannes,
>>>>
>>>> Thanks for your response.
>>>>
>>>> On Tue, Apr 23, 2019 at 01:19:33PM +0200, Hannes Reinecke wrote:
>>>>> On 4/22/19 5:30 AM, Ming Lei wrote:
>>> [ .. ]
>>>>>>
>>>>>> Hi Hannes,
>>>>>>
>>>>>> Could you please let us know if you have better idea for this issue?
>>>>>> Otherwise, I think we need to move on since it is real issue, and users
>>>>>> want to fix that.
>>>>>>
>>>>> Okay. Having looked over the problem and possible alternatives, it looks
>>>>> indeed like a viable solution.
>>>>> I do agree that it's a sensible design to have an additional holding area
>>>>> for hardware context elements, given that they might be reassigned during
>>>>> blk_mq_realloc_hw_ctxs().
>>>>>
>>>>> However, I would rename the 'dead' elements to 'unused' (ie unused_hctx_list
>>>>> etc).
>>>>
>>>> OK, looks the name of 'unused' is better.
>>>>
>>>>>
>>>>> And I would deallocate q->queue_hw_ctx in blk_mq_exit_queue() to make things
>>>>> more consistent.
>>>>
>>>> No, that is wrong.
>>>>
>>>> The request queue's refcount is often held when blk_cleanup_queue() is running,
>>>> and blk_mq_exit_queue() is called directly by blk_cleanup_queue(). One invariant
>>>> is that we have to allow most APIs running well if the request queue is live
>>>> from kobject view. If q->queue_hw_ctx is freed in blk_mq_exit_queue(),
>>>> it is quite easy to cause use-after-free.
>>>>
>>> Ah. Thought as much.
>>> But then in most cases the ->queue_hw_ctx pointer is immaterial as we're
>>> accessing things via the hctx pointer, which remains valid.
>>>
>>>>> Problem with the current patch is that in blk_mq_release() we iterate
>>>>> the 'dead_hctx_list' and free up everything in there, but then blindly call
>>>>> 'kfree(q->queue_hw_ctx)' without checking if there are any context pointers
>>>>> left.
>>>>
>>>> If request queue is dead, it is safe to assume that there isn't any
>>>> reference to request queue and q->queue_hw_ctx. Otherwise, it must be
>>>> a bug somewhere.
>>>>
>>> Precisely.
>>> What I'm trying to achieve with this is to protect against such issues,
>>> which are quite easy to introduce given the complexity of the code ...
>>
>> But releasing q->queue_hw_ctx in blk_cleanup_queue() is easy to cause
>> use-after-free even though the request queue's refcount is held. We can't
>> do that simply.
>>
>> If someone is still trying to use q->queue_hw_ctx[] after the request
>> queue is dead, the bug is in the caller of block layer API, not in
>> block layer.
>>
>> What the patchset is trying to fix is the race in block layer, not
>> users of block layer, not drivers. So far, I don't see such driver
>> issue.
>>
>> Just thought q->queue_hw_ctx as the request queue's resource, you will
>> see it is pretty reasonable to free q->queue_hw_ctx in the queue's
>> release handler.
>>
>>>
>>>>> When moving the call to blk_mq_exit_queue() we could to a simple
>>>>> WARN_ON(q->queue_hw_ctx) in blk_mq_release() to ensure that everything got
>>>>> deallocated properly.
>>>>
>>>> At that time, hctx instance might be active, but that is fine given hctx
>>>> is covered by its own kobject. What we need to do is to make sure that no
>>>> any references to q->queue_hw_ctx and the request queue.
>>>>
>>> My point being here:
>>> void blk_mq_release(struct request_queue *q)
>>> {
>>>          struct blk_mq_hw_ctx *hctx, *next;
>>>
>>>          cancel_delayed_work_sync(&q->requeue_work);
>>>
>>>          /* all hctx are in .dead_hctx_list now */
>>>          list_for_each_entry_safe(hctx, next, &q->dead_hctx_list, hctx_list)
>>> {
>>>                  list_del_init(&hctx->hctx_list);
>>>                  kobject_put(&hctx->kobj);
>>>          }
>>>
>>>          kfree(q->queue_hw_ctx);
>>>
>>>          /*
>>>           * release .mq_kobj and sw queue's kobject now because
>>>           * both share lifetime with request queue.
>>>           */
>>>          blk_mq_sysfs_deinit(q);
>>> }
>>>
>>> This assumes that _all_ hctx pointers are being removed from
>>> q->queue_hw_ctx, and are moved to the 'dead' list.
>>> If for some reason this is not the case we'll be leaking hctx pointers here.
>>
>> IMO, there aren't such some reasons. When blk_mq_release() is called,
>> every hctx of this request queue has been "exited" via blk_mq_exit_hctx(),
>> either from blk_mq_update_nr_hw_queues() or blk_cleanup_queue().
>>
>> If there are hctxs not moved to the 'dead'(or 'unused') list here, it is
>> simply a bug in blk-mq. However, I don't see such case now.
> 
> Or we can add the following check in blk_mq_release() for capturing
> the impossible blk-mq bug:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2ca4395f794d..f0d08087b8f6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2366,6 +2366,8 @@ blk_mq_alloc_hctx(struct request_queue *q,
>   	hctx->queue = q;
>   	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
>   
> +	INIT_LIST_HEAD(&hctx->hctx_list);
> +
>   	/*
>   	 * Allocate space for all possible cpus to avoid allocation at
>   	 * runtime
> @@ -2680,9 +2682,14 @@ static int blk_mq_alloc_ctxs(struct request_queue *q)
>   void blk_mq_release(struct request_queue *q)
>   {
>   	struct blk_mq_hw_ctx *hctx, *next;
> +	int i;
>   
>   	cancel_delayed_work_sync(&q->requeue_work);
>   
> +	/* warn if live hctx is found, that shouldn't happen */
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		WARN_ON_ONCE(hctx && list_empty(&hctx->hctx_list));
> +
>   	/* all hctx are in .dead_hctx_list now */
>   	list_for_each_entry_safe(hctx, next, &q->dead_hctx_list, hctx_list) {
>   		list_del_init(&hctx->hctx_list);
> 
Precisely, that would've been my other choice of fixing it, but I didn't 
as I tried to avoid the loop. But if you agree then I'm fine with it, too.

Please add this hunk to the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
