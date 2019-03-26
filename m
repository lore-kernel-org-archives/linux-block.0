Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5A4C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D5120811
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 15:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfCZPdw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:33:52 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:34609 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfCZPdw (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Tue, 26 Mar 2019 11:33:52 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 26 Mar 2019 16:33:50 +0100
Subject: Re: [PATCH] block: don't call blk_mq_run_hw_queues() for dead or
 dying queues
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        James Smart <james.smart@broadcom.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block@vger.kernel.org
References: <20190326120712.41657-1-hare@suse.de>
 <82fca840-bce0-938e-abc5-1faff5c255d0@acm.org>
 <a95b94e1-ee6f-a534-a1f0-d55d6b8bffe0@suse.de>
 <1553613164.118779.50.camel@acm.org>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <761a7684-862d-d3bf-a75d-aab06fd43e29@suse.com>
Date:   Tue, 26 Mar 2019 16:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553613164.118779.50.camel@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/19 4:12 PM, Bart Van Assche wrote:
> On Tue, 2019-03-26 at 15:08 +0100, Hannes Reinecke wrote:
>> On 3/26/19 2:43 PM, Bart Van Assche wrote:
>>> On 3/26/19 5:07 AM, Hannes Reinecke wrote:
>>>> When a queue is dying or dead there is no point in calling
>>>> blk_mq_run_hw_queues() in blk_mq_unquiesce_queue(); in fact, doing
>>>> so might crash the machine as the queue structures are in the
>>>> process of being deleted.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>>>> ---
>>>>    block/blk-mq.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index a9c181603cbd..b1eeba38bc79 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -258,7 +258,8 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>>>>        blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>>>>        /* dispatch requests which are inserted during quiescing */
>>>> -    blk_mq_run_hw_queues(q, true);
>>>> +    if (!blk_queue_dying(q) && !blk_queue_dead(q))
>>>> +        blk_mq_run_hw_queues(q, true);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>>>
>>> Hi Hannes,
>>>
>>> Please provide more context information. In the "dead" state the queue
>>> must be run to make sure that all requests that were queued before the
>>> "dead" state get processed. The blk_cleanup_queue() function is
>>> responsible for stopping all code that can run the queue after all
>>> requests have finished and before destruction of the data structures
>>> needed for request processing starts.
>>>
>>
>> I have a crash with two processes competing for the same controller:
>>
>> #0  0xffffffff983d3bcb in sbitmap_any_bit_set (sb=0xffff8a1b874ba0d8)
>>       at ../lib/sbitmap.c:181
>> #1  0xffffffff98366c05 in blk_mq_hctx_has_pending (hctx=0xffff8a1b874ba000)
>>       at ../block/blk-mq.c:66
>> #2  0xffffffff98366c85 in blk_mq_run_hw_queues (q=0xffff8a1b874ba0d8,
>> async=true) at ../block/blk-mq.c:1292
>> #3  0xffffffff98366d3a in blk_mq_unquiesce_queue (q=<optimized out>)
>>       at ../block/blk-mq.c:265
>> #4  0xffffffffc01f3e0e in nvme_start_queues (ctrl=<optimized out>)
>>       at ../drivers/nvme/host/core.c:3658
>> #5  0xffffffffc01e843c in nvme_fc_delete_association
>> (ctrl=0xffff8a1f9be5a000)
>>       at ../drivers/nvme/host/fc.c:2843
>> #6  0xffffffffc01e8544 in nvme_fc_delete_association (ctrl=<optimized out>)
>>       at ../drivers/nvme/host/fc.c:2918
>> #7  0xffffffffc01e8544 in __nvme_fc_terminate_io (ctrl=0xffff8a1f9be5a000)
>>       at ../drivers/nvme/host/fc.c:2911
>> #8  0xffffffffc01e8f09 in nvme_fc_reset_ctrl_work (work=0xffff8a1f9be5a6d0)
>>       at ../drivers/nvme/host/fc.c:2927
>> #9  0xffffffff980a224a in process_one_work (worker=0xffff8a1b73934f00,
>> work=0xffff8a1f9be5a6d0) at ../kernel/workqueue.c:2092
>> #10 0xffffffff980a249b in worker_thread (__worker=0xffff8a1b73934f00)
>>       at ../kernel/workqueue.c:2226
>>
>> #7  0xffffffff986d2e9a in wait_for_completion (x=0xffffa48eca88bc40)
>>       at ../kernel/sched/completion.c:125
>> #8  0xffffffff980f25ae in __synchronize_srcu (sp=0xffffffff9914fc20
>> <debugfs_srcu>, do_norm=<optimized out>) at ../kernel/rcu/srcutree.c:851
>> #9  0xffffffff982d18b1 in debugfs_remove_recursive (dentry=<optimized out>)
>>       at ../fs/debugfs/inode.c:741
>> #10 0xffffffff98398ac5 in blk_mq_debugfs_unregister_hctx
>> (hctx=0xffff8a1b7cccc000) at ../block/blk-mq-debugfs.c:897
>> #11 0xffffffff983661cf in blk_mq_exit_hctx (q=0xffff8a1f825e4040,
>> set=0xffff8a1f9be5a0c0, hctx=0xffff8a1b7cccc000, hctx_idx=2) at
>> ../block/blk-mq.c:1987
>> #12 0xffffffff9836946a in blk_mq_exit_hw_queues (nr_queue=<optimized
>> out>, set=<optimized out>, q=<optimized out>) at ../block/blk-mq.c:2017
>> #13 0xffffffff9836946a in blk_mq_free_queue (q=0xffff8a1f825e4040)
>>       at ../block/blk-mq.c:2506
>> #14 0xffffffff9835aac5 in blk_cleanup_queue (q=0xffff8a1f825e4040)
>>       at ../block/blk-core.c:691
>> #15 0xffffffffc01f5bc8 in nvme_ns_remove (ns=0xffff8a1f819e8f80)
>>       at ../drivers/nvme/host/core.c:3138
>> #16 0xffffffffc01f6fea in nvme_validate_ns (ctrl=0xffff8a1f9be5a308, nsid=5)
>>       at ../drivers/nvme/host/core.c:3164
>> #17 0xffffffffc01f9053 in nvme_scan_ns_list (nn=<optimized out>,
>> ctrl=<optimized out>) at ../drivers/nvme/host/core.c:3202
>> #18 0xffffffffc01f9053 in nvme_scan_work (work=<optimized out>)
>>       at ../drivers/nvme/host/core.c:3280
>> #19 0xffffffff980a224a in process_one_work (worker=0xffff8a1b7349f6c0,
>> work=0xffff8a1f9be5aba0) at ../kernel/workqueue.c:2092
>>
>> Point is that the queue is already dead by the time nvme_start_queues()
>> tries to flush existing requests (of which there are none, of course).
>> I had been looking into synchronizing scan_work and reset_work, but then
>> I wasn't sure if that wouldn't deadlock somewhere.
> 
> James, do you agree that nvme_fc_reset_ctrl_work should be canceled before
> nvme_ns_remove() is allowed to call blk_cleanup_queue()?
> 
Hmm. I would've thought exactly the other way round, namely 
cancelling/flushing the scan_work element when calling reset; after all, 
reset definitely takes precedence to scanning the controller (which 
won't work anyway as the controller is about to be reset...)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
