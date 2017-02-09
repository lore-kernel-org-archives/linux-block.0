Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 07/10] writeback: Implement reliable switching to default writeback structure
Date: Thu,  9 Feb 2017 13:44:30 +0100
Message-Id: <20170209124433.2626-8-jack@suse.cz>
In-Reply-To: <20170209124433.2626-1-jack@suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Currently switching of inode between different writeback structures is
asynchronous and not guaranteed to succeed. Add a variant of switching
that is synchronous and reliable so that it can reliably move inode to
the default writeback structure (bdi->wb) when writeback on bdi is going
to be shutdown.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c         | 60 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/fs.h        |  3 ++-
 include/linux/writeback.h |  6 +++++
 3 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 23dc97cf2a50..52992a1036b1 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -332,14 +332,11 @@ struct inode_switch_wbs_context {
 	struct work_struct	work;
 };
 
-static void inode_switch_wbs_work_fn(struct work_struct *work)
+static void do_inode_switch_wbs(struct inode *inode,
+				struct bdi_writeback *new_wb)
 {
-	struct inode_switch_wbs_context *isw =
-		container_of(work, struct inode_switch_wbs_context, work);
-	struct inode *inode = isw->inode;
 	struct address_space *mapping = inode->i_mapping;
 	struct bdi_writeback *old_wb = inode->i_wb;
-	struct bdi_writeback *new_wb = isw->new_wb;
 	struct radix_tree_iter iter;
 	bool switched = false;
 	void **slot;
@@ -436,15 +433,29 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	spin_unlock(&new_wb->list_lock);
 	spin_unlock(&old_wb->list_lock);
 
+	/*
+	 * Make sure waitqueue_active() check in wake_up_bit() cannot happen
+	 * before I_WB_SWITCH is cleared. Pairs with the barrier in
+	 * set_task_state() after wait_on_bit() added waiter to the wait queue.
+	 */
+	smp_mb();
+	wake_up_bit(&inode->i_state, __I_WB_SWITCH);
+
 	if (switched) {
 		wb_wakeup(new_wb);
 		wb_put(old_wb);
 	}
-	wb_put(new_wb);
+}
 
-	iput(inode);
-	kfree(isw);
+static void inode_switch_wbs_work_fn(struct work_struct *work)
+{
+	struct inode_switch_wbs_context *isw =
+		container_of(work, struct inode_switch_wbs_context, work);
 
+	do_inode_switch_wbs(isw->inode, isw->new_wb);
+	wb_put(isw->new_wb);
+	iput(isw->inode);
+	kfree(isw);
 	atomic_dec(&isw_nr_in_flight);
 }
 
@@ -521,6 +532,39 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 }
 
 /**
+ * inode_switch_to_default_wb_sync - change the wb association of an inode to
+ *	the default writeback structure synchronously
+ * @inode: target inode
+ *
+ * Switch @inode's wb association to the default writeback structure (bdi->wb).
+ * Unlike inode_switch_wbs() the switching is performed synchronously and we
+ * guarantee the inode is switched to the default writeback structure when this
+ * function returns. Nothing prevents from someone else switching inode to
+ * another writeback structure just when we are done though. Preventing that is
+ * upto the caller if needed.
+ */
+void inode_switch_to_default_wb_sync(struct inode *inode)
+{
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
+
+	/* while holding I_WB_SWITCH, no one else can update the association */
+	spin_lock(&inode->i_lock);
+	if (WARN_ON_ONCE(inode->i_state & I_FREEING) ||
+	    !inode_to_wb_is_valid(inode) || inode_to_wb(inode) == &bdi->wb) {
+		spin_unlock(&inode->i_lock);
+		return;
+	}
+	__inode_wait_for_state_bit(inode, __I_WB_SWITCH);
+	inode->i_state |= I_WB_SWITCH;
+	spin_unlock(&inode->i_lock);
+
+	/* Make I_WB_SWITCH setting visible to unlocked users of i_wb */
+	synchronize_rcu();
+
+	do_inode_switch_wbs(inode, &bdi->wb);
+}
+
+/**
  * wbc_attach_and_unlock_inode - associate wbc with target inode and unlock it
  * @wbc: writeback_control of interest
  * @inode: target inode
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c930cbc19342..319fb76f9081 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1929,7 +1929,8 @@ static inline bool HAS_UNMAPPED_ID(struct inode *inode)
 #define I_DIRTY_TIME		(1 << 11)
 #define __I_DIRTY_TIME_EXPIRED	12
 #define I_DIRTY_TIME_EXPIRED	(1 << __I_DIRTY_TIME_EXPIRED)
-#define I_WB_SWITCH		(1 << 13)
+#define __I_WB_SWITCH		13
+#define I_WB_SWITCH		(1 << __I_WB_SWITCH)
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
 #define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 5527d910ba3d..0d3ba83a0f7f 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -280,6 +280,8 @@ static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
 		bio_associate_blkcg(bio, wbc->wb->blkcg_css);
 }
 
+void inode_switch_to_default_wb_sync(struct inode *inode);
+
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
 static inline void inode_attach_wb(struct inode *inode, struct page *page)
@@ -319,6 +321,10 @@ static inline void cgroup_writeback_umount(void)
 {
 }
 
+static inline void inode_switch_to_default_wb_sync(struct inode *inode)
+{
+}
+
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
 /*
-- 
2.10.2
