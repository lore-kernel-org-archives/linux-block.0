Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751401AbdCMPOR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2017 11:14:17 -0400
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Tahsin Erdogan <tahsin@google.com>,
        Omar Sandoval <osandov@osandov.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 05/11] bdi: Unify bdi->wb_list handling for root wb_writeback
Date: Mon, 13 Mar 2017 16:14:04 +0100
Message-Id: <20170313151410.5586-6-jack@suse.cz>
In-Reply-To: <20170313151410.5586-1-jack@suse.cz>
References: <20170313151410.5586-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently root wb_writeback structure is added to bdi->wb_list in
bdi_init() and never removed. That is different from all other
wb_writeback structures which get added to the list when created and
removed from it before wb_shutdown().

So move list addition of root bdi_writeback to bdi_register() and list
removal of all wb_writeback structures to wb_shutdown(). That way a
wb_writeback structure is on bdi->wb_list if and only if it can handle
writeback and it will make it easier for us to handle shutdown of all
wb_writeback structures in bdi_unregister().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 03d4ba27c133..e3d56dba4da8 100644
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
@@ -766,6 +772,13 @@ static void cgwb_bdi_exit(struct backing_dev_info *bdi)
 	spin_unlock_irq(&cgwb_lock);
 }
 
+static void cgwb_bdi_register(struct backing_dev_info *bdi)
+{
+	spin_lock_irq(&cgwb_lock);
+	list_add_tail_rcu(&bdi->wb.bdi_node, &bdi->wb_list);
+	spin_unlock_irq(&cgwb_lock);
+}
+
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
 static int cgwb_bdi_init(struct backing_dev_info *bdi)
@@ -793,6 +806,16 @@ static void cgwb_bdi_exit(struct backing_dev_info *bdi)
 	wb_congested_put(bdi->wb_congested);
 }
 
+static void cgwb_bdi_register(struct backing_dev_info *bdi)
+{
+	list_add_tail_rcu(&bdi->wb.bdi_node, &bdi->wb_list);
+}
+
+static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
+{
+	list_del_rcu(&wb->bdi_node);
+}
+
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
 int bdi_init(struct backing_dev_info *bdi)
@@ -811,8 +834,6 @@ int bdi_init(struct backing_dev_info *bdi)
 
 	ret = cgwb_bdi_init(bdi);
 
-	list_add_tail_rcu(&bdi->wb.bdi_node, &bdi->wb_list);
-
 	return ret;
 }
 EXPORT_SYMBOL(bdi_init);
@@ -848,6 +869,7 @@ int bdi_register(struct backing_dev_info *bdi, struct device *parent,
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
+	cgwb_bdi_register(bdi);
 	bdi->dev = dev;
 
 	bdi_debug_register(bdi, dev_name(dev));
-- 
2.10.2
