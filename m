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
Subject: [PATCH 17/55] skd: Document locking assumptions
Date: Thu, 17 Aug 2017 13:13:00 -0700
Message-Id: <20170817201338.16537-18-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 5a69e3288ab7..5c69e9210a62 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -1894,6 +1894,8 @@ static void skd_complete_internal(struct skd_device *skdev,
 	struct skd_scsi_request *scsi =
 		(struct skd_scsi_request *)&skspcl->msg_buf[64];
 
+	lockdep_assert_held(&skdev->lock);
+
 	SKD_ASSERT(skspcl == &skdev->internal_skspcl);
 
 	dev_dbg(&skdev->pdev->dev, "complete internal %x\n", scsi->cdb[0]);
@@ -2564,6 +2566,8 @@ static int skd_isr_completion_posted(struct skd_device *skdev,
 	int rc = 0;
 	int processed = 0;
 
+	lockdep_assert_held(&skdev->lock);
+
 	for (;; ) {
 		SKD_ASSERT(skdev->skcomp_ix < SKD_N_COMPLETION_ENTRY);
 
@@ -2701,6 +2705,8 @@ static void skd_complete_other(struct skd_device *skdev,
 	u32 req_slot;
 	struct skd_special_context *skspcl;
 
+	lockdep_assert_held(&skdev->lock);
+
 	req_id = skcomp->tag;
 	req_table = req_id & SKD_ID_TABLE_MASK;
 	req_slot = req_id & SKD_ID_SLOT_MASK;
@@ -2774,6 +2780,8 @@ static void skd_complete_special(struct skd_device *skdev,
 				 volatile struct fit_comp_error_info *skerr,
 				 struct skd_special_context *skspcl)
 {
+	lockdep_assert_held(&skdev->lock);
+
 	dev_dbg(&skdev->pdev->dev, " completing special request %p\n", skspcl);
 	if (skspcl->orphaned) {
 		/* Discard orphaned request */
-- 
2.14.0
