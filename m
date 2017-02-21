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
Subject: [PATCH 06/13] bdi: Make wb->bdi a proper reference
Date: Tue, 21 Feb 2017 18:09:51 +0100
Message-Id: <20170221170958.21845-7-jack@suse.cz>
In-Reply-To: <20170221170958.21845-1-jack@suse.cz>
References: <20170221170958.21845-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Make wb->bdi a proper refcounted reference to bdi for all bdi_writeback
structures except for the one embedded inside struct backing_dev_info.
That will allow us to simplify bdi unregistration.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index c324eae17f0d..d7aaf2517c30 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -294,6 +294,8 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 
 	memset(wb, 0, sizeof(*wb));
 
+	if (wb != &bdi->wb)
+		bdi_get(bdi);
 	wb->bdi = bdi;
 	wb->last_old_flush = jiffies;
 	INIT_LIST_HEAD(&wb->b_dirty);
@@ -314,8 +316,10 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	wb->dirty_sleep = jiffies;
 
 	wb->congested = wb_congested_get_create(bdi, blkcg_id, gfp);
-	if (!wb->congested)
-		return -ENOMEM;
+	if (!wb->congested) {
+		err = -ENOMEM;
+		goto out_put_bdi;
+	}
 
 	err = fprop_local_init_percpu(&wb->completions, gfp);
 	if (err)
@@ -335,6 +339,9 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	fprop_local_destroy_percpu(&wb->completions);
 out_put_cong:
 	wb_congested_put(wb->congested);
+out_put_bdi:
+	if (wb != &bdi->wb)
+		bdi_put(bdi);
 	return err;
 }
 
@@ -372,6 +379,8 @@ static void wb_exit(struct bdi_writeback *wb)
 
 	fprop_local_destroy_percpu(&wb->completions);
 	wb_congested_put(wb->congested);
+	if (wb != &wb->bdi->wb)
+		bdi_put(wb->bdi);
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-- 
2.10.2
