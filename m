Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 03/24] block: Unregister bdi on last reference drop
Date: Thu,  2 Feb 2017 18:34:01 +0100
Message-Id: <20170202173422.3240-4-jack@suse.cz>
In-Reply-To: <20170202173422.3240-1-jack@suse.cz>
References: <20170202173422.3240-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Most users will want to unregister bdi when dropping last reference to a
bdi. Only a few users (like block devices) want to play more complex
tricks with bdi registration and unregistration. So unregister bdi when
the last reference to bdi is dropped and just make sure we don't
unregister the bdi the second time if it is already unregistered.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev-defs.h |  3 ++-
 mm/backing-dev.c                 | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index ad955817916d..2ecafc8a2d06 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -146,7 +146,8 @@ struct backing_dev_info {
 	char *name;
 
 	struct kref refcnt;	/* Reference counter for the structure */
-	unsigned int capabilities; /* Device capabilities */
+	unsigned int registered:1;	/* Is bdi registered? */
+	unsigned int capabilities:31;	/* Device capabilities */
 	unsigned int min_ratio;
 	unsigned int max_ratio, max_prop_frac;
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index d59571023df7..82fee0f52d06 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -843,6 +843,7 @@ int bdi_register_va(struct backing_dev_info *bdi, struct device *parent,
 
 	spin_lock_bh(&bdi_lock);
 	list_add_tail_rcu(&bdi->bdi_list, &bdi_list);
+	bdi->registered = 1;
 	spin_unlock_bh(&bdi_lock);
 
 	trace_writeback_bdi_register(bdi);
@@ -897,6 +898,14 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
 
 void bdi_unregister(struct backing_dev_info *bdi)
 {
+	spin_lock_bh(&bdi_lock);
+	if (!bdi->registered) {
+		spin_unlock_bh(&bdi_lock);
+		return;
+	}
+	bdi->registered = 0;
+	spin_unlock_bh(&bdi_lock);
+
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
 	wb_shutdown(&bdi->wb);
@@ -925,6 +934,7 @@ static void release_bdi(struct kref *ref)
 	struct backing_dev_info *bdi =
 			container_of(ref, struct backing_dev_info, refcnt);
 
+	bdi_unregister(bdi);
 	bdi_exit(bdi);
 	kfree(bdi);
 }
-- 
2.10.2
