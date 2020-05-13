Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2CEC2D0F8
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052DD206F5
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7+WeNIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgEMDtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 23:49:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36085 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728669AbgEMDtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 23:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589341758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YFwNFbvN8lXiw5io30W1wc29b7T/2QA1xOMLcFcuIUc=;
        b=g7+WeNImJz7eghFb38HlxkhgQ0PKQJ6yNDvubCAwvqWi4bfJGOsGDEVX5IJxtR0E0OVhSP
        Z3wcJcR3qsUOSEiCXQwshCXY+tOrYbPm/edJXrA2eOlSjgoY2wisjiTjt9kCvTYvdtTdTo
        KXzno+i+iG6XCqoXp3+unK9h37Fv7mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-0AjD-BFxPK2C3Agk4poDGg-1; Tue, 12 May 2020 23:49:16 -0400
X-MC-Unique: 0AjD-BFxPK2C3Agk4poDGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8DE1107ACCA;
        Wed, 13 May 2020 03:49:14 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AE716A960;
        Wed, 13 May 2020 03:49:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V11 09/12] blk-mq: add blk_mq_hctx_handle_dead_cpu for handling cpu dead
Date:   Wed, 13 May 2020 11:48:00 +0800
Message-Id: <20200513034803.1844579-10-ming.lei@redhat.com>
In-Reply-To: <20200513034803.1844579-1-ming.lei@redhat.com>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add helper of blk_mq_hctx_handle_dead_cpu for handling cpu dead,
and prepare for handling inactive hctx.

No functional change.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 171bbf2fbc56..7c640482fb24 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2402,22 +2402,13 @@ static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-/*
- * 'cpu' is going away. splice any existing rq_list entries from this
- * software queue to the hw queue dispatch list, and ensure that it
- * gets run.
- */
-static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
+static void blk_mq_hctx_handle_dead_cpu(struct blk_mq_hw_ctx *hctx,
+		unsigned int cpu)
 {
-	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
-			struct blk_mq_hw_ctx, cpuhp_dead);
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
 	enum hctx_type type;
 
-	if (!cpumask_test_cpu(cpu, hctx->cpumask))
-		return 0;
-
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
 	type = hctx->type;
 
@@ -2429,13 +2420,27 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	spin_unlock(&ctx->lock);
 
 	if (list_empty(&tmp))
-		return 0;
+		return;
 
 	spin_lock(&hctx->lock);
 	list_splice_tail_init(&tmp, &hctx->dispatch);
 	spin_unlock(&hctx->lock);
 
 	blk_mq_run_hw_queue(hctx, true);
+}
+
+/*
+ * 'cpu' is going away. splice any existing rq_list entries from this
+ * software queue to the hw queue dispatch list, and ensure that it
+ * gets run.
+ */
+static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
+{
+	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_dead);
+
+	if (cpumask_test_cpu(cpu, hctx->cpumask))
+		blk_mq_hctx_handle_dead_cpu(hctx, cpu);
 	return 0;
 }
 
-- 
2.25.2

