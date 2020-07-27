Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6303AC433E0
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 22:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4304720829
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 22:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgG0WhU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:37:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37594 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgG0WhU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 18:37:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id d4so10784286pgk.4
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 15:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=udsqUlm/RI+XzTKnm1HlW31DB2b2GvdRLvcgicwmbAQ=;
        b=dsYKrnjkV9QDesMbx31dtMGo7VVksdpKV835alPcp5IeZZiQn0oy17H8A9DRhkyDwF
         D/lovIvQ2maWRqNuEJ3uKcvipUIhiqQR+ez1ePtFpTyh5XdbVtUDMBQbdq5fCInurC8q
         kNPOGXPiNNK/Ej/JcjMmZI5udyuSWz6jDIXiC2odPZtayLoYK7yCghLnS1Yy2VSyhG3I
         lwkoKInZ8p8bNCDxUXsKD+PloKBxt/Y0eenLbwEd5iIUXj1+nTjo0+ydM60dTce1BGuO
         z48aPOw156nIQ+a3qiDi1PmpKRsjC3bGReGHQnV1+c9GL7LByDkTX5L3gFAvyBnputII
         E0Xg==
X-Gm-Message-State: AOAM5308kwOh9T+V4MjJbQ5qFcP+slsaMmzIjC0q4y62gV8HJLrXu5Yt
        UlJKHr0WjWUHAQnCac64TuI=
X-Google-Smtp-Source: ABdhPJxk3IVLLbhbUvFNyuOn4JiCSchcWX0Kdx54AHKTrmfJjm9h9KSz7N4QExx9mZVz29Xz0K5dow==
X-Received: by 2002:aa7:949a:: with SMTP id z26mr19906034pfk.171.1595889439015;
        Mon, 27 Jul 2020 15:37:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b? ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id y24sm16202665pfp.217.2020.07.27.15.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 15:37:18 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] blk-mq: add async quiesce interface
To:     Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>
References: <20200727220717.278116-1-sagi@grimberg.me>
 <20200727220717.278116-2-sagi@grimberg.me>
 <fe247bae-8428-bca8-81b5-a7015bc39591@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e22c2f2f-6924-0090-d841-da2d84c606ae@grimberg.me>
Date:   Mon, 27 Jul 2020 15:37:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fe247bae-8428-bca8-81b5-a7015bc39591@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned int i;
>> +	int rcu = false;
>> +
>> +	blk_mq_quiesce_queue_nowait(q);
>> +
>> +	queue_for_each_hw_ctx(q, hctx, i) {
>> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
>> +		if (!hctx->rcu_sync) {
>> +			/* fallback to serial rcu sync */
>> +			if (hctx->flags & BLK_MQ_F_BLOCKING)
>> +				synchronize_srcu(hctx->srcu);
>> +			else
>> +				rcu = true;
>> +		} else {
>> +			init_completion(&hctx->rcu_sync->completion);
>> +			init_rcu_head(&hctx->rcu_sync->head);
>> +			if (hctx->flags & BLK_MQ_F_BLOCKING)
>> +				call_srcu(hctx->srcu, &hctx->rcu_sync->head,
>> +					wakeme_after_rcu);
>> +			else
>> +				call_rcu(&hctx->rcu_sync->head,
>> +					wakeme_after_rcu);
>> +		}
>> +	}
>> +	if (rcu)
>> +		synchronize_rcu();
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
> 
> This won't always be async, and that might matter to some users. I think
> it'd be better to put the fallback path into the _wait() part instead,
> since the caller should expect that to be blocking/waiting as the name
> implies.
> 
> Nit picking, but...

Makes sense..

I thought more about Keith suggestion for an interface that accepts a
tagset. It allows us to decide what we do based on the tagset itself
which is now passed in the interface.

What do you think about:
--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index abcf590f6238..d4b24aa1a766 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,6 +209,43 @@ void blk_mq_quiesce_queue_nowait(struct 
request_queue *q)
  }
  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);

+static void blk_mq_quiesce_queue_async(struct request_queue *q)
+{
+       struct blk_mq_hw_ctx *hctx;
+       unsigned int i;
+
+       blk_mq_quiesce_queue_nowait(q);
+
+       queue_for_each_hw_ctx(q, hctx, i) {
+               if (!(hctx->flags & BLK_MQ_F_BLOCKING))
+                       continue;
+
+               hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), 
GFP_KERNEL);
+               if (!hctx->rcu_sync)
+                       continue;
+
+               init_completion(&hctx->rcu_sync->completion);
+               init_rcu_head(&hctx->rcu_sync->head);
+               call_srcu(hctx->srcu, &hctx->rcu_sync->head,
+                               wakeme_after_rcu);
+       }
+}
+
+static void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
+{
+       struct blk_mq_hw_ctx *hctx;
+       unsigned int i;
+
+       queue_for_each_hw_ctx(q, hctx, i) {
+               if (!hctx->rcu_sync) {
+                       synchronize_srcu(hctx->srcu);
+                       continue;
+               }
+               wait_for_completion(&hctx->rcu_sync->completion);
+               destroy_rcu_head(&hctx->rcu_sync->head);
+       }
+}
+
  /**
   * blk_mq_quiesce_queue() - wait until all ongoing dispatches have 
finished
   * @q: request queue.
@@ -2884,6 +2921,39 @@ static void queue_set_hctx_shared(struct 
request_queue *q, bool shared)
         }
  }

+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+       struct request_queue *q;
+
+       mutex_lock(&set->tag_list_lock);
+       list_for_each_entry(q, &set->tag_list, tag_set_list) {
+               if (!(set->flags & BLK_MQ_F_BLOCKING))
+                       blk_mq_quiesce_queue_nowait(q);
+               else
+                       blk_mq_quiesce_queue_async(q);
+       }
+
+       if (!(set->flags & BLK_MQ_F_BLOCKING)) {
+               synchronize_rcu();
+       } else {
+               list_for_each_entry(q, &set->tag_list, tag_set_list)
+                       blk_mq_quiesce_queue_async_wait(q);
+       }
+       mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
+
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
+{
+       struct request_queue *q;
+
+       mutex_lock(&set->tag_list_lock);
+       list_for_each_entry(q, &set->tag_list, tag_set_list)
+               blk_mq_unquiesce_queue(q);
+       mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
+
  static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set,
                                         bool shared)
  {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..a85f2dedc947 100644
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
+void blk_mq_quiesce_tagset(struct request_queue *q);
+void blk_mq_unquiesce_tagset(struct request_queue *q);

  unsigned int blk_mq_rq_cpu(struct request *rq);
--


And then nvme will use it:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..c41df20996d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4557,23 +4557,13 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);

  void nvme_stop_queues(struct nvme_ctrl *ctrl)
  {
-       struct nvme_ns *ns;
-
-       down_read(&ctrl->namespaces_rwsem);
-       list_for_each_entry(ns, &ctrl->namespaces, list)
-               blk_mq_quiesce_queue(ns->queue);
-       up_read(&ctrl->namespaces_rwsem);
+       blk_mq_quiesce_tagset(ctrl->tagset);
  }
  EXPORT_SYMBOL_GPL(nvme_stop_queues);

  void nvme_start_queues(struct nvme_ctrl *ctrl)
  {
-       struct nvme_ns *ns;
-
-       down_read(&ctrl->namespaces_rwsem);
-       list_for_each_entry(ns, &ctrl->namespaces, list)
-               blk_mq_unquiesce_queue(ns->queue);
-       up_read(&ctrl->namespaces_rwsem);
+       blk_mq_unquiesce_tagset(ctrl->tagset);
  }
  EXPORT_SYMBOL_GPL(nvme_start_queues);
--

Thoughts?
