Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DB8C433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 09:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BE020786
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 09:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KW6DR4ZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgG1JQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:16:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31278 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728050AbgG1JQy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 05:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595927812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JhguO2b4FG/+LTpR6soo9OJKoVnD25MqSEyA1kTPNa0=;
        b=KW6DR4ZH4FX+iCEFuyLi6P78XFYaO4HgxxglOs93r8IQWd/R3hQ5vRgiOZOX+PAqjVeNAk
        zey5EPLVEcqu8/Gvd6G5Qsqva9ovorvznWemRNg7Pp1heV5CesGPSmPS5I6SYGcQgxF5xA
        TCk3+Kd0BKDtR5pSdHzBouLrF119ri4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-eB_n7LjGNQ2pJA3yhcpELw-1; Tue, 28 Jul 2020 05:16:48 -0400
X-MC-Unique: eB_n7LjGNQ2pJA3yhcpELw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 780B61DE0;
        Tue, 28 Jul 2020 09:16:46 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CECA712F0;
        Tue, 28 Jul 2020 09:16:38 +0000 (UTC)
Date:   Tue, 28 Jul 2020 17:16:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728091633.GB1326626@T590>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200728071859.GA21629@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728071859.GA21629@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 28, 2020 at 09:18:59AM +0200, Christoph Hellwig wrote:
> I like the tagset based interface.  But the idea of doing a per-hctx
> allocation and wait doesn't seem very scalable.
> 
> Paul, do you have any good idea for an interface that waits on
> multiple srcu heads?  As far as I can tell we could just have a single
> global completion and counter, and each call_srcu would just just
> decrement it and then the final one would do the wakeup.  It would just
> be great to figure out a way to keep the struct rcu_synchronize and
> counter on stack to avoid an allocation.
> 
> But if we can't do with an on-stack object I'd much rather just embedd
> the rcu_head in the hw_ctx.

I think we can do that, please see the following patch which is against Sagi's V5:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c3856377b961..fc46e77460f1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -27,6 +27,7 @@
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
+#include <linux/rcupdate_wait.h>
 
 #include <trace/events/block.h>
 
@@ -209,6 +210,50 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
+struct blk_mq_srcu_sync {
+	struct rcu_synchronize srcu_sync;
+	atomic_t count;
+};
+
+static void blk_mq_srcu_sync_init(struct blk_mq_srcu_sync *sync, int count)
+{
+	init_completion(&sync->srcu_sync.completion);
+	init_rcu_head(&sync->srcu_sync.head);
+
+	atomic_set(&sync->count, count);
+}
+
+static void blk_mq_srcu_sync_wait(struct blk_mq_srcu_sync *sync)
+{
+	wait_for_completion(&sync->srcu_sync.completion);
+	destroy_rcu_head_on_stack(&sync->srcu_sync.head);
+}
+
+static void blk_mq_wakeme_after_rcu(struct rcu_head *head)
+{
+	struct blk_mq_srcu_sync *sync;
+
+	sync = container_of(head, struct blk_mq_srcu_sync, srcu_sync.head);
+
+	if (atomic_dec_and_test(&sync->count))
+		complete(&sync->srcu_sync.completion);
+}
+
+static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q,
+		struct blk_mq_srcu_sync *sync)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+
+	blk_mq_quiesce_queue_nowait(q);
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
+		call_srcu(hctx->srcu, &sync->srcu_sync.head,
+				blk_mq_wakeme_after_rcu);
+	}
+}
+
 /**
  * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
  * @q: request queue.
@@ -2880,6 +2925,45 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 	}
 }
 
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	if (set->flags & BLK_MQ_F_BLOCKING) {
+		struct blk_mq_srcu_sync sync;
+		int count = 0;
+
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			count++;
+
+		blk_mq_srcu_sync_init(&sync, count);
+
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			blk_mq_quiesce_blocking_queue_async(q, &sync);
+
+		blk_mq_srcu_sync_wait(&sync);
+
+	} else {
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			blk_mq_quiesce_queue_nowait(q);
+		synchronize_rcu();
+	}
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
+
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_unquiesce_queue(q);
+	mutex_unlock(&set->tag_list_lock);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
+
 static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set,
 					bool shared)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..d5e0974a1dcc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -532,6 +532,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 


-- 
Ming

