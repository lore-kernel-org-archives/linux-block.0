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
Subject: [PATCH 03/11] bdi: Mark congested->bdi as internal
Date: Mon,  6 Mar 2017 17:33:56 +0100
Message-Id: <20170306163404.1238-4-jack@suse.cz>
In-Reply-To: <20170306163404.1238-1-jack@suse.cz>
References: <20170306163404.1238-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

congested->bdi pointer is used only to be able to remove congested
structure from bdi->cgwb_congested_tree on structure release. Moreover
the pointer can become NULL when we unregister the bdi. Rename the field
to __bdi and add a comment to make it more explicit this is internal
stuff of memcg writeback code and people should not use the field as
such use will be likely race prone.

We do not bother with converting congested->bdi to a proper refcounted
reference. It will be slightly ugly to special-case bdi->wb.congested to
avoid effectively a cyclic reference of bdi to itself and the reference
gets cleared from bdi_unregister() making it impossible to reference
a freed bdi.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev-defs.h |  4 +++-
 mm/backing-dev.c                 | 10 +++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index ad955817916d..8fb3dcdebc80 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -54,7 +54,9 @@ struct bdi_writeback_congested {
 	atomic_t refcnt;		/* nr of attached wb's and blkg */
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-	struct backing_dev_info *bdi;	/* the associated bdi */
+	struct backing_dev_info *__bdi;	/* the associated bdi, set to NULL
+					 * on bdi unregistration. For memcg-wb
+					 * internal use only! */
 	int blkcg_id;			/* ID of the associated blkcg */
 	struct rb_node rb_node;		/* on bdi->cgwb_congestion_tree */
 #endif
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 6d861d090e9f..fec27da14aea 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -438,7 +438,7 @@ wb_congested_get_create(struct backing_dev_info *bdi, int blkcg_id, gfp_t gfp)
 		return NULL;
 
 	atomic_set(&new_congested->refcnt, 0);
-	new_congested->bdi = bdi;
+	new_congested->__bdi = bdi;
 	new_congested->blkcg_id = blkcg_id;
 	goto retry;
 
@@ -466,10 +466,10 @@ void wb_congested_put(struct bdi_writeback_congested *congested)
 	}
 
 	/* bdi might already have been destroyed leaving @congested unlinked */
-	if (congested->bdi) {
+	if (congested->__bdi) {
 		rb_erase(&congested->rb_node,
-			 &congested->bdi->cgwb_congested_tree);
-		congested->bdi = NULL;
+			 &congested->__bdi->cgwb_congested_tree);
+		congested->__bdi = NULL;
 	}
 
 	spin_unlock_irqrestore(&cgwb_lock, flags);
@@ -698,7 +698,7 @@ static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
 			rb_entry(rbn, struct bdi_writeback_congested, rb_node);
 
 		rb_erase(rbn, &bdi->cgwb_congested_tree);
-		congested->bdi = NULL;	/* mark @congested unlinked */
+		congested->__bdi = NULL;	/* mark @congested unlinked */
 	}
 
 	spin_unlock_irq(&cgwb_lock);
-- 
2.10.2
