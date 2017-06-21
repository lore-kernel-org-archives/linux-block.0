Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@wdc.com>, Hannes Reinecke <hare@suse.com>, Ming Lei
	<ming.lei@redhat.com>
Subject: [PATCH 2/3] block: Fix off-by-one errors in blk_status_to_errno() and print_req_error()
Date: Wed, 21 Jun 2017 10:55:46 -0700
Message-ID: <20170621175547.21692-3-bart.vanassche@wdc.com>
In-Reply-To: <20170621175547.21692-1-bart.vanassche@wdc.com>
References: <20170621175547.21692-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@wdc.com
List-ID: <linux-block@vger.kernel.org>

This was detected by the smatch static analyzer.

Fixes: commit 2a842acab109 ("block: introduce new block status code type")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2e02314ea331..3c18ea60cb1c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -169,7 +169,7 @@ int blk_status_to_errno(blk_status_t status)
 {
 	int idx = (__force int)status;
 
-	if (WARN_ON_ONCE(idx > ARRAY_SIZE(blk_errors)))
+	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
 		return -EIO;
 	return blk_errors[idx].errno;
 }
@@ -179,7 +179,7 @@ static void print_req_error(struct request *req, blk_status_t status)
 {
 	int idx = (__force int)status;
 
-	if (WARN_ON_ONCE(idx > ARRAY_SIZE(blk_errors)))
+	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
 		return;
 
 	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu\n",
-- 
2.13.1
