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
Subject: [PATCH 25/55] skd: Check structure sizes at build time
Date: Thu, 17 Aug 2017 13:13:08 -0700
Message-Id: <20170817201338.16537-26-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch will help to verify the changes made by the next patch.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 6ba6103f53dd..e2d205b58fe2 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -4959,6 +4959,11 @@ static void skd_log_skreq(struct skd_device *skdev,
 
 static int __init skd_init(void)
 {
+	BUILD_BUG_ON(sizeof(struct fit_completion_entry_v1) != 8);
+	BUILD_BUG_ON(sizeof(struct fit_comp_error_info) != 32);
+	BUILD_BUG_ON(sizeof(struct skd_command_header) != 16);
+	BUILD_BUG_ON(sizeof(struct skd_scsi_request) != 32);
+	BUILD_BUG_ON(sizeof(struct driver_inquiry_data) != 44);
 	BUILD_BUG_ON(offsetof(struct skd_msg_buf, fmh) != 0);
 	BUILD_BUG_ON(offsetof(struct skd_msg_buf, scsi) != 64);
 	BUILD_BUG_ON(sizeof(struct skd_msg_buf) != SKD_N_FITMSG_BYTES);
-- 
2.14.0
