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
Subject: [PATCH RFC 4/4] scsi_mq: enable runtime PM
Date: Thu, 12 Jul 2018 00:29:06 +0800
Message-Id: <20180711162906.14271-5-ming.lei@redhat.com>
In-Reply-To: <20180711162906.14271-1-ming.lei@redhat.com>
References: <20180711162906.14271-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Usually SCSI supports runtime PM, so pass BLK_MQ_F_SUPPORT_RPM to blk-mq
core for enabling block runtime PM.

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
 block/blk-core.c        | 2 +-
 drivers/scsi/scsi_lib.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bf66d561980d..9e47205366ab 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3770,7 +3770,7 @@ EXPORT_SYMBOL(blk_finish_plug);
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
 	/* not support for RQF_PM and ->rpm_status in blk-mq yet */
-	if (q->mq_ops)
+	if (q->mq_ops && !(q->tag_set->flags & BLK_MQ_F_SUPPORT_RPM))
 		return;
 
 	q->dev = dev;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 41e9ac9fc138..fa4667aa4732 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2306,7 +2306,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	shost->tag_set.queue_depth = shost->can_queue;
 	shost->tag_set.cmd_size = cmd_size;
 	shost->tag_set.numa_node = NUMA_NO_NODE;
-	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
+		BLK_MQ_F_SG_MERGE | BLK_MQ_F_SUPPORT_RPM;
 	shost->tag_set.flags |=
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
 	shost->tag_set.driver_data = shost;
-- 
2.9.5
