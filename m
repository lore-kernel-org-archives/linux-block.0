Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 3/3] blk-cgroup: clear the throttle queue on fork
Date: Tue, 31 Jul 2018 12:39:04 -0400
Message-Id: <20180731163904.21856-4-josef@toxicpanda.com>
In-Reply-To: <20180731163904.21856-1-josef@toxicpanda.com>
References: <20180731163904.21856-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

We were hitting a panic in production where we put too many times on the
request queue.  This is because we'd get the throttle_queue of the
parent if we fork()'ed while we needed to be throttled, but we didn't
have a reference on it.  Instead just clear these flags on fork so the
child doesn't pay for the sins of its father.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/fork.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9440d61b925c..694ae0e56866 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -843,6 +843,11 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->fail_nth = 0;
 #endif
 
+#ifdef CONFIG_BLK_CGROUP
+	tsk->throttle_queue = NULL;
+	tsk->use_memdelay = 0;
+#endif
+
 	return tsk;
 
 free_stack:
-- 
2.14.3
