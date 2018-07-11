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
Subject: [PATCH RFC 1/4] blk-mq: introduce blk_mq_support_runtime_pm()
Date: Thu, 12 Jul 2018 00:29:03 +0800
Message-Id: <20180711162906.14271-2-ming.lei@redhat.com>
In-Reply-To: <20180711162906.14271-1-ming.lei@redhat.com>
References: <20180711162906.14271-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

A bit cost has to be added in fast IO path for supporting runtime PM, and
introduce this helper so that drivers incapable of runtime PM may not be
affected by this feature.

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
 include/linux/blk-mq.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d710e92874cc..998ad6602448 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -180,6 +180,7 @@ enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
+	BLK_MQ_F_SUPPORT_RPM	= 1 << 3,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
@@ -249,6 +250,15 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 	return unique_tag & BLK_MQ_UNIQUE_TAG_MASK;
 }
 
+static inline bool blk_mq_support_runtime_pm(struct request_queue *q)
+{
+	struct blk_mq_tag_set *set = q->tag_set;
+
+	if (!q->dev || !set || !(set->flags & BLK_MQ_F_SUPPORT_RPM))
+		return false;
+
+	return true;
+}
 
 int blk_mq_request_started(struct request *rq);
 void blk_mq_start_request(struct request *rq);
-- 
2.9.5
