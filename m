Return-Path: <joseph.qi@linux.alibaba.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caspar Zhang <caspar@linux.alibaba.com>,
	linux-block@vger.kernel.org
Subject: [PATCH] blk-throttle: fix typo in blkg_print_stat_ios() comments
Date: Sun,  8 Apr 2018 17:01:47 +0800
Message-Id: <1523178107-31076-1-git-send-email-joseph.qi@linux.alibaba.com>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1c16694..87367d4 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -640,7 +640,7 @@ int blkg_print_stat_bytes(struct seq_file *sf, void *v)
 EXPORT_SYMBOL_GPL(blkg_print_stat_bytes);
 
 /**
- * blkg_print_stat_bytes - seq_show callback for blkg->stat_ios
+ * blkg_print_stat_ios - seq_show callback for blkg->stat_ios
  * @sf: seq_file to print to
  * @v: unused
  *
-- 
1.8.3.1
