Return-Path: <prvs=6312870a7a=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <Kernel-team@fb.com>
Subject: [PATCH] blktrace: fix integer parse
Date: Fri, 19 May 2017 08:04:59 -0700
Message-ID: <3ceaaf95edea4e3f506f1e458323ceef5886f955.1495169957.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

sscanf is a very poor way to parse integer. For example, I input
"discard" for act_mask, it gets 0xd and completely messes up. Using
correct API to do integer parse.

This patch also makes attributes accept any base of integer.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 kernel/trace/blktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index bd8ae8d..193c5f5 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1662,14 +1662,14 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 		goto out;
 
 	if (attr == &dev_attr_act_mask) {
-		if (sscanf(buf, "%llx", &value) != 1) {
+		if (kstrtoull(buf, 0, &value)) {
 			/* Assume it is a list of trace category names */
 			ret = blk_trace_str2mask(buf);
 			if (ret < 0)
 				goto out;
 			value = ret;
 		}
-	} else if (sscanf(buf, "%llu", &value) != 1)
+	} else if (kstrtoull(buf, 0, &value))
 		goto out;
 
 	ret = -ENXIO;
-- 
2.9.3
