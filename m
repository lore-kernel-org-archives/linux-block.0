Return-Path: <houtao1@huawei.com>
From: Hou Tao <houtao1@huawei.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>
Subject: [PATCH] block: use put_io_context_active() to disassociate bio from a task
Date: Fri, 3 Mar 2017 15:01:10 +0800
Message-ID: <1488524470-570-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

bio_associate_current() invokes get_io_context_active() to tell
CFQ scheduler that the current io_context is still issuing IOs
by increasing active_ref. When the bio is done, we also need
to invoke put_io_context_active() to decrease active_ref else
the associated io_context will always be active.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 5eec5e0..d8ed36f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2072,7 +2072,7 @@ EXPORT_SYMBOL_GPL(bio_associate_current);
 void bio_disassociate_task(struct bio *bio)
 {
 	if (bio->bi_ioc) {
-		put_io_context(bio->bi_ioc);
+		put_io_context_active(bio->bi_ioc);
 		bio->bi_ioc = NULL;
 	}
 	if (bio->bi_css) {
-- 
2.5.0
