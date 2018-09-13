Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH V3 04/17] blk-mq: don't reserve tags for admin queue
Date: Thu, 13 Sep 2018 20:15:33 +0800
Message-Id: <20180913121546.5710-5-ming.lei@redhat.com>
In-Reply-To: <20180913121546.5710-1-ming.lei@redhat.com>
References: <20180913121546.5710-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Not necessary to reserve tags for admin queue since there isn't
many inflight commands in admin queue usually.

This change won't starve admin queue too because each blocked queue
has equal priority to get one new tag when one driver tag is released,
no matter it is freed from any queue.

So that IO performance won't be affected after admin queue(shared tags
with IO queues) is introduced in the following patches.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 94e1ed667b6e..7b0390f1c764 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -30,7 +30,8 @@ bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
 bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
-	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
+	    !blk_queue_admin(hctx->queue))
 		atomic_inc(&hctx->tags->active_queues);
 
 	return true;
@@ -57,7 +58,8 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 		return;
 
-	atomic_dec(&tags->active_queues);
+	if (!blk_queue_admin(hctx->queue))
+		atomic_dec(&tags->active_queues);
 
 	blk_mq_tag_wakeup_all(tags, false);
 }
@@ -82,6 +84,12 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 	if (bt->sb.depth == 1)
 		return true;
 
+	/*
+	 * Needn't to deal with admin queue specially here even though we
+	 * don't take it account to tags->active_queues, so blk_queue_admin()
+	 * can be avoided to check in the fast path, also with implicit benefit
+	 * of avoiding too many in-flight admin requests
+	 */
 	users = atomic_read(&hctx->tags->active_queues);
 	if (!users)
 		return true;
-- 
2.9.5
