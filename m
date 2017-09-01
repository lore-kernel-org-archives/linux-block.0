Return-Path: <SRS0=upyn=AC=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V3 1/2] block/loop: set hw_sectors
Date: Thu, 31 Aug 2017 22:09:45 -0700
Message-Id: <db12e0cf1ce5806c95003ba352c2d39107b205d9.1504240556.git.shli@fb.com>
In-Reply-To: <cover.1504240556.git.shli@fb.com>
References: <cover.1504240556.git.shli@fb.com>
In-Reply-To: <cover.1504240556.git.shli@fb.com>
References: <cover.1504240556.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Loop can handle any size of request. Limiting it to 255 sectors just
burns the CPU for bio split and request merge for underlayer disk and
also cause bad fs block allocation in directio mode.

Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f6c204f6..9eff4d3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1736,6 +1736,7 @@ static int loop_add(struct loop_device **l, int i)
 
 	blk_queue_physical_block_size(lo->lo_queue, PAGE_SIZE);
 
+	blk_queue_max_hw_sectors(lo->lo_queue, BLK_DEF_MAX_SECTORS);
 	/*
 	 * It doesn't make sense to enable merge because the I/O
 	 * submitted to backing file is handled page by page.
-- 
2.9.5
