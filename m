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
Subject: [PATCH 28/55] skd: Use ARRAY_SIZE() where appropriate
Date: Thu, 17 Aug 2017 13:13:11 -0700
Message-Id: <20170817201338.16537-29-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Use ARRAY_SIZE() instead of open-coding it. This patch does not
change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 7d5048d95037..96d7b43cfcf2 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2160,7 +2160,7 @@ static enum skd_check_status_action
 skd_check_status(struct skd_device *skdev,
 		 u8 cmp_status, volatile struct fit_comp_error_info *skerr)
 {
-	int i, n;
+	int i;
 
 	dev_err(&skdev->pdev->dev, "key/asc/ascq/fruc %02x/%02x/%02x/%02x\n",
 		skerr->key, skerr->code, skerr->qual, skerr->fruc);
@@ -2171,8 +2171,7 @@ skd_check_status(struct skd_device *skdev,
 		skerr->fruc);
 
 	/* Does the info match an entry in the good category? */
-	n = sizeof(skd_chkstat_table) / sizeof(skd_chkstat_table[0]);
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < ARRAY_SIZE(skd_chkstat_table); i++) {
 		struct sns_info *sns = &skd_chkstat_table[i];
 
 		if (sns->mask & 0x10)
-- 
2.14.0
