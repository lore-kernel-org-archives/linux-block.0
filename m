Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Shaohua Li <shli@fb.com>
Subject: [PATCH] blk-throttle: Suppress a compiler warning
Date: Wed, 19 Apr 2017 16:55:04 -0700
Message-ID: <20170419235504.5463-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Avoid that the following warning is reported when building with
W=1 and with CONFIG_BLK_DEV_THROTTLING_LOW=n:

block/blk-throttle.c: In function ‘blk_throtl_bio’:
block/blk-throttle.c:2042:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
  int ret;
      ^~~

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c82bf9b1fe72..9081ed9a5345 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2059,6 +2059,10 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (ret == 0 || ret == -EBUSY)
 		bio->bi_cg_private = tg;
 	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
+#else
+	/* Avoid that the compiler complains about not using ret */
+	if (ret) {
+	}
 #endif
 	blk_throtl_update_idletime(tg);
 
-- 
2.12.2
