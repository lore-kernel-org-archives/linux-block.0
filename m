Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH RFC 2/4] blk-mq: introduce blk_mq_pm_queue_idle()
Date: Thu, 12 Jul 2018 00:29:04 +0800
Message-Id: <20180711162906.14271-3-ming.lei@redhat.com>
In-Reply-To: <20180711162906.14271-1-ming.lei@redhat.com>
References: <20180711162906.14271-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This helper will be used to decide if this block device can be
put into runtime suspend.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 22 ++++++++++++++++++++++
 block/blk-mq.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 73a43b81b17d..3a78fed87959 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -58,6 +58,28 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 	return bucket;
 }
 
+static void blk_mq_pm_check_idle(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, void *priv, bool reserved)
+{
+	unsigned long *cnt = priv;
+
+	if (!(rq->rq_flags & RQF_PM))
+		(*cnt)++;
+}
+
+bool blk_mq_pm_queue_idle(struct request_queue *q)
+{
+	unsigned long idle_cnt;
+
+	if (!blk_mq_support_runtime_pm(q))
+		return false;
+
+	idle_cnt = 0;
+	blk_mq_queue_tag_busy_iter(q, blk_mq_pm_check_idle, &idle_cnt);
+
+	return idle_cnt == 0;
+}
+
 /*
  * Check if any of the ctx's have pending work in this hardware queue
  */
diff --git a/block/blk-mq.h b/block/blk-mq.h
index bc2b24735ed4..b64f6f69176a 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -88,6 +88,9 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_release(struct request_queue *q);
 
+/* blk-mq pm helpers */
+bool blk_mq_pm_queue_idle(struct request_queue *q);
+
 /**
  * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
  * @rq: target request.
-- 
2.9.5
