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
Subject: [PATCH 10/13] bdi: Rename cgwb_bdi_destroy() to cgwb_bdi_unregister()
Date: Tue, 21 Feb 2017 18:09:55 +0100
Message-Id: <20170221170958.21845-11-jack@suse.cz>
In-Reply-To: <20170221170958.21845-1-jack@suse.cz>
References: <20170221170958.21845-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Rename cgwb_bdi_destroy() to cgwb_bdi_unregister() as it gets called
from bdi_unregister() which is not necessarily called from bdi_destroy()
and thus the name is somewhat misleading.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 31cdee91e826..b1b50cce3f36 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -687,7 +687,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	return ret;
 }
 
-static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
+static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 {
 	struct radix_tree_iter iter;
 	struct rb_node *rbn;
@@ -777,7 +777,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 
 static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb) { }
 
-static void cgwb_bdi_destroy(struct backing_dev_info *bdi) { }
+static void cgwb_bdi_unregister(struct backing_dev_info *bdi) { }
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
@@ -885,7 +885,7 @@ void bdi_unregister(struct backing_dev_info *bdi)
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
 	wb_shutdown(&bdi->wb);
-	cgwb_bdi_destroy(bdi);
+	cgwb_bdi_unregister(bdi);
 
 	if (bdi->dev) {
 		bdi_debug_unregister(bdi);
-- 
2.10.2
