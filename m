Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F520C76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 03:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC4F2070D
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 03:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfGXDtF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 23:49:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfGXDtE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 23:49:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D0C030BD1C6;
        Wed, 24 Jul 2019 03:49:04 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFE9819C58;
        Wed, 24 Jul 2019 03:49:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 2/5] blk-mq: introduce blk_mq_tagset_wait_completed_request()
Date:   Wed, 24 Jul 2019 11:48:40 +0800
Message-Id: <20190724034843.10879-3-ming.lei@redhat.com>
In-Reply-To: <20190724034843.10879-1-ming.lei@redhat.com>
References: <20190724034843.10879-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 24 Jul 2019 03:49:04 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq may schedule to call queue's complete function on remote CPU via
IPI, but doesn't provide any way to synchronize the request's complete
fn. The current queue freeze interface can't provide the synchonization
because aborted requests stay at blk-mq queues during EH.

In some driver's EH(such as NVMe), hardware queue's resource may be freed &
re-allocated. If the completed request's complete fn is run finally after the
hardware queue's resource is released, kernel crash will be triggered.

Prepare for fixing this kind of issue by introducing
blk_mq_tagset_wait_completed_request().

Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c     | 32 ++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index da19f0bc8876..008388e82b5c 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 
 #include <linux/blk-mq.h>
+#include <linux/delay.h>
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
@@ -354,6 +355,37 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
+static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
+		void *data, bool reserved)
+{
+	unsigned *count = data;
+
+	if (blk_mq_request_completed(rq))
+		(*count)++;
+	return true;
+}
+
+/**
+ * blk_mq_tagset_wait_completed_request - wait until all completed req's
+ * complete funtion is run
+ * @tagset:	Tag set to drain completed request
+ *
+ * Note: This function has to be run after all IO queues are shutdown
+ */
+void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset)
+{
+	while (true) {
+		unsigned count = 0;
+
+		blk_mq_tagset_busy_iter(tagset,
+				blk_mq_tagset_count_completed_rqs, &count);
+		if (!count)
+			break;
+		msleep(5);
+	}
+}
+EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
+
 /**
  * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
  * @q:		Request queue to examine.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index cc5115ca0e19..f9f722aeb535 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -329,6 +329,7 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
+void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
-- 
2.20.1

