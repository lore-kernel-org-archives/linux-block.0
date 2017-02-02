Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 01/24] block: Provide bdi_alloc()
Date: Thu,  2 Feb 2017 18:33:59 +0100
Message-Id: <20170202173422.3240-2-jack@suse.cz>
In-Reply-To: <20170202173422.3240-1-jack@suse.cz>
References: <20170202173422.3240-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Provide bdi_alloc() forsimple allocation of a BDI that can be used by
filesystems that don't need anything fancy. We use this function when
converting filesystems from embedded struct backing_dev_info into a
dynamically allocated one.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev.h |  1 +
 mm/backing-dev.c            | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index c52a48cb9a66..81c07ade4305 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -37,6 +37,7 @@ void bdi_unregister(struct backing_dev_info *bdi);
 int __must_check bdi_setup_and_register(struct backing_dev_info *, char *);
 void bdi_destroy(struct backing_dev_info *bdi);
 struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id);
+struct backing_dev_info *bdi_alloc(gfp_t gfp_mask);
 
 void wb_start_writeback(struct bdi_writeback *wb, long nr_pages,
 			bool range_cyclic, enum wb_reason reason);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 28ce6cf7b2ff..7a5ba4163656 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -809,6 +809,21 @@ struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
 	return bdi;
 }
 
+struct backing_dev_info *bdi_alloc(gfp_t gfp_mask)
+{
+	struct backing_dev_info *bdi;
+
+	bdi = kmalloc(sizeof(struct backing_dev_info), gfp_mask | __GFP_ZERO);
+	if (!bdi)
+		return NULL;
+	if (bdi_init(bdi)) {
+		kfree(bdi);
+		return NULL;
+	}
+	return bdi;
+}
+EXPORT_SYMBOL(bdi_alloc);
+
 int bdi_register(struct backing_dev_info *bdi, struct device *parent,
 		const char *fmt, ...)
 {
-- 
2.10.2
