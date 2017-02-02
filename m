Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbdBBRf6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 12:35:58 -0500
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 02/24] bdi: Provide bdi_register_va()
Date: Thu,  2 Feb 2017 18:34:00 +0100
Message-Id: <20170202173422.3240-3-jack@suse.cz>
In-Reply-To: <20170202173422.3240-1-jack@suse.cz>
References: <20170202173422.3240-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add function that registers bdi and takes va_list instead of variable
number of arguments.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev.h |  2 ++
 mm/backing-dev.c            | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 81c07ade4305..6865b1c8b122 100644
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
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7a5ba4163656..d59571023df7 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -824,18 +824,15 @@ struct backing_dev_info *bdi_alloc(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(bdi_alloc);
 
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
 
@@ -851,6 +848,19 @@ int bdi_register(struct backing_dev_info *bdi, struct device *parent,
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

