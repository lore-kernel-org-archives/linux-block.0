Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40851 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbeAVHyF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jan 2018 02:54:05 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Jens Axboe <axboe@fb.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH TRIVIAL] bsg: use pr_debug instead of hand crafted macros
Date: Mon, 22 Jan 2018 08:53:48 +0100
Message-Id: <20180122075348.6974-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use pr_debug instead of hand crafted macros. This way it is not needed to
re-compile the kernel to enable bsg debug outputs and it's possible to
selectively enable specific prints.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/bsg.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 452f94f1c5d4..508e73c60add 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -55,14 +55,6 @@ enum {
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
 
@@ -123,7 +115,7 @@ static struct bsg_command *bsg_alloc_command(struct bsg_device *bd)
 
 	bc->bd = bd;
 	INIT_LIST_HEAD(&bc->list);
-	dprintk("%s: returning free cmd %p\n", bd->name, bc);
+	pr_debug("%s: returning free cmd %p\n", bd->name, bc);
 	return bc;
 out:
 	spin_unlock_irq(&bd->lock);
@@ -222,7 +214,8 @@ bsg_map_hdr(struct bsg_device *bd, struct sg_io_v4 *hdr, fmode_t mode)
 	if (!bcd->class_dev)
 		return ERR_PTR(-ENXIO);
 
-	dprintk("map hdr %llx/%u %llx/%u\n", (unsigned long long) hdr->dout_xferp,
+	pr_debug("map hdr %llx/%u %llx/%u\n",
+		 (unsigned long long) hdr->dout_xferp,
 		hdr->dout_xfer_len, (unsigned long long) hdr->din_xferp,
 		hdr->din_xfer_len);
 
@@ -299,7 +292,7 @@ static void bsg_rq_end_io(struct request *rq, blk_status_t status)
 	struct bsg_device *bd = bc->bd;
 	unsigned long flags;
 
-	dprintk("%s: finished rq %p bc %p, bio %p\n",
+	pr_debug("%s: finished rq %p bc %p, bio %p\n",
 		bd->name, rq, bc, bc->bio);
 
 	bc->hdr.duration = jiffies_to_msecs(jiffies - bc->hdr.duration);
@@ -333,7 +326,7 @@ static void bsg_add_command(struct bsg_device *bd, struct request_queue *q,
 	list_add_tail(&bc->list, &bd->busy_list);
 	spin_unlock_irq(&bd->lock);
 
-	dprintk("%s: queueing rq %p, bc %p\n", bd->name, rq, bc);
+	pr_debug("%s: queueing rq %p, bc %p\n", bd->name, rq, bc);
 
 	rq->end_io_data = bc;
 	blk_execute_rq_nowait(q, NULL, rq, at_head, bsg_rq_end_io);
@@ -379,7 +372,7 @@ static struct bsg_command *bsg_get_done_cmd(struct bsg_device *bd)
 		}
 	} while (1);
 
-	dprintk("%s: returning done %p\n", bd->name, bc);
+	pr_debug("%s: returning done %p\n", bd->name, bc);
 
 	return bc;
 }
@@ -390,7 +383,7 @@ static int blk_complete_sgv4_hdr_rq(struct request *rq, struct sg_io_v4 *hdr,
 	struct scsi_request *req = scsi_req(rq);
 	int ret = 0;
 
-	dprintk("rq %p bio %p 0x%x\n", rq, bio, req->result);
+	pr_debug("rq %p bio %p 0x%x\n", rq, bio, req->result);
 	/*
 	 * fill in all the output members
 	 */
@@ -469,7 +462,7 @@ static int bsg_complete_all_commands(struct bsg_device *bd)
 	struct bsg_command *bc;
 	int ret, tret;
 
-	dprintk("%s: entered\n", bd->name);
+	pr_debug("%s: entered\n", bd->name);
 
 	/*
 	 * wait for all commands to complete
@@ -572,7 +565,7 @@ bsg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	int ret;
 	ssize_t bytes_read;
 
-	dprintk("%s: read %zd bytes\n", bd->name, count);
+	pr_debug("%s: read %zd bytes\n", bd->name, count);
 
 	bsg_set_block(bd, file);
 
@@ -646,7 +639,7 @@ bsg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	ssize_t bytes_written;
 	int ret;
 
-	dprintk("%s: write %zd bytes\n", bd->name, count);
+	pr_debug("%s: write %zd bytes\n", bd->name, count);
 
 	if (unlikely(uaccess_kernel()))
 		return -EINVAL;
@@ -664,7 +657,7 @@ bsg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (!bytes_written || err_block_err(ret))
 		bytes_written = ret;
 
-	dprintk("%s: returning %zd\n", bd->name, bytes_written);
+	pr_debug("%s: returning %zd\n", bd->name, bytes_written);
 	return bytes_written;
 }
 
@@ -717,7 +710,7 @@ static int bsg_put_device(struct bsg_device *bd)
 	hlist_del(&bd->dev_list);
 	mutex_unlock(&bsg_mutex);
 
-	dprintk("%s: tearing down\n", bd->name);
+	pr_debug("%s: tearing down\n", bd->name);
 
 	/*
 	 * close can always block
@@ -744,9 +737,7 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 					 struct file *file)
 {
 	struct bsg_device *bd;
-#ifdef BSG_DEBUG
 	unsigned char buf[32];
-#endif
 
 	if (!blk_queue_scsi_passthrough(rq)) {
 		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
@@ -771,7 +762,7 @@ static struct bsg_device *bsg_add_device(struct inode *inode,
 	hlist_add_head(&bd->dev_list, bsg_dev_idx_hash(iminor(inode)));
 
 	strncpy(bd->name, dev_name(rq->bsg_dev.class_dev), sizeof(bd->name) - 1);
-	dprintk("bound to <%s>, max queue %d\n",
+	pr_debug("bound to <%s>, max queue %d\n",
 		format_dev_t(buf, inode->i_rdev), bd->max_queue);
 
 	mutex_unlock(&bsg_mutex);
-- 
2.13.6
