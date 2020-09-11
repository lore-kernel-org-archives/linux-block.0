Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8DFC433E2
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 02:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FBD120829
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 02:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eimNAX3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgIKCl7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:41:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36052 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725300AbgIKCl6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Sep 2020 22:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599792117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ir0kQN3Z9A+hkwc1EvGn0Ns9Sdm5PJPKlpUidXz9+oA=;
        b=eimNAX3ElLOXh2aM6Bys8ZiEH0NEO/P8aRF9yrTpKjTXNnAExX/gSjNfXOtxda4C+7L8pP
        Yn7pLBHjaA29qK7mV5H1fFa62vsM41ocBaL8aarDwa34WnSs8m4qC5/PqEzz1hjEQShKut
        hmYqvU29lxp4forwNWoC0SYGTccaLR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-ar5BfwrINFOV6Zibr0MI1g-1; Thu, 10 Sep 2020 22:41:53 -0400
X-MC-Unique: ar5BfwrINFOV6Zibr0MI1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E48181882FB6;
        Fri, 11 Sep 2020 02:41:51 +0000 (UTC)
Received: from localhost (ovpn-13-69.pek2.redhat.com [10.72.13.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1B6F60BF4;
        Fri, 11 Sep 2020 02:41:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 3/4] blk-mq: add tagset quiesce interface
Date:   Fri, 11 Sep 2020 10:41:16 +0800
Message-Id: <20200911024117.62480-4-ming.lei@redhat.com>
In-Reply-To: <20200911024117.62480-1-ming.lei@redhat.com>
References: <20200911024117.62480-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

drivers that have shared tagsets may need to quiesce potentially a lot
of request queues that all share a single tagset (e.g. nvme). Add an interface
to quiesce all the queues on a given tagset. This interface is useful because
it can speedup the quiesce by doing it in parallel.

For tagsets that have BLK_MQ_F_BLOCKING set, we kill request queue's dispatch
percpu-refcount such that all of them wait for the counter becoming zero. For
tagsets that don't have BLK_MQ_F_BLOCKING set, we simply call a single
synchronize_rcu as this is sufficient.

This patch is against Sagi's original post.
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c         | 59 +++++++++++++++++++++++++++++++++++-------
 include/linux/blk-mq.h |  2 ++
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df0fa3640649..ccb500e38008 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -214,16 +214,7 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
-/**
- * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
- * @q: request queue.
- *
- * Note: this function does not prevent that the struct request end_io()
- * callback function is invoked. Once this function is returned, we make
- * sure no dispatch can happen until the queue is unquiesced via
- * blk_mq_unquiesce_queue().
- */
-void blk_mq_quiesce_queue(struct request_queue *q)
+static void __blk_mq_quiesce_queue(struct request_queue *q, bool wait)
 {
 	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
 	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
@@ -231,6 +222,9 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	if (!was_quiesced && blocking)
 		percpu_ref_kill(&q->dispatch_counter);
 
+	if (!wait)
+		return;
+
 	/*
 	 * In case of F_BLOCKING, if driver unquiesces its queue being
 	 * quiesced, it can cause bigger trouble, and we simply return &
@@ -244,6 +238,20 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	else
 		synchronize_rcu();
 }
+
+/*
+ * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
+ * @q: request queue.
+ *
+ * Note: this function does not prevent that the struct request end_io()
+ * callback function is invoked. Once this function is returned, we make
+ * sure no dispatch can happen until the queue is unquiesced via
+ * blk_mq_unquiesce_queue().
+ */
+void blk_mq_quiesce_queue(struct request_queue *q)
+{
+	__blk_mq_quiesce_queue(q, true);
+}
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
 /*
@@ -265,6 +273,37 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
+{
+	struct request_queue *q;
+
+	mutex_lock(&set->tag_list_lock);
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		__blk_mq_quiesce_queue(q, false);
+
+	/* wait until all queues' quiesce is done */
+	if (set->flags & BLK_MQ_F_BLOCKING) {
+		list_for_each_entry(q, &set->tag_list, tag_set_list)
+			wait_event(q->mq_quiesce_wq,
+				   percpu_ref_is_zero(&q->dispatch_counter));
+	} else {
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
 void blk_mq_wake_waiters(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index df642055f02c..90da3582b91d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -519,6 +519,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
+void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
+void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
 
-- 
2.25.2

