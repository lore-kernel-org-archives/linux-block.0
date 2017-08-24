Return-Path: <SRS0=2VWl=72=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V2 1/2] block/loop: set hw_sectors
Date: Thu, 24 Aug 2017 12:24:52 -0700
Message-Id: <92dafefc8c0b64eaaf51298734ebe4aa7d880046.1503602376.git.shli@fb.com>
In-Reply-To: <cover.1503602376.git.shli@fb.com>
References: <cover.1503602376.git.shli@fb.com>
In-Reply-To: <cover.1503602376.git.shli@fb.com>
References: <cover.1503602376.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Loop can handle any size of request. Limiting it to 255 sectors just
burns the CPU for bio split and request merge for underlayer disk and
also cause bad fs block allocation in directio mode.

Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b55a1f8..428da07 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1799,6 +1799,7 @@ static int loop_add(struct loop_device **l, int i)
 	}
 	lo->lo_queue->queuedata = lo;
 
+	blk_queue_max_hw_sectors(lo->lo_queue, BLK_DEF_MAX_SECTORS);
 	/*
 	 * It doesn't make sense to enable merge because the I/O
 	 * submitted to backing file is handled page by page.
-- 
2.9.5
