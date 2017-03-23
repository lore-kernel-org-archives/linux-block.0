Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Tejun Heo <tj@kernel.org>,
	Tahsin Erdogan <tahsin@google.com>,
	Omar Sandoval <osandov@osandov.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 05/10] bdi: Shutdown writeback on all cgwbs in cgwb_bdi_destroy()
Date: Thu, 23 Mar 2017 01:36:57 +0100
Message-Id: <20170323003702.27571-6-jack@suse.cz>
In-Reply-To: <20170323003702.27571-1-jack@suse.cz>
References: <20170323003702.27571-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Currently we waited for all cgwbs to get freed in cgwb_bdi_destroy()
which also means that writeback has been shutdown on them. Since this
wait is going away, directly shutdown writeback on cgwbs from
cgwb_bdi_destroy() to avoid live writeback structures after
bdi_unregister() has finished. To make that safe with concurrent
shutdown from cgwb_release_workfn(), we also have to make sure
wb_shutdown() returns only after the bdi_writeback structure is really
shutdown.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev-defs.h |  1 +
 mm/backing-dev.c                 | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 8fb3dcdebc80..8af720f22a2d 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -21,6 +21,7 @@ struct dentry;
  */
 enum wb_state {
 	WB_registered,		/* bdi_register() was done */
+	WB_shutting_down,	/* wb_shutdown() in progress */
 	WB_writeback_running,	/* Writeback is in progress */
 	WB_has_dirty_io,	/* Dirty inodes on ->b_{dirty|io|more_io} */
 };
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e3d56dba4da8..b67be4fc12c4 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -356,8 +356,15 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	spin_lock_bh(&wb->work_lock);
 	if (!test_and_clear_bit(WB_registered, &wb->state)) {
 		spin_unlock_bh(&wb->work_lock);
+		/*
+		 * Wait for wb shutdown to finish if someone else is just
+		 * running wb_shutdown(). Otherwise we could proceed to wb /
+		 * bdi destruction before wb_shutdown() is finished.
+		 */
+		wait_on_bit(&wb->state, WB_shutting_down, TASK_UNINTERRUPTIBLE);
 		return;
 	}
+	set_bit(WB_shutting_down, &wb->state);
 	spin_unlock_bh(&wb->work_lock);
 
 	cgwb_remove_from_bdi_list(wb);
@@ -369,6 +376,12 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	mod_delayed_work(bdi_wq, &wb->dwork, 0);
 	flush_delayed_work(&wb->dwork);
 	WARN_ON(!list_empty(&wb->work_list));
+	/*
+	 * Make sure bit gets cleared after shutdown is finished. Matches with
+	 * the barrier provided by test_and_clear_bit() above.
+	 */
+	smp_wmb();
+	clear_bit(WB_shutting_down, &wb->state);
 }
 
 static void wb_exit(struct bdi_writeback *wb)
@@ -699,12 +712,21 @@ static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
 {
 	struct radix_tree_iter iter;
 	void **slot;
+	struct bdi_writeback *wb;
 
 	WARN_ON(test_bit(WB_registered, &bdi->wb.state));
 
 	spin_lock_irq(&cgwb_lock);
 	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0)
 		cgwb_kill(*slot);
+
+	while (!list_empty(&bdi->wb_list)) {
+		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
+				      bdi_node);
+		spin_unlock_irq(&cgwb_lock);
+		wb_shutdown(wb);
+		spin_lock_irq(&cgwb_lock);
+	}
 	spin_unlock_irq(&cgwb_lock);
 
 	/*
-- 
2.10.2
