Return-Path: <BATV+df5a2477ff0fa86e9985+5386+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Rafael David Tinoco <rafael.tinoco@canonical.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 10/14] block: remove BLK_EH_HANDLED
Date: Wed, 23 May 2018 14:19:37 +0200
Message-Id: <20180523121941.8632-11-hch@lst.de>
In-Reply-To: <20180523121941.8632-1-hch@lst.de>
References: <20180523121941.8632-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/scsi/scsi_eh.txt | 11 -----------
 block/blk-mq.c                 |  3 ---
 block/blk-timeout.c            |  3 ---
 include/linux/blkdev.h         |  1 -
 4 files changed, 18 deletions(-)

diff --git a/Documentation/scsi/scsi_eh.txt b/Documentation/scsi/scsi_eh.txt
index 3ae8419e72cf..1b7436932a2b 100644
--- a/Documentation/scsi/scsi_eh.txt
+++ b/Documentation/scsi/scsi_eh.txt
@@ -82,17 +82,6 @@ function
  1. invokes optional hostt->eh_timed_out() callback.  Return value can
     be one of
 
-    - BLK_EH_HANDLED
-	This indicates that eh_timed_out() dealt with the timeout.
-	The command is passed back to the block layer and completed
-	via __blk_complete_requests().
-
-	*NOTE* After returning BLK_EH_HANDLED the SCSI layer is
-	assumed to be finished with the command, and no other
-	functions from the SCSI layer will be called. So this
-	should typically only be returned if the eh_timed_out()
-	handler raced with normal completion.
-
     - BLK_EH_RESET_TIMER
 	This indicates that more time is required to finish the
 	command.  Timer is restarted.  This action is counted as a
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 546acc8cb201..22ab2a148a9b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -844,9 +844,6 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		ret = ops->timeout(req, reserved);
 
 	switch (ret) {
-	case BLK_EH_HANDLED:
-		__blk_mq_complete_request(req);
-		break;
 	case BLK_EH_RESET_TIMER:
 		/*
 		 * As nothing prevents from completion happening while
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 3c622335811f..aae8f233341b 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -86,9 +86,6 @@ static void blk_rq_timed_out(struct request *req)
 	if (q->rq_timed_out_fn)
 		ret = q->rq_timed_out_fn(req);
 	switch (ret) {
-	case BLK_EH_HANDLED:
-		__blk_complete_request(req);
-		break;
 	case BLK_EH_RESET_TIMER:
 		blk_add_timer(req);
 		blk_clear_rq_complete(req);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ba0844c176f2..3d9d4da4dedd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -338,7 +338,6 @@ typedef void (exit_rq_fn)(struct request_queue *, struct request *);
 
 enum blk_eh_timer_return {
 	BLK_EH_DONE,
-	BLK_EH_HANDLED,
 	BLK_EH_RESET_TIMER,
 };
 
-- 
2.17.0
