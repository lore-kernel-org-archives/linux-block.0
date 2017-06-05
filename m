Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751238AbdFEQBB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jun 2017 12:01:01 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 03/11] blk-mq: introduce blk_mq_quiesce_queue_nowait()
Date: Mon,  5 Jun 2017 23:59:17 +0800
Message-Id: <20170605155925.7896-4-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-1-ming.lei@redhat.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch introduces blk_mq_quiesce_queue_nowait() so
that we can workaround mpt3sas for quiescing its queue.

Once mpt3sas is fixed, we can remove this helper.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk-mq.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1e480015d172..13d1196f492f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -266,6 +266,14 @@ int blk_mq_map_queues(struct blk_mq_tag_set *set);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 /*
+ * FIXME: this helper is just for working around mpt3sas.
+ */
+static inline void blk_mq_quiesce_queue_nowait(struct request_queue *q)
+{
+	blk_mq_stop_hw_queues(q);
+}
+
+/*
  * Driver command data is immediately after the request. So subtract request
  * size to get back to the original request, add request size to get the PDU.
  */
-- 
2.9.4
