Return-Path: <SRS0=upyn=AC=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V2 2/2] block/loop: remove unused field
Date: Fri,  1 Sep 2017 11:15:18 -0700
Message-Id: <1466858c1c2a9e20ea9bd7fd30c1d2f4d1d5eeca.1504289520.git.shli@fb.com>
In-Reply-To: <1a1c70b8fd5044e11bd152686a742a017ebea99e.1504289520.git.shli@fb.com>
References: <1a1c70b8fd5044e11bd152686a742a017ebea99e.1504289520.git.shli@fb.com>
In-Reply-To: <1a1c70b8fd5044e11bd152686a742a017ebea99e.1504289520.git.shli@fb.com>
References: <1a1c70b8fd5044e11bd152686a742a017ebea99e.1504289520.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

nobody uses the list.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index b0ba4a5..f68c1d5 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -67,7 +67,6 @@ struct loop_device {
 struct loop_cmd {
 	struct kthread_work work;
 	struct request *rq;
-	struct list_head list;
 	union {
 		bool use_aio; /* use AIO interface to handle I/O */
 		atomic_t ref; /* only for aio */
-- 
2.9.5
