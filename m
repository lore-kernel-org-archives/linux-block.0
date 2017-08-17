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
Subject: [PATCH 11/55] skd: Fix a function name in a comment
Date: Thu, 17 Aug 2017 13:12:54 -0700
Message-Id: <20170817201338.16537-12-bart.vanassche@wdc.com>
In-Reply-To: <20170817201338.16537-1-bart.vanassche@wdc.com>
References: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

There is no function skd_completion_posted_isr() in the skd driver
but there is a function called skd_isr_completion_posted(). Fix
the function name in the comment.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 6c7cf5327d22..5a88116efc97 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2790,7 +2790,7 @@ static void skd_complete_other(struct skd_device *skdev,
 	switch (req_table) {
 	case SKD_ID_RW_REQUEST:
 		/*
-		 * The caller, skd_completion_posted_isr() above,
+		 * The caller, skd_isr_completion_posted() above,
 		 * handles r/w requests. The only way we get here
 		 * is if the req_slot is out of bounds.
 		 */
-- 
2.14.0
