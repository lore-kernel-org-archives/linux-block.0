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
Subject: [PATCH 06/10] bdi: Do not wait for cgwbs release in bdi_unregister()
Date: Thu, 23 Mar 2017 01:36:58 +0100
Message-Id: <20170323003702.27571-7-jack@suse.cz>
In-Reply-To: <20170323003702.27571-1-jack@suse.cz>
References: <20170323003702.27571-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Currently we wait for all cgwbs to get released in cgwb_bdi_destroy()
(called from bdi_unregister()). That is however unnecessary now when
cgwb->bdi is a proper refcounted reference (thus bdi cannot get
released before all cgwbs are released) and when cgwb_bdi_destroy()
shuts down writeback directly.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev-defs.h |  1 -
 mm/backing-dev.c                 | 22 +---------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 8af720f22a2d..e66d4722db8e 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -164,7 +164,6 @@ struct backing_dev_info {
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
 	struct rb_root cgwb_congested_tree; /* their congested states */
-	atomic_t usage_cnt; /* counts both cgwbs and cgwb_contested's */
 #else
 	struct bdi_writeback_congested *wb_congested;
 #endif
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index b67be4fc12c4..8c30b1a7aae5 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -406,11 +406,9 @@ static void wb_exit(struct bdi_writeback *wb)
 /*
  * cgwb_lock protects bdi->cgwb_tree, bdi->cgwb_congested_tree,
  * blkcg->cgwb_list, and memcg->cgwb_list.  bdi->cgwb_tree is also RCU
- * protected.  cgwb_release_wait is used to wait for the completion of cgwb
- * releases from bdi destruction path.
+ * protected.
  */
 static DEFINE_SPINLOCK(cgwb_lock);
-static DECLARE_WAIT_QUEUE_HEAD(cgwb_release_wait);
 
 /**
  * wb_congested_get_create - get or create a wb_congested
@@ -505,7 +503,6 @@ static void cgwb_release_workfn(struct work_struct *work)
 {
 	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
 						release_work);
-	struct backing_dev_info *bdi = wb->bdi;
 
 	wb_shutdown(wb);
 
@@ -516,9 +513,6 @@ static void cgwb_release_workfn(struct work_struct *work)
 	percpu_ref_exit(&wb->refcnt);
 	wb_exit(wb);
 	kfree_rcu(wb, rcu);
-
-	if (atomic_dec_and_test(&bdi->usage_cnt))
-		wake_up_all(&cgwb_release_wait);
 }
 
 static void cgwb_release(struct percpu_ref *refcnt)
@@ -608,7 +602,6 @@ static int cgwb_create(struct backing_dev_info *bdi,
 		/* we might have raced another instance of this function */
 		ret = radix_tree_insert(&bdi->cgwb_tree, memcg_css->id, wb);
 		if (!ret) {
-			atomic_inc(&bdi->usage_cnt);
 			list_add_tail_rcu(&wb->bdi_node, &bdi->wb_list);
 			list_add(&wb->memcg_node, memcg_cgwb_list);
 			list_add(&wb->blkcg_node, blkcg_cgwb_list);
@@ -698,7 +691,6 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 
 	INIT_RADIX_TREE(&bdi->cgwb_tree, GFP_ATOMIC);
 	bdi->cgwb_congested_tree = RB_ROOT;
-	atomic_set(&bdi->usage_cnt, 1);
 
 	ret = wb_init(&bdi->wb, bdi, 1, GFP_KERNEL);
 	if (!ret) {
@@ -728,18 +720,6 @@ static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
 		spin_lock_irq(&cgwb_lock);
 	}
 	spin_unlock_irq(&cgwb_lock);
-
-	/*
-	 * All cgwb's must be shutdown and released before returning.  Drain
-	 * the usage counter to wait for all cgwb's ever created on @bdi.
-	 */
-	atomic_dec(&bdi->usage_cnt);
-	wait_event(cgwb_release_wait, !atomic_read(&bdi->usage_cnt));
-	/*
-	 * Grab back our reference so that we hold it when @bdi gets
-	 * re-registered.
-	 */
-	atomic_inc(&bdi->usage_cnt);
 }
 
 /**
-- 
2.10.2
