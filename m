Return-Path: <rdunlap@infradead.org>
To: linux-block@vger.kernel.org, axboe <axboe@kernel.dk>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] block: genhd.c: fix message typo
Message-ID: <68b919d0-870f-feb4-d92f-03ae3ed77dce@infradead.org>
Date: Sat, 18 Nov 2017 17:43:38 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix typo in error message.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 block/genhd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-414.orig/block/genhd.c
+++ lnx-414/block/genhd.c
@@ -1367,7 +1367,7 @@ struct gendisk *alloc_disk_node(int mino
 
 	if (minors > DISK_MAX_PARTS) {
 		printk(KERN_ERR
-			"block: can't allocated more than %d partitions\n",
+			"block: can't allocate more than %d partitions\n",
 			DISK_MAX_PARTS);
 		minors = DISK_MAX_PARTS;
 	}
