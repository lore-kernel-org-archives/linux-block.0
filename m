Return-Path: <prvs=8337b9ad9=sblbir@amazon.com>
From: Balbir Singh <sblbir@amazon.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Balbir
 Singh" <sblbir@amazon.com>
Subject: [PATCH] Add cmd_flags to print_req_error
Date: Mon, 29 Oct 2018 00:57:32 +0000
Message-ID: <20181029005732.21040-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

I ran into a bug where after hibernation due to incompatible
backends, the block driver returned BLK_STS_NOTSUPP, with the
current message it's hard to find out what the command flags
were. Adding req->cmd_flags help make the problem easier to
diagnose.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---

The patch has been just compile tested only.

 block/blk-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cdfabc5646da..28b8f93835a7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -256,10 +256,11 @@ static void print_req_error(struct request *req, blk_status_t status)
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
 		return;
 
-	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu\n",
-			   __func__, blk_errors[idx].name, req->rq_disk ?
-			   req->rq_disk->disk_name : "?",
-			   (unsigned long long)blk_rq_pos(req));
+	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %llx\n",
+				__func__, blk_errors[idx].name,
+				req->rq_disk ?  req->rq_disk->disk_name : "?",
+				(unsigned long long)blk_rq_pos(req),
+				(unsigned long long)req->cmd_flags);
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
-- 
2.16.2
