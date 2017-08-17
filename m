Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 30/55] skd: Remove superfluous initializations from skd_isr_completion_posted()
Date: Thu, 17 Aug 2017 13:13:13 -0700
Message-Id: <20170817201338.16537-31-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The value of skcmp, cmp_cntxt etc. is overwritten during every
loop iteration and is not used after the loop has finished. Hence
initializing these variables outside the loop is not necessary.
This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index e54089315a7a..008fa7231159 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2509,16 +2509,16 @@ static void skd_process_scsi_inq(struct skd_device *skdev,
 static int skd_isr_completion_posted(struct skd_device *skdev,
 					int limit, int *enqueued)
 {
-	volatile struct fit_completion_entry_v1 *skcmp = NULL;
+	volatile struct fit_completion_entry_v1 *skcmp;
 	volatile struct fit_comp_error_info *skerr;
 	u16 req_id;
 	u32 req_slot;
 	struct skd_request_context *skreq;
-	u16 cmp_cntxt = 0;
-	u8 cmp_status = 0;
-	u8 cmp_cycle = 0;
-	u32 cmp_bytes = 0;
-	int rc = 0;
+	u16 cmp_cntxt;
+	u8 cmp_status;
+	u8 cmp_cycle;
+	u32 cmp_bytes;
+	int rc;
 	int processed = 0;
 
 	lockdep_assert_held(&skdev->lock);
-- 
2.14.0
