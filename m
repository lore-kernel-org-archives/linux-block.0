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
Subject: [PATCH 05/10] writeback: Generalize and standardize I_SYNC waiting function
Date: Thu,  9 Feb 2017 13:44:28 +0100
Message-Id: <20170209124433.2626-6-jack@suse.cz>
In-Reply-To: <20170209124433.2626-1-jack@suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

__inode_wait_for_writeback() waits for I_SYNC on inode to get cleared.
There's nothing specific regarting I_SYNC for that function. Generalize
it so that we can use it also for I_WB_SWITCH bit. Also the function
uses __wait_on_bit() unnecessarily. Switch it to wait_on_bit() to remove
some code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index ef600591d96f..c9770de11650 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1170,21 +1170,16 @@ static int write_inode(struct inode *inode, struct writeback_control *wbc)
 }
 
 /*
- * Wait for writeback on an inode to complete. Called with i_lock held.
+ * Wait for bit in inode->i_state to clear. Called with i_lock held.
  * Caller must make sure inode cannot go away when we drop i_lock.
  */
-static void __inode_wait_for_writeback(struct inode *inode)
+static void __inode_wait_for_state_bit(struct inode *inode, int bit_nr)
 	__releases(inode->i_lock)
 	__acquires(inode->i_lock)
 {
-	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_SYNC);
-	wait_queue_head_t *wqh;
-
-	wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
-	while (inode->i_state & I_SYNC) {
+	while (inode->i_state & (1 << bit_nr)) {
 		spin_unlock(&inode->i_lock);
-		__wait_on_bit(wqh, &wq, bit_wait,
-			      TASK_UNINTERRUPTIBLE);
+		wait_on_bit(&inode->i_state, bit_nr, TASK_UNINTERRUPTIBLE);
 		spin_lock(&inode->i_lock);
 	}
 }
@@ -1195,7 +1190,7 @@ static void __inode_wait_for_writeback(struct inode *inode)
 void inode_wait_for_writeback(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-	__inode_wait_for_writeback(inode);
+	__inode_wait_for_state_bit(inode, __I_SYNC);
 	spin_unlock(&inode->i_lock);
 }
 
@@ -1397,7 +1392,7 @@ static int writeback_single_inode(struct inode *inode,
 		 * inode reference or inode has I_WILL_FREE set, it cannot go
 		 * away under us.
 		 */
-		__inode_wait_for_writeback(inode);
+		__inode_wait_for_state_bit(inode, __I_SYNC);
 	}
 	WARN_ON(inode->i_state & I_SYNC);
 	/*
-- 
2.10.2
