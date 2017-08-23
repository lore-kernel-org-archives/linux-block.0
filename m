Return-Path: <prvs=401b34db8=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/5] skd: Report completion mismatches once
Date: Wed, 23 Aug 2017 10:56:30 -0700
Message-Id: <20170823175633.12680-3-bart.vanassche@wdc.com>
In-Reply-To: <20170823175633.12680-1-bart.vanassche@wdc.com>
References: <20170823175633.12680-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch removes one debug statement but otherwise does not change
any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index a467c18cc047..d21fc76c5ed9 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -1564,17 +1564,11 @@ static int skd_isr_completion_posted(struct skd_device *skdev,
 		 * Make sure the request ID for the slot matches.
 		 */
 		if (skreq->id != req_id) {
-			dev_dbg(&skdev->pdev->dev,
-				"mismatch comp_id=0x%x req_id=0x%x\n", req_id,
-				skreq->id);
-			{
-				u16 new_id = cmp_cntxt;
-				dev_err(&skdev->pdev->dev,
-					"Completion mismatch comp_id=0x%04x skreq=0x%04x new=0x%04x\n",
-					req_id, skreq->id, new_id);
+			dev_err(&skdev->pdev->dev,
+				"Completion mismatch comp_id=0x%04x skreq=0x%04x new=0x%04x\n",
+				req_id, skreq->id, cmp_cntxt);
 
-				continue;
-			}
+			continue;
 		}
 
 		SKD_ASSERT(skreq->state == SKD_REQ_STATE_BUSY);
-- 
2.14.0
