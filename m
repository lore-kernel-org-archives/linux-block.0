Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754122AbdCWAhM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2017 20:37:12 -0400
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Tahsin Erdogan <tahsin@google.com>,
        Omar Sandoval <osandov@osandov.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/10] bdi: Rename cgwb_bdi_destroy() to cgwb_bdi_unregister()
Date: Thu, 23 Mar 2017 01:36:59 +0100
Message-Id: <20170323003702.27571-8-jack@suse.cz>
In-Reply-To: <20170323003702.27571-1-jack@suse.cz>
References: <20170323003702.27571-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Rename cgwb_bdi_destroy() to cgwb_bdi_unregister() as it gets called
from bdi_unregister() which is not necessarily called from bdi_destroy()
and thus the name is somewhat misleading.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 8c30b1a7aae5..3ea3bbd921d6 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -700,7 +700,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	return ret;
 }
 
-static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
+static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 {
 	struct radix_tree_iter iter;
 	void **slot;
@@ -801,7 +801,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	return 0;
 }
 
-static void cgwb_bdi_destroy(struct backing_dev_info *bdi) { }
+static void cgwb_bdi_unregister(struct backing_dev_info *bdi) { }
 
 static void cgwb_bdi_exit(struct backing_dev_info *bdi)
 {
@@ -925,7 +925,7 @@ void bdi_unregister(struct backing_dev_info *bdi)
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
 	wb_shutdown(&bdi->wb);
-	cgwb_bdi_destroy(bdi);
+	cgwb_bdi_unregister(bdi);
 
 	if (bdi->dev) {
 		bdi_debug_unregister(bdi);
-- 
2.10.2
