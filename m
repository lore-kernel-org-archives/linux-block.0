Return-Path: <BATV+a01a3e67072ae75c0352+5392+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 13/14] block: document the blk_eh_timer_return values
Date: Tue, 29 May 2018 15:52:38 +0200
Message-Id: <20180529135239.27005-14-hch@lst.de>
In-Reply-To: <20180529135239.27005-1-hch@lst.de>
References: <20180529135239.27005-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 include/linux/blkdev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d838a89639f2..9f06b29adaa4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -326,8 +326,8 @@ typedef int (init_rq_fn)(struct request_queue *, struct request *, gfp_t);
 typedef void (exit_rq_fn)(struct request_queue *, struct request *);
 
 enum blk_eh_timer_return {
-	BLK_EH_DONE,
-	BLK_EH_RESET_TIMER,
+	BLK_EH_DONE,		/* drivers has completed the command */
+	BLK_EH_RESET_TIMER,	/* reset timer and try again */
 };
 
 typedef enum blk_eh_timer_return (rq_timed_out_fn)(struct request *);
-- 
2.17.0
