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
Subject: [PATCH 08/11] bdi: Rename cgwb_bdi_destroy() to cgwb_bdi_unregister()
Date: Mon,  6 Mar 2017 17:34:01 +0100
Message-Id: <20170306163404.1238-9-jack@suse.cz>
In-Reply-To: <20170306163404.1238-1-jack@suse.cz>
References: <20170306163404.1238-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Rename cgwb_bdi_destroy() to cgwb_bdi_unregister() as it gets called
from bdi_unregister() which is not necessarily called from bdi_destroy()
and thus the name is somewhat misleading.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7592f4a36776..54c1ff39ea05 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -700,7 +700,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	return ret;
 }
 
-static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
+static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 {
 	struct radix_tree_iter iter;
 	struct rb_node *rbn;
@@ -790,7 +790,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	return 0;
 }
 
-static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
+static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 {
 	wb_congested_put(bdi->wb_congested);
 }
@@ -903,7 +903,7 @@ void bdi_unregister(struct backing_dev_info *bdi)
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
 	wb_shutdown(&bdi->wb);
-	cgwb_bdi_destroy(bdi);
+	cgwb_bdi_unregister(bdi);
 
 	if (bdi->dev) {
 		bdi_debug_unregister(bdi);
-- 
2.10.2
