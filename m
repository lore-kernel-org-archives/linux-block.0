Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0102FC433E0
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 21:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9F420792
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 21:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgG0VAU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:00:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47086 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0VAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 17:00:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id k13so993216plk.13
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 14:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+otlVdaFoXEGuYCKdx8dfww2sRITf488l6Vbt3WHVic=;
        b=o9XLzzioEwMAux5kwW4Tzi+ixPr7fV6Qh2YCtlCGk7d9QFQcw3RUApMRZmxYgECfR9
         BGHJYoWvOID76KcYRm3rdtOALHCMRrmPB5vLeS6hYSi81hl+hY94Vozm29nd2HqAcT0G
         z4kXof9ydrRabTHXYObxbxEupojOKFxm5BBywkTtzTd8WFzx2Gdf5GisSbHtT9B0+jTX
         9yKx+NxyVjTLyGdQgdHuZd+13pD6dkG008r5Q5Ikusd8g3dipTht0DvRpFxwzGxKApx3
         xpHMjxBC22R5s6dguGzHUcaVk3bc9qAkkbrJiITvv8L0+vl6U3k87g6ptm4NBkjig+wX
         qU+g==
X-Gm-Message-State: AOAM531SieN0MSyvt0seR3Q1UW+waRiGGWVpq5HZLj92DovZhd4GQgR3
        FNsgwpjf6ZDiNRNUYOVA9AA=
X-Google-Smtp-Source: ABdhPJyV65Q5RssUBbTuzAfqUTr62UEgn0j5b4lnIrOzLGrgwA1mDb4FpLpzbhg+KgPyYjNXTODTlg==
X-Received: by 2002:a17:90a:764c:: with SMTP id s12mr995386pjl.201.1595883617250;
        Mon, 27 Jul 2020 14:00:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b? ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id 204sm16097933pfx.3.2020.07.27.14.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 14:00:16 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
 <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
Date:   Mon, 27 Jul 2020 14:00:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>>>>>> +{
>>>>>> +	struct blk_mq_hw_ctx *hctx;
>>>>>> +	unsigned int i;
>>>>>> +
>>>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>>>> +
>>>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>>>> +		init_completion(&hctx->rcu_sync.completion);
>>>>>> +		init_rcu_head(&hctx->rcu_sync.head);
>>>>>> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
>>>>>> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
>>>>>> +				wakeme_after_rcu);
>>>>>> +		else
>>>>>> +			call_rcu(&hctx->rcu_sync.head,
>>>>>> +				wakeme_after_rcu);
>>>>>> +	}
>>>>>
>>>>> Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
>>>>> synchronize_rcu() is OK for all hctx during waiting.
>>>>
>>>> That's true, but I want a single interface for both. v2 had exactly
>>>> that, but I decided that this approach is better.
>>>
>>> Not sure one new interface is needed, and one simple way is to:
>>>
>>> 1) call blk_mq_quiesce_queue_nowait() for each request queue
>>>
>>> 2) wait in driver specific way
>>>
>>> Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
>>> then you may add per-tagset APIs for the waiting.
>>
>> Because it puts assumptions on how quiesce works, which is something
>> I'd like to avoid because I think its cleaner, what do others think?
>> Jens? Christoph?
> 
> I'd prefer to have it in a helper, and just have blk_mq_quiesce_queue()
> call that.

I agree with this approach as well.

Jens, this mean that we use the call_rcu mechanism also for non-blocking
hctxs, because the caller  will call it for multiple request queues (see
patch 2) and we don't want to call synchronize_rcu for every request
queue serially, we want it to happen in parallel.

Which leaves us with the patchset as it is, just to convert the
rcu_synchronize structure to be dynamically allocated on the heap
rather than keeping it statically allocated in the hctx.

This is how it looks:
--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..d913924117d2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,6 +209,52 @@ void blk_mq_quiesce_queue_nowait(struct 
request_queue *q)
  }
  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);

+void blk_mq_quiesce_queue_async(struct request_queue *q)
+{
+       struct blk_mq_hw_ctx *hctx;
+       unsigned int i;
+       int rcu = false;
+
+       blk_mq_quiesce_queue_nowait(q);
+
+       queue_for_each_hw_ctx(q, hctx, i) {
+               hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), 
GFP_KERNEL);
+               if (!hctx->rcu_sync) {
+                       /* fallback to serial rcu sync */
+                       if (hctx->flags & BLK_MQ_F_BLOCKING)
+                               synchronize_srcu(hctx->srcu);
+                       else
+                               rcu = true;
+               } else {
+                       init_completion(&hctx->rcu_sync->completion);
+                       init_rcu_head(&hctx->rcu_sync->head);
+                       if (hctx->flags & BLK_MQ_F_BLOCKING)
+                               call_srcu(hctx->srcu, &hctx->rcu_sync->head,
+                                       wakeme_after_rcu);
+                       else
+                               call_rcu(&hctx->rcu_sync->head,
+                                       wakeme_after_rcu);
+               }
+       }
+       if (rcu)
+               synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
+
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
+{
+       struct blk_mq_hw_ctx *hctx;
+       unsigned int i;
+
+       queue_for_each_hw_ctx(q, hctx, i) {
+               if (!hctx->rcu_sync)
+                       continue;
+               wait_for_completion(&hctx->rcu_sync->completion);
+               destroy_rcu_head(&hctx->rcu_sync->head);
+       }
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
+
  /**
   * blk_mq_quiesce_queue() - wait until all ongoing dispatches have 
finished
   * @q: request queue.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..7213ce56bb31 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -5,6 +5,7 @@
  #include <linux/blkdev.h>
  #include <linux/sbitmap.h>
  #include <linux/srcu.h>
+#include <linux/rcupdate_wait.h>

  struct blk_mq_tags;
  struct blk_flush_queue;
@@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
          */
         struct list_head        hctx_list;

+       struct rcu_synchronize  *rcu_sync;
         /**
          * @srcu: Sleepable RCU. Use as lock when type of the hardware 
queue is
          * blocking (BLK_MQ_F_BLOCKING). Must be the last member - see also
@@ -532,6 +534,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int 
nr_hw_queues);

  void blk_mq_quiesce_queue_nowait(struct request_queue *q);
+void blk_mq_quiesce_queue_async(struct request_queue *q);
+void blk_mq_quiesce_queue_async_wait(struct request_queue *q);

  unsigned int blk_mq_rq_cpu(struct request *rq);
--

and in nvme:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..e8cc728dee46 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4561,7 +4561,9 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)

         down_read(&ctrl->namespaces_rwsem);
         list_for_each_entry(ns, &ctrl->namespaces, list)
-               blk_mq_quiesce_queue(ns->queue);
+               blk_mq_quiesce_queue_async(ns->queue);
+       list_for_each_entry(ns, &ctrl->namespaces, list)
+               blk_mq_quiesce_queue_async_wait(ns->queue);
         up_read(&ctrl->namespaces_rwsem);
  }
  EXPORT_SYMBOL_GPL(nvme_stop_queues);
--

Agreed on this?
