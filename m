Return-Path: <BATV+ba2ad3a85f904cdfeb6d+5080+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com,
	tomi.p.sarvela@intel.com,
	evangelos@foutrelis.com,
	linux-block@vger.kernel.org
Subject: [PATCH for-4.13] block: disable runtime-pm for blk-mq
Date: Fri, 21 Jul 2017 13:46:10 +0200
Message-Id: <20170721114610.25582-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The blk-mq code lacks support for looking at the rpm_status field, tracking
active requests and the RQF_PM flag.

Due to the default switch to blk-mq for scsi people start to run into
suspend / resume issue due to this fact, so make sure we disable the runtime
PM functionality until it is properly implemented.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 970b9c9638c5..dbecbf4a64e0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3421,6 +3421,10 @@ EXPORT_SYMBOL(blk_finish_plug);
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
+	/* not support for RQF_PM and ->rpm_status in blk-mq yet */
+	if (q->mq_ops)
+		return;
+
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;
 	pm_runtime_set_autosuspend_delay(q->dev, -1);
-- 
2.11.0
