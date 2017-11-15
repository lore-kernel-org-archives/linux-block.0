Return-Path: <prvs=2492acfd3a=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, <Kernel-team@fb.com>,
        Tejun Heo
	<tj@kernel.org>
Subject: [PATCH] blk-throttle: allow configure 0 for some settings --resend
Date: Wed, 15 Nov 2017 15:27:29 -0800
Message-ID: <74e04440fa46aca5488912050395f2bc406f7afa.1510787708.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

For io.low, latency target 0 is legit. 0 for rbps/wbps/rios/wios is ok
too. And we use 0 to clear io.low settings.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 96ad326..7040285 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1633,7 +1633,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 			goto out_finish;
 
 		ret = -ERANGE;
-		if (!val)
+		if (!val && off != LIMIT_LOW)
 			goto out_finish;
 
 		ret = -EINVAL;
-- 
2.9.5
