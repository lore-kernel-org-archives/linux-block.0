Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] block: remove remnant refs to hardsect
Date: Wed, 14 Sep 2016 14:32:52 +0200
Message-Id: <1473856372-22204-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

commit e1defc4ff0cf57aca6c5e3ff99fa503f5943c1f1
"block: Do away with the notion of hardsect_size"
removed the notion of "hardware sector size" from
the kernel in favor of logical block size, but
references remain in comments and documentation.

Update the remaining sites mentioning hardsect.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/block/biodoc.txt | 4 ++--
 block/bio.c                    | 2 +-
 fs/befs/linuxvfs.c             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
index bcdb2b4c1f12..918e1e0d0e78 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -115,7 +115,7 @@ i. Per-queue limits/values exported to the generic layer by the driver
 
 Various parameters that the generic i/o scheduler logic uses are set at
 a per-queue level (e.g maximum request size, maximum number of segments in
-a scatter-gather list, hardsect size)
+a scatter-gather list, logical block size)
 
 Some parameters that were earlier available as global arrays indexed by
 major/minor are now directly associated with the queue. Some of these may
@@ -156,7 +156,7 @@ Some new queue property settings:
 	blk_queue_max_segment_size(q, max_seg_size)
 		Maximum size of a clustered segment, 64kB default.
 
-	blk_queue_hardsect_size(q, hardsect_size)
+	blk_queue_logical_block_size(q, logical_block_size)
 		Lowest possible sector size that the hardware can operate
 		on, 512 bytes default.
 
diff --git a/block/bio.c b/block/bio.c
index aa7354088008..a6d279e1ea9e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1274,7 +1274,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 
 		nr_pages += end - start;
 		/*
-		 * buffer must be aligned to at least hardsector size for now
+		 * buffer must be aligned to at least logical block size for now
 		 */
 		if (uaddr & queue_dma_alignment(q))
 			return ERR_PTR(-EINVAL);
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 7da05b159ade..bfe9f9994935 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -789,7 +789,7 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 	 * Will be set to real fs blocksize later.
 	 *
 	 * Linux 2.4.10 and later refuse to read blocks smaller than
-	 * the hardsect size for the device. But we also need to read at 
+	 * the logical block size for the device. But we also need to read at
 	 * least 1k to get the second 512 bytes of the volume.
 	 * -WD 10-26-01
 	 */ 
-- 
2.7.4
