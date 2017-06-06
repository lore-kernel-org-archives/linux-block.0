Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751281AbdFFPX0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 11:23:26 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 04/12] blk-mq: introduce blk_mq_quiesce_queue_nowait()
Date: Tue,  6 Jun 2017 23:22:02 +0800
Message-Id: <20170606152210.22806-5-ming.lei@redhat.com>
In-Reply-To: <20170606152210.22806-1-ming.lei@redhat.com>
References: <20170606152210.22806-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch introduces blk_mq_quiesce_queue_nowait() so
that we can workaround mpt3sas for quiescing its queue.

Once mpt3sas is fixed, we can remove this helper.

Reviewed-by: Bart Van Assche <Bart.VanAssche@sandisk.com>
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
