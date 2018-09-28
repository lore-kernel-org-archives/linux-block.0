Return-Path: <jgross@suse.com>
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Cc: boris.ostrovsky@oracle.com,
	roger.pau@citrix.com,
	konrad.wilk@oracle.com,
	axboe@kernel.dk,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen/blkfront: correct purging of persistent grants
Date: Fri, 28 Sep 2018 09:28:27 +0200
Message-Id: <20180928072827.14229-1-jgross@suse.com>
List-ID: <linux-block@vger.kernel.org>

Commit a46b53672b2c2e3770b38a4abf90d16364d2584b ("xen/blkfront: cleanup
stale persistent grants") introduced a regression as purged persistent
grants were not pu into the list of free grants again. Correct that.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index a71d817e900d..429d20131c7e 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2670,8 +2670,8 @@ static void purge_persistent_grants(struct blkfront_info *info)
 			list_del(&gnt_list_entry->node);
 			gnttab_end_foreign_access(gnt_list_entry->gref, 0, 0UL);
 			rinfo->persistent_gnts_c--;
-			__free_page(gnt_list_entry->page);
-			kfree(gnt_list_entry);
+			gnt_list_entry->gref = GRANT_INVALID_REF;
+			list_add_tail(&gnt_list_entry->node, &rinfo->grants);
 		}
 
 		spin_unlock_irqrestore(&rinfo->ring_lock, flags);
-- 
2.16.4
