Return-Path: <zhangweiping@didichuxing.com>
Date: Fri, 27 Oct 2017 01:35:36 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jack@suse.cz>
CC: <linux-block@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 1/4] bdi: add check for bdi_debug_root
Message-ID: <883f8bb529fbde0d4adc2b78ba3bbda81e1ce6a0.1509038624.git.zhangweiping@didichuxing.com>
References: <cover.1509038624.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1509038624.git.zhangweiping@didichuxing.com>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

this patch add a check for bdi_debug_root and do error handle for it.
we should make sure it was created success, otherwise when add new
block device's bdi folder(eg, 8:0) will be create a debugfs root directory.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 mm/backing-dev.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 74b52dfd5852..5072be19d9b2 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -36,9 +36,12 @@ struct workqueue_struct *bdi_wq;
 
 static struct dentry *bdi_debug_root;
 
-static void bdi_debug_init(void)
+static int bdi_debug_init(void)
 {
 	bdi_debug_root = debugfs_create_dir("bdi", NULL);
+	if (!bdi_debug_root)
+		return -ENOMEM;
+	return 0;
 }
 
 static int bdi_debug_stats_show(struct seq_file *m, void *v)
@@ -126,8 +129,9 @@ static void bdi_debug_unregister(struct backing_dev_info *bdi)
 	debugfs_remove(bdi->debug_dir);
 }
 #else
-static inline void bdi_debug_init(void)
+static inline int bdi_debug_init(void)
 {
+	return 0;
 }
 static inline void bdi_debug_register(struct backing_dev_info *bdi,
 				      const char *name)
@@ -229,12 +233,19 @@ ATTRIBUTE_GROUPS(bdi_dev);
 
 static __init int bdi_class_init(void)
 {
+	int ret;
+
 	bdi_class = class_create(THIS_MODULE, "bdi");
 	if (IS_ERR(bdi_class))
 		return PTR_ERR(bdi_class);
 
 	bdi_class->dev_groups = bdi_dev_groups;
-	bdi_debug_init();
+	ret = bdi_debug_init();
+	if (ret) {
+		class_destroy(bdi_class);
+		bdi_class = NULL;
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.14.2
