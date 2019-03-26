Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB499C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD83620866
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VFw7reee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbfCZRtO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:49:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44717 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbfCZRtN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 13:49:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so2288819pfm.11
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2019 10:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2rjLyH7DwFzp/v20NxqmNbihKEeP/6pLOXaKEv2zw00=;
        b=VFw7reeeOo7hdWF3Y+nZyO7yR/wjr7v/hZGo7ZqwN/Kx9RQ0I7Pyx7TFS5fjR+Ad0c
         r2+qvCyHehnksrHnGy8Aj+XIq8iaKl4WWGTxdZayFTEMyPrQ9FDM0x5OwDuMmSuNstFG
         kPQ+4lq7tNwUX7qhZE4iI1narppEL1BSG6NSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2rjLyH7DwFzp/v20NxqmNbihKEeP/6pLOXaKEv2zw00=;
        b=iYHqzh1KH7PjIdzEFuo5YEwZd4lXMn8Ooc0vpsg0AxQ8YoBUBOXo/0ao8juzuUyGFT
         g5thsBsTy7sRv5xXg630U5TfTi9AOPEcMRVhRdISti/M7dIVOxSt7JFGA8Zmwi9mnShJ
         sEEKtlcLuozssBgHxH1WWmn2FnxeiRzRaeF88ctMYMvR9d8/40FfDdCTwSB2+G/oHELe
         uuiRBBw6Jykg7BlLJDowQAbrroF+g4x6hdYRMWfJnIV7Qm/dNo7JX/dnxmAXvzxRdc5q
         HjRpn4EK4G2A21J25Yopu+fhese0y5RVefjrxI/1iZa+Y1DZ55lNZX3lghaffWu5c/py
         yjJQ==
X-Gm-Message-State: APjAAAXTtFdyzPVjQgf6cObS1gVY8rdcbG+tlJz3rggrui6HuWPqNQNz
        z0Pu7n5siRPe3OjX2ywaOIehNg==
X-Google-Smtp-Source: APXvYqzN+uvx5ksXHHX+BmExa6VIrROweZPaBKIymFS/+uOJT9g3jfnS1FjGOrAYodlJ2j8yN8dTIg==
X-Received: by 2002:a63:d015:: with SMTP id z21mr29421870pgf.215.1553622552891;
        Tue, 26 Mar 2019 10:49:12 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id m2sm24246768pgr.74.2019.03.26.10.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:49:11 -0700 (PDT)
Subject: Re: [PATCH] block: don't call blk_mq_run_hw_queues() for dead or
 dying queues
To:     Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block@vger.kernel.org,
        "smart >> James Smart" <james.smart@broadcom.com>
References: <20190326120712.41657-1-hare@suse.de>
 <82fca840-bce0-938e-abc5-1faff5c255d0@acm.org>
 <a95b94e1-ee6f-a534-a1f0-d55d6b8bffe0@suse.de>
 <1553613164.118779.50.camel@acm.org>
 <761a7684-862d-d3bf-a75d-aab06fd43e29@suse.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <f6096aa5-0311-6d7f-697a-bb5771ca5fc7@broadcom.com>
Date:   Tue, 26 Mar 2019 10:49:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <761a7684-862d-d3bf-a75d-aab06fd43e29@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/2019 8:33 AM, Hannes Reinecke wrote:
> On 3/26/19 4:12 PM, Bart Van Assche wrote:
>> On Tue, 2019-03-26 at 15:08 +0100, Hannes Reinecke wrote:
>>> On 3/26/19 2:43 PM, Bart Van Assche wrote:
>>>> On 3/26/19 5:07 AM, Hannes Reinecke wrote:
>>>>> When a queue is dying or dead there is no point in calling
>>>>> blk_mq_run_hw_queues() in blk_mq_unquiesce_queue(); in fact, doing
>>>>> so might crash the machine as the queue structures are in the
>>>>> process of being deleted.
>>>>>
>>>>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>>>>> ---
>>>>>    block/blk-mq.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>>> index a9c181603cbd..b1eeba38bc79 100644
>>>>> --- a/block/blk-mq.c
>>>>> +++ b/block/blk-mq.c
>>>>> @@ -258,7 +258,8 @@ void blk_mq_unquiesce_queue(struct 
>>>>> request_queue *q)
>>>>>        blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>>>>>        /* dispatch requests which are inserted during quiescing */
>>>>> -    blk_mq_run_hw_queues(q, true);
>>>>> +    if (!blk_queue_dying(q) && !blk_queue_dead(q))
>>>>> +        blk_mq_run_hw_queues(q, true);
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>>>>
>>>> Hi Hannes,
>>>>
>>>> Please provide more context information. In the "dead" state the queue
>>>> must be run to make sure that all requests that were queued before the
>>>> "dead" state get processed. The blk_cleanup_queue() function is
>>>> responsible for stopping all code that can run the queue after all
>>>> requests have finished and before destruction of the data structures
>>>> needed for request processing starts.
>>>>
>>>
>>> I have a crash with two processes competing for the same controller:
>>>
>>> #0  0xffffffff983d3bcb in sbitmap_any_bit_set (sb=0xffff8a1b874ba0d8)
>>>       at ../lib/sbitmap.c:181
>>> #1  0xffffffff98366c05 in blk_mq_hctx_has_pending 
>>> (hctx=0xffff8a1b874ba000)
>>>       at ../block/blk-mq.c:66
>>> #2  0xffffffff98366c85 in blk_mq_run_hw_queues (q=0xffff8a1b874ba0d8,
>>> async=true) at ../block/blk-mq.c:1292
>>> #3  0xffffffff98366d3a in blk_mq_unquiesce_queue (q=<optimized out>)
>>>       at ../block/blk-mq.c:265
>>> #4  0xffffffffc01f3e0e in nvme_start_queues (ctrl=<optimized out>)
>>>       at ../drivers/nvme/host/core.c:3658
>>> #5  0xffffffffc01e843c in nvme_fc_delete_association
>>> (ctrl=0xffff8a1f9be5a000)
>>>       at ../drivers/nvme/host/fc.c:2843
>>> #6  0xffffffffc01e8544 in nvme_fc_delete_association 
>>> (ctrl=<optimized out>)
>>>       at ../drivers/nvme/host/fc.c:2918
>>> #7  0xffffffffc01e8544 in __nvme_fc_terminate_io 
>>> (ctrl=0xffff8a1f9be5a000)
>>>       at ../drivers/nvme/host/fc.c:2911
>>> #8  0xffffffffc01e8f09 in nvme_fc_reset_ctrl_work 
>>> (work=0xffff8a1f9be5a6d0)
>>>       at ../drivers/nvme/host/fc.c:2927
>>> #9  0xffffffff980a224a in process_one_work (worker=0xffff8a1b73934f00,
>>> work=0xffff8a1f9be5a6d0) at ../kernel/workqueue.c:2092
>>> #10 0xffffffff980a249b in worker_thread (__worker=0xffff8a1b73934f00)
>>>       at ../kernel/workqueue.c:2226
>>>
>>> #7  0xffffffff986d2e9a in wait_for_completion (x=0xffffa48eca88bc40)
>>>       at ../kernel/sched/completion.c:125
>>> #8  0xffffffff980f25ae in __synchronize_srcu (sp=0xffffffff9914fc20
>>> <debugfs_srcu>, do_norm=<optimized out>) at 
>>> ../kernel/rcu/srcutree.c:851
>>> #9  0xffffffff982d18b1 in debugfs_remove_recursive 
>>> (dentry=<optimized out>)
>>>       at ../fs/debugfs/inode.c:741
>>> #10 0xffffffff98398ac5 in blk_mq_debugfs_unregister_hctx
>>> (hctx=0xffff8a1b7cccc000) at ../block/blk-mq-debugfs.c:897
>>> #11 0xffffffff983661cf in blk_mq_exit_hctx (q=0xffff8a1f825e4040,
>>> set=0xffff8a1f9be5a0c0, hctx=0xffff8a1b7cccc000, hctx_idx=2) at
>>> ../block/blk-mq.c:1987
>>> #12 0xffffffff9836946a in blk_mq_exit_hw_queues (nr_queue=<optimized
>>> out>, set=<optimized out>, q=<optimized out>) at ../block/blk-mq.c:2017
>>> #13 0xffffffff9836946a in blk_mq_free_queue (q=0xffff8a1f825e4040)
>>>       at ../block/blk-mq.c:2506
>>> #14 0xffffffff9835aac5 in blk_cleanup_queue (q=0xffff8a1f825e4040)
>>>       at ../block/blk-core.c:691
>>> #15 0xffffffffc01f5bc8 in nvme_ns_remove (ns=0xffff8a1f819e8f80)
>>>       at ../drivers/nvme/host/core.c:3138
>>> #16 0xffffffffc01f6fea in nvme_validate_ns (ctrl=0xffff8a1f9be5a308, 
>>> nsid=5)
>>>       at ../drivers/nvme/host/core.c:3164
>>> #17 0xffffffffc01f9053 in nvme_scan_ns_list (nn=<optimized out>,
>>> ctrl=<optimized out>) at ../drivers/nvme/host/core.c:3202
>>> #18 0xffffffffc01f9053 in nvme_scan_work (work=<optimized out>)
>>>       at ../drivers/nvme/host/core.c:3280
>>> #19 0xffffffff980a224a in process_one_work (worker=0xffff8a1b7349f6c0,
>>> work=0xffff8a1f9be5aba0) at ../kernel/workqueue.c:2092
>>>
>>> Point is that the queue is already dead by the time nvme_start_queues()
>>> tries to flush existing requests (of which there are none, of course).
>>> I had been looking into synchronizing scan_work and reset_work, but 
>>> then
>>> I wasn't sure if that wouldn't deadlock somewhere.
>>
>> James, do you agree that nvme_fc_reset_ctrl_work should be canceled 
>> before
>> nvme_ns_remove() is allowed to call blk_cleanup_queue()?
>>
> Hmm. I would've thought exactly the other way round, namely 
> cancelling/flushing the scan_work element when calling reset; after 
> all, reset definitely takes precedence to scanning the controller 
> (which won't work anyway as the controller is about to be reset...)
>
> Cheers,
>
> Hannes

Cancelling/flushing scan_work before starting reset won't work. Hannes 
is, correct, reset must take precedent.

The scenario is a controller that was recently connected, thus scan work 
started, and while the scan thread is running, there's an error or 
connectivity is lost.  The errors force the reset - which must run to 
terminate any outstanding requests, including those issued by the scan 
thread.  This has to happen or we're going to hang the scan thread as 
it's synchronous io.  The 
nvme_fc_delete_association->nvme_start_queues() sequence says the reset 
path froze the queues, cancelled all outstanding io and is unfreezing 
the queues to allow io to pass again, so that any new io on the request 
queue can be rejected while the controller is not connected (ioctls or 
subsequent io from the scan thread while the controller is unconnected 
as well as anything that was pending on the io queues from the fs that 
should be bounced back for multipath).  Meanwhile, the scan thread got 
the error on the io request, and since it's the identify command that 
failed, it's deleting the namespace at the same time the transport is 
unfreezing the queues.

Given the transport nvme_start_queues() routine has no idea what 
ns-queues exist, or what state the ns queues are in, it seems like a 
synchronization issue on the ns queue itself, that can't be solved by 
scheduling transport work elements.

I wonder if it should be something like this:
--- a    2019-03-26 10:46:08.576056741 -0700
+++ b    2019-03-26 10:47:55.081252967 -0700
@@ -3870,8 +3870,10 @@ void nvme_start_queues(struct nvme_ctrl
      struct nvme_ns *ns;

      down_read(&ctrl->namespaces_rwsem);
-    list_for_each_entry(ns, &ctrl->namespaces, list)
-        blk_mq_unquiesce_queue(ns->queue);
+    list_for_each_entry(ns, &ctrl->namespaces, list) {
+        if (!test_bit(NVME_NS_REMOVING, &ns->flags))
+            blk_mq_unquiesce_queue(ns->queue);
+    }
      up_read(&ctrl->namespaces_rwsem);
  }
  EXPORT_SYMBOL_GPL(nvme_start_queues);

which if valid, would also mean the same check should be in 
nvme_stop_queues() and perhaps elsewhere.

-- james

