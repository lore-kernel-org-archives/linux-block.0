Return-Path: <SRS0=1zCZ=7Z=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: [PATCH 1/2] block/loop: set hw_sectors
Date: Wed, 23 Aug 2017 16:49:23 -0700
Message-Id: <3742ed80f48b4ca55ad4ed7dcee6a667f0e82024.1503531709.git.shli@fb.com>
In-Reply-To: <cover.1503531709.git.shli@fb.com>
References: <cover.1503531709.git.shli@fb.com>
In-Reply-To: <cover.1503531709.git.shli@fb.com>
References: <cover.1503531709.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Loop can handle any size of request. Limiting it to 255 sectors just
burns the CPU for bio split and request merge for underlayer disk and
also cause bad fs block allocation in directio mode.

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
