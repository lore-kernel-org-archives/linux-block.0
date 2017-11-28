Return-Path: <zhangweiping@didichuxing.com>
Date: Tue, 28 Nov 2017 13:18:51 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [RFC PATCH] blk-throttle: export io_serviced_recursive,
 io_service_bytes_recursive
Message-ID: <20171128051846.GA23968@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

export these two interface for cgroup-v1.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-throttle.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 96ad326..1d7637f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1512,10 +1512,20 @@ static struct cftype throtl_legacy_files[] = {
 		.seq_show = blkg_print_stat_bytes,
 	},
 	{
+		.name = "throttle.io_service_bytes_recursive",
+		.private = (unsigned long)&blkcg_policy_throtl,
+		.seq_show = blkg_print_stat_bytes_recursive,
+	},
+	{
 		.name = "throttle.io_serviced",
 		.private = (unsigned long)&blkcg_policy_throtl,
 		.seq_show = blkg_print_stat_ios,
 	},
+	{
+		.name = "throttle.io_serviced_recursive",
+		.private = (unsigned long)&blkcg_policy_throtl,
+		.seq_show = blkg_print_stat_ios_recursive,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.9.4
