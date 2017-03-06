Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	Tejun Heo <tj@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Omar Sandoval <osandov@osandov.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 05/11] bdi: Move removal from bdi->wb_list into wb_shutdown()
Date: Mon,  6 Mar 2017 17:33:58 +0100
Message-Id: <20170306163404.1238-6-jack@suse.cz>
In-Reply-To: <20170306163404.1238-1-jack@suse.cz>
References: <20170306163404.1238-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Currently the removal from bdi->wb_list happens directly in
cgwb_release_workfn(). Move it to wb_shutdown() which is functionally
equivalent and more logical (the list gets only used for distributing
writeback works among bdi_writeback structures). It will also allow us
to simplify writeback shutdown in cgwb_bdi_destroy().

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 37cd1adae979..4dffae6e2d7b 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -345,6 +345,8 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	return err;
 }
 
+static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb);
+
 /*
  * Remove bdi from the global list and shutdown any threads we have running
  */
@@ -358,6 +360,7 @@ static void wb_shutdown(struct bdi_writeback *wb)
 	}
 	spin_unlock_bh(&wb->work_lock);
 
+	cgwb_remove_from_bdi_list(wb);
 	/*
 	 * Drain work list and shutdown the delayed_work.  !WB_registered
 	 * tells wb_workfn() that @wb is dying and its work_list needs to
@@ -491,10 +494,6 @@ static void cgwb_release_workfn(struct work_struct *work)
 						release_work);
 	struct backing_dev_info *bdi = wb->bdi;
 
-	spin_lock_irq(&cgwb_lock);
-	list_del_rcu(&wb->bdi_node);
-	spin_unlock_irq(&cgwb_lock);
-
 	wb_shutdown(wb);
 
 	css_put(wb->memcg_css);
@@ -526,6 +525,13 @@ static void cgwb_kill(struct bdi_writeback *wb)
 	percpu_ref_kill(&wb->refcnt);
 }
 
+static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
+{
+	spin_lock_irq(&cgwb_lock);
+	list_del_rcu(&wb->bdi_node);
+	spin_unlock_irq(&cgwb_lock);
+}
+
 static int cgwb_create(struct backing_dev_info *bdi,
 		       struct cgroup_subsys_state *memcg_css, gfp_t gfp)
 {
@@ -783,6 +789,8 @@ static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
 	wb_congested_put(bdi->wb_congested);
 }
 
+static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb) { }
+
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
 int bdi_init(struct backing_dev_info *bdi)
-- 
2.10.2
