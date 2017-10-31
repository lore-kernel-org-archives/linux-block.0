Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:5856 "EHLO
        BJEXCAS005.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751399AbdJaKiA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Oct 2017 06:38:00 -0400
Date: Tue, 31 Oct 2017 18:37:54 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jack@suse.cz>
CC: <linux-block@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v2 1/3] bdi: convert bdi_debug_register to int
Message-ID: <8f8d9678f5843f7fd01588d2cc4f4dc3f21dd50b.1509415695.git.zhangweiping@didichuxing.com>
References: <cover.1509415695.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1509415695.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Convert bdi_debug_register to int and then do error handle for it.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 mm/backing-dev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 74b52dfd5852..b5f940ce0143 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -113,11 +113,23 @@ static const struct file_operations bdi_debug_stats_fops = {
 	.release	= single_release,
 };
 
-static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
+static int bdi_debug_register(struct backing_dev_info *bdi, const char *name)
 {
+	if (!bdi_debug_root)
+		return -ENOMEM;
+
 	bdi->debug_dir = debugfs_create_dir(name, bdi_debug_root);
+	if (!bdi->debug_dir)
+		return -ENOMEM;
+
 	bdi->debug_stats = debugfs_create_file("stats", 0444, bdi->debug_dir,
 					       bdi, &bdi_debug_stats_fops);
+	if (!bdi->debug_stats) {
+		debugfs_remove(bdi->debug_dir);
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 static void bdi_debug_unregister(struct backing_dev_info *bdi)
@@ -129,9 +141,10 @@ static void bdi_debug_unregister(struct backing_dev_info *bdi)
 static inline void bdi_debug_init(void)
 {
 }
-static inline void bdi_debug_register(struct backing_dev_info *bdi,
+static inline int bdi_debug_register(struct backing_dev_info *bdi,
 				      const char *name)
 {
+	return 0;
 }
 static inline void bdi_debug_unregister(struct backing_dev_info *bdi)
 {
-- 
2.14.2
