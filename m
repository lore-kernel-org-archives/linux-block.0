Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 01/25] bdi: Provide bdi_register_va() and bdi_alloc()
Date: Wed, 29 Mar 2017 12:55:59 +0200
Message-Id: <20170329105623.18241-2-jack@suse.cz>
In-Reply-To: <20170329105623.18241-1-jack@suse.cz>
References: <20170329105623.18241-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Add function that registers bdi and takes va_list instead of variable
number of arguments.

Add bdi_alloc() as simple wrapper for NUMA-unaware users allocating BDI.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev.h |  6 ++++++
 mm/backing-dev.c            | 20 +++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index c52a48cb9a66..47a98e6e2a65 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -30,6 +30,8 @@ void bdi_put(struct backing_dev_info *bdi);
 __printf(3, 4)
 int bdi_register(struct backing_dev_info *bdi, struct device *parent,
 		const char *fmt, ...);
+int bdi_register_va(struct backing_dev_info *bdi, struct device *parent,
+		const char *fmt, va_list args);
 int bdi_register_dev(struct backing_dev_info *bdi, dev_t dev);
 int bdi_register_owner(struct backing_dev_info *bdi, struct device *owner);
 void bdi_unregister(struct backing_dev_info *bdi);
@@ -37,6 +39,10 @@ void bdi_unregister(struct backing_dev_info *bdi);
 int __must_check bdi_setup_and_register(struct backing_dev_info *, char *);
 void bdi_destroy(struct backing_dev_info *bdi);
 struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id);
+static inline struct backing_dev_info *bdi_alloc(gfp_t gfp_mask)
+{
+	return bdi_alloc_node(gfp_mask, NUMA_NO_NODE);
+}
 
 void wb_start_writeback(struct bdi_writeback *wb, long nr_pages,
 			bool range_cyclic, enum wb_reason reason);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 3ea3bbd921d6..e5e0972bdd6f 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -856,18 +856,15 @@ struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
 	return bdi;
 }
 
-int bdi_register(struct backing_dev_info *bdi, struct device *parent,
-		const char *fmt, ...)
+int bdi_register_va(struct backing_dev_info *bdi, struct device *parent,
+		const char *fmt, va_list args)
 {
-	va_list args;
 	struct device *dev;
 
 	if (bdi->dev)	/* The driver needs to use separate queues per device */
 		return 0;
 
-	va_start(args, fmt);
 	dev = device_create_vargs(bdi_class, parent, MKDEV(0, 0), bdi, fmt, args);
-	va_end(args);
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
@@ -884,6 +881,19 @@ int bdi_register(struct backing_dev_info *bdi, struct device *parent,
 	trace_writeback_bdi_register(bdi);
 	return 0;
 }
+EXPORT_SYMBOL(bdi_register_va);
+
+int bdi_register(struct backing_dev_info *bdi, struct device *parent,
+		const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = bdi_register_va(bdi, parent, fmt, args);
+	va_end(args);
+	return ret;
+}
 EXPORT_SYMBOL(bdi_register);
 
 int bdi_register_dev(struct backing_dev_info *bdi, dev_t dev)
-- 
2.10.2
