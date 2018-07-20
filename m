Return-Path: <msnitzer@redhat.com>
From: Mike Snitzer <snitzer@redhat.com>
To: axboe@kernel.dk
Cc: hch@lst.de,
	dm-devel@redhat.com,
	linux-block@vger.kernel.org
Subject: [PATCH] block: allow max_discard_segments to be stacked
Date: Fri, 20 Jul 2018 14:57:38 -0400
Message-Id: <20180720185738.11646-1-snitzer@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Set max_discard_segments to USHRT_MAX in blk_set_stacking_limits() so
that blk_stack_limits() can stack up this limit for stacked devices.

before:

$ cat /sys/block/nvme0n1/queue/max_discard_segments
256
$ cat /sys/block/dm-0/queue/max_discard_segments
1

after:

$ cat /sys/block/nvme0n1/queue/max_discard_segments
256
$ cat /sys/block/dm-0/queue/max_discard_segments
256

Fixes: 1e739730c5b9e ("block: optionally merge discontiguous discard bios into a single request")
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index d1de71124656..24fff4a3d08a 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -128,7 +128,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 
 	/* Inherit limits from component devices */
 	lim->max_segments = USHRT_MAX;
-	lim->max_discard_segments = 1;
+	lim->max_discard_segments = USHRT_MAX;
 	lim->max_hw_sectors = UINT_MAX;
 	lim->max_segment_size = UINT_MAX;
 	lim->max_sectors = UINT_MAX;
-- 
2.18.0
