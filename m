Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbeAWKzt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jan 2018 05:55:49 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Joe Perches <joe@perches.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: [PATCH v2] bsg: use pr_debug instead of hand craftet macros
Date: Tue, 23 Jan 2018 11:55:38 +0100
Message-Id: <20180123105538.24860-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use pr_debug instead of hand craftet macros. This way it is not needed to
re-compile the kernel to enable bsg debug outputs and it's possible to
selectively enable specific prints.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Joe Perches <joe@perches.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>

---
Changes to v1:
* Aligned arguments (Bart)
* Include bd->name in macro (Joe)
---
 block/bsg.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 452f94f1c5d4..a1bcbb6ba50b 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -32,6 +32,9 @@
 #define BSG_DESCRIPTION	"Block layer SCSI generic (bsg) driver"
 #define BSG_VERSION	"0.4"
 
+#define bsg_dbg(bd, fmt, ...) \
+	pr_debug("%s: " fmt, (bd)->name, ##__VA_ARGS__)
+
 struct bsg_device {
 	struct request_queue *queue;
 	spinlock_t lock;
@@ -55,14 +58,6 @@ enum {
 #define BSG_DEFAULT_CMDS	64
 #define BSG_MAX_DEVS		32768
 
-#undef BSG_DEBUG
-
-#ifdef BSG_DEBUG
-#define dprintk(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ##args)
-#else
-#define dprintk(fmt, args...)
-#endif
-
 static DEFINE_MUTEX(bsg_mutex);
 static DEFINE_IDR(bsg_minor_idr);
 
@@ -123,7 +118,7 @@ static struct bsg_command *bsg_alloc_command(struct bsg_device *bd)
 
 	bc->bd = bd;
 	INIT_LIST_HEAD(&bc->list);
-	dprintk("%s: returning free cmd %p\n", bd->name, bc);
+	bsg_dbg(bd, "returning free cmd %p\n", bc);
 	return bc;
 out:
 	spin_unlock_irq(&bd->lock);
@@ -222,7 +217,8 @@ bsg_map_hdr(struct bsg_device *bd, struct sg_io_v4 *hdr, fmode_t mode)
 	if (!bcd->class_dev)
 		return ERR_PTR(-ENXIO);
 
-	dprintk("map hdr %llx/%u %llx/%u\n", (unsigned long long) hdr->dout_xferp,
+	bsg_dbg(bd, "map hdr %llx/%u %llx/%u\n",
+		(unsigned long long) hdr->dout_xferp,
 		hdr->dout_xfer_len, (unsigned long long) hdr->din_xferp,
 		hdr->din_xfer_len);
 
@@ -299,8 +295,8 @@ static void bsg_rq_end_io(struct request *rq, blk_status_t status)
 	struct bsg_device *bd = bc->bd;
 	unsigned long flags;
 
-	dprintk("%s: finished rq %p bc %p, bio %p\n",
-		bd->name, rq, bc, bc->bio);
+	bsg_dbg(bd, "finished rq %p bc %p, bio %p\n",
+		rq, bc, bc->bio);
 
 	bc->hdr.duration = jiffies_to_msecs(jiffies - bc->hdr.duration);
 
@@ -333,7 +329,7 @@ static void bsg_add_command(struct bsg_device *bd, struct request_queue *q,
 	list_add_tail(&bc->list, &bd->busy_list);
 	spin_unlock_irq(&bd->lock);
 
-	dprintk("%s: queueing rq %p, bc %p\n", bd->name, rq, bc);
+	bsg_dbg(bd, "queueing rq %p, bc %p\n", rq, bc);
 
 	rq->end_io_data = bc;
 	blk_execute_rq_nowait(q, NULL, rq, at_head, bsg_rq_end_io);
@@ -379,7 +375,7 @@ static struct bsg_command *bsg_get_done_cmd(struct bsg_device *bd)
 		}
 	} while (1);
 
-	dprintk("%s: returning done %p\n", bd->name, bc);
+	bsg_dbg(bd, "returning done %p\n", bc);
 
 	return bc;
 }
@@ -390,7 +386,7 @@ static int blk_complete_sgv4_hdr_rq(struct request *rq, struct sg_io_v4 *hdr,
 	struct scsi_request *req = scsi_req(rq);
 	int ret = 0;
 
-	dprintk("rq %p bio %p 0x%x\n", rq, bio, req->result);
+	pr_debug("rq %p bio %p 0x%x\n", rq, bio, req->result);
 	/*
 	 * fill in all the output members
 	 */
@@ -469,7 +465,7 @@ static int bsg_complete_all_commands(struct bsg_device *bd)
 	struct bsg_command *bc;
 	int ret, tret;
 
-	dprintk("%s: entered\n", bd->name);
+	bsg_dbg(bd, "entered\n");
 
 	/*
 	 * wait for all commands to complete
@@ -572,7 +568,7 @@ bsg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	int ret;
 	ssize_t bytes_read;
 
-	dprintk("%s: read %zd bytes\n", bd->name, count);
+	bsg_dbg(bd, "read %zd bytes\n", count);
 
 	bsg_set_block(bd, file);
 
@@ -646,7 +642,7 @@ bsg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	ssize_t bytes_written;
 	int ret;
 
-	dprintk("%s: write %zd bytes\n", bd->name, count);
+	bsg_dbg(bd, "write %zd bytes\n", count);
 
 	if (unlikely(uaccess_kernel()))
 		return -EINVAL;
@@ -664,7 +660,7 @@ bsg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (!bytes_written || err_block_err(ret))
 		bytes_written = ret;
 
-	dprintk("%s: returning %zd\n", bd->name, bytes_written);
+	bsg_dbg(bd, "returning %zd\n", bytes_written);
 	return bytes_written;
 }
 
@@ -717,7 +713,7 @@ static int bsg_put_device(struct bsg_device *bd)
 	hlist_del(&bd->dev_list);
 	mutex_unlock(&bsg_mutex);
 
-	dprintk("%s: tearing down\n", bd->name);
+	bsg_dbg(bd, "tearing down\n");
 
 	/*
 	 * close can always block
@@ -744,9 +740,7 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 					 struct file *file)
 {
 	struct bsg_device *bd;
-#ifdef BSG_DEBUG
 	unsigned char buf[32];
-#endif
 
 	if (!blk_queue_scsi_passthrough(rq)) {
 		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
@@ -771,7 +765,7 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 	hlist_add_head(&bd->dev_list, bsg_dev_idx_hash(iminor(inode)));
 
 	strncpy(bd->name, dev_name(rq->bsg_dev.class_dev), sizeof(bd->name) - 1);
-	dprintk("bound to <%s>, max queue %d\n",
+	bsg_dbg(bd, "bound to <%s>, max queue %d\n",
 		format_dev_t(buf, inode->i_rdev), bd->max_queue);
 
 	mutex_unlock(&bsg_mutex);
-- 
2.13.6
