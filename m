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
Subject: [PATCH 06/10] writeback: Move __inode_wait_for_state_bit
Date: Thu,  9 Feb 2017 13:44:29 +0100
Message-Id: <20170209124433.2626-7-jack@suse.cz>
In-Reply-To: <20170209124433.2626-1-jack@suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Move it up in fs/fs-writeback.c so that we don't have to use forward
declarations. No code change.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index c9770de11650..23dc97cf2a50 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -99,6 +99,21 @@ static inline struct inode *wb_inode(struct list_head *head)
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(wbc_writepage);
 
+/*
+ * Wait for bit in inode->i_state to clear. Called with i_lock held.
+ * Caller must make sure inode cannot go away when we drop i_lock.
+ */
+static void __inode_wait_for_state_bit(struct inode *inode, int bit_nr)
+	__releases(inode->i_lock)
+	__acquires(inode->i_lock)
+{
+	while (inode->i_state & (1 << bit_nr)) {
+		spin_unlock(&inode->i_lock);
+		wait_on_bit(&inode->i_state, bit_nr, TASK_UNINTERRUPTIBLE);
+		spin_lock(&inode->i_lock);
+	}
+}
+
 static bool wb_io_lists_populated(struct bdi_writeback *wb)
 {
 	if (wb_has_dirty_io(wb)) {
@@ -1170,21 +1185,6 @@ static int write_inode(struct inode *inode, struct writeback_control *wbc)
 }
 
 /*
- * Wait for bit in inode->i_state to clear. Called with i_lock held.
- * Caller must make sure inode cannot go away when we drop i_lock.
- */
-static void __inode_wait_for_state_bit(struct inode *inode, int bit_nr)
-	__releases(inode->i_lock)
-	__acquires(inode->i_lock)
-{
-	while (inode->i_state & (1 << bit_nr)) {
-		spin_unlock(&inode->i_lock);
-		wait_on_bit(&inode->i_state, bit_nr, TASK_UNINTERRUPTIBLE);
-		spin_lock(&inode->i_lock);
-	}
-}
-
-/*
  * Wait for writeback on an inode to complete. Caller must have inode pinned.
  */
 void inode_wait_for_writeback(struct inode *inode)
-- 
2.10.2
