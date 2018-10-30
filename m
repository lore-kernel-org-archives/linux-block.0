Return-Path: <prvs=834be3197=sblbir@amzn.com>
From: Balbir Singh <sblbir@amzn.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Balbir
 Singh" <sblbir@amzn.com>
Subject: [PATCH] Add cmd_flags to print_req_error
Date: Tue, 30 Oct 2018 02:40:15 +0000
Message-ID: <20181030024015.1092-1-sblbir@amzn.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

I ran into a bug where after hibernation due to incompatible
backends, the block driver returned BLK_STS_NOTSUPP, with the
current message it's hard to find out what the command flags
were. Adding req->cmd_flags help make the problem easier to
diagnose.

Signed-off-by: Balbir Singh <sblbir@amzn.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---

Testing: Compile tested at my end

Changelog
  - convert %llx to %x and remove casting to unsigned long long

 block/blk-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cdfabc5646da..0fd6104bb0d2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -256,10 +256,11 @@ static void print_req_error(struct request *req, blk_status_t status)
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
 		return;
 
-	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu\n",
-			   __func__, blk_errors[idx].name, req->rq_disk ?
-			   req->rq_disk->disk_name : "?",
-			   (unsigned long long)blk_rq_pos(req));
+	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %x\n",
+				__func__, blk_errors[idx].name,
+				req->rq_disk ?  req->rq_disk->disk_name : "?",
+				(unsigned long long)blk_rq_pos(req),
+				req->cmd_flags);
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
-- 
2.16.2
