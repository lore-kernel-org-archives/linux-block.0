Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 25/28] block: kill request slab cache
Date: Thu, 25 Oct 2018 15:10:36 -0600
Message-Id: <20181025211039.11559-26-axboe@kernel.dk>
In-Reply-To: <20181025211039.11559-1-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c | 8 --------
 block/blk.h      | 1 -
 2 files changed, 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e8f60ed456a2..6074bf2ee2e7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -57,11 +57,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(block_unplug);
 
 DEFINE_IDA(blk_queue_ida);
 
-/*
- * For the allocated request tables
- */
-struct kmem_cache *request_cachep;
-
 /*
  * For queue allocation
  */
@@ -1941,9 +1936,6 @@ int __init blk_dev_init(void)
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
-	request_cachep = kmem_cache_create("blkdev_requests",
-			sizeof(struct request), 0, SLAB_PANIC, NULL);
-
 	blk_requestq_cachep = kmem_cache_create("request_queue",
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
 
diff --git a/block/blk.h b/block/blk.h
index e925cf4fe4de..2bf1cfeeb9c0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -32,7 +32,6 @@ struct blk_flush_queue {
 };
 
 extern struct kmem_cache *blk_requestq_cachep;
-extern struct kmem_cache *request_cachep;
 extern struct kobj_type blk_queue_ktype;
 extern struct ida blk_queue_ida;
 
-- 
2.17.1
