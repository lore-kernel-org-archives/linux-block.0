Return-Path: <willy@infradead.org>
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Christos Gkekas <chris.gekas@gmail.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Joe Perches <joe@perches.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 04/26] mtip32xx: Convert to new IDA API
Date: Thu, 21 Jun 2018 14:28:13 -0700
Message-Id: <20180621212835.5636-5-willy@infradead.org>
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
List-ID: <linux-block@vger.kernel.org>

Removes a use of ida_pre_get() and a personalised spinlock.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/block/mtip32xx/mtip32xx.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c73626decb46..2b6d6bce76df 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -118,7 +118,6 @@ static struct dentry *dfs_device_status;
 
 static u32 cpu_use[NR_CPUS];
 
-static DEFINE_SPINLOCK(rssd_index_lock);
 static DEFINE_IDA(rssd_index_ida);
 
 static int mtip_block_initialize(struct driver_data *dd);
@@ -3768,20 +3767,10 @@ static int mtip_block_initialize(struct driver_data *dd)
 		goto alloc_disk_error;
 	}
 
-	/* Generate the disk name, implemented same as in sd.c */
-	do {
-		if (!ida_pre_get(&rssd_index_ida, GFP_KERNEL)) {
-			rv = -ENOMEM;
-			goto ida_get_error;
-		}
-
-		spin_lock(&rssd_index_lock);
-		rv = ida_get_new(&rssd_index_ida, &index);
-		spin_unlock(&rssd_index_lock);
-	} while (rv == -EAGAIN);
-
-	if (rv)
+	rv = ida_alloc(&rssd_index_ida, GFP_KERNEL);
+	if (rv < 0)
 		goto ida_get_error;
+	index = rv;
 
 	rv = rssd_disk_name_format("rssd",
 				index,
@@ -3923,9 +3912,7 @@ static int mtip_block_initialize(struct driver_data *dd)
 block_queue_alloc_tag_error:
 	mtip_hw_debugfs_exit(dd);
 disk_index_error:
-	spin_lock(&rssd_index_lock);
-	ida_remove(&rssd_index_ida, index);
-	spin_unlock(&rssd_index_lock);
+	ida_free(&rssd_index_ida, index);
 
 ida_get_error:
 	put_disk(dd->disk);
@@ -4013,9 +4000,7 @@ static int mtip_block_remove(struct driver_data *dd)
 	}
 	dd->disk  = NULL;
 
-	spin_lock(&rssd_index_lock);
-	ida_remove(&rssd_index_ida, dd->index);
-	spin_unlock(&rssd_index_lock);
+	ida_free(&rssd_index_ida, dd->index);
 
 	/* De-initialize the protocol layer. */
 	mtip_hw_exit(dd);
@@ -4055,9 +4040,7 @@ static int mtip_block_shutdown(struct driver_data *dd)
 		dd->queue = NULL;
 	}
 
-	spin_lock(&rssd_index_lock);
-	ida_remove(&rssd_index_ida, dd->index);
-	spin_unlock(&rssd_index_lock);
+	ida_free(&rssd_index_ida, dd->index);
 	return 0;
 }
 
-- 
2.17.1
