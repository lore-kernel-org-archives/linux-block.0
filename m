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
Subject: [PATCH 08/13] bdi: Shutdown writeback on all cgwbs in cgwb_bdi_destroy()
Date: Tue, 21 Feb 2017 18:09:53 +0100
Message-Id: <20170221170958.21845-9-jack@suse.cz>
In-Reply-To: <20170221170958.21845-1-jack@suse.cz>
References: <20170221170958.21845-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Currently we waited for all cgwbs to get freed in cgwb_bdi_destroy()
which also means that writeback has been shutdown on them. Since this
wait is going away, directly shutdown writeback on cgwbs from
cgwb_bdi_destroy() to avoid live writeback structures after
bdi_unregister() has finished.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 54b9e934eef4..c9623b410170 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -700,6 +700,7 @@ static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
 	struct radix_tree_iter iter;
 	struct rb_node *rbn;
 	void **slot;
+	struct wb_writeback *wb;
 
 	WARN_ON(test_bit(WB_registered, &bdi->wb.state));
 
@@ -716,6 +717,14 @@ static void cgwb_bdi_destroy(struct backing_dev_info *bdi)
 		congested->__bdi = NULL;	/* mark @congested unlinked */
 	}
 
+	while (!list_empty(&bdi->wb_list)) {
+		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
+				      bdi_node);
+		spin_unlock_irq(&cgwb_lock);
+		wb_shutdown(wb);
+		spin_lock_irq(&cgwb_lock);
+	}
+
 	spin_unlock_irq(&cgwb_lock);
 
 	/*
-- 
2.10.2
