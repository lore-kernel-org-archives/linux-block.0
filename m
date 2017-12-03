Return-Path: <minwoo.im.dev@gmail.com>
Return-Path: <minwoo.im.dev@gmail.com>
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	Minwoo Im <dn3108@gmail.com>,
	Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] block: fix a comment typo in req_opf
Date: Sun,  3 Dec 2017 12:04:26 +0900
Message-Id: <1512270266-5118-1-git-send-email-minwoo.im.dev@gmail.com>
List-ID: <linux-block@vger.kernel.org>

fix a comment typo in "struct req_opf".
replace "seset" with "reset".

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 include/linux/blk_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a1e628e..eca5bf6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -195,7 +195,7 @@ enum req_opf {
 	REQ_OP_ZONE_REPORT	= 4,
 	/* securely erase sectors */
 	REQ_OP_SECURE_ERASE	= 5,
-	/* seset a zone write pointer */
+	/* reset a zone write pointer */
 	REQ_OP_ZONE_RESET	= 6,
 	/* write the same sector many times */
 	REQ_OP_WRITE_SAME	= 7,
-- 
2.7.4
