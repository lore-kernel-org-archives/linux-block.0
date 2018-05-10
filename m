Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
To: "Ed L. Cashin" <ed.cashin@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] aoe: Remove pr_fmt duplicate logging prefixes
Date: Thu, 10 May 2018 08:45:42 -0700
Message-Id: <8b22bb13c6cac696896c1a4f750e66fa863c00cb.1525964386.git.joe@perches.com>
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
List-ID: <linux-block@vger.kernel.org>

Converting pr_fmt from a simple define to use KBUILD_MODNAME added
some duplicate logging prefixes to existing uses.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/block/aoe/aoeblk.c  | 29 ++++++++++++++---------------
 drivers/block/aoe/aoechr.c  | 11 +++++------
 drivers/block/aoe/aoecmd.c  | 34 ++++++++++++++++------------------
 drivers/block/aoe/aoedev.c  | 19 +++++++------------
 drivers/block/aoe/aoemain.c |  6 +++---
 drivers/block/aoe/aoenet.c  | 19 ++++++++-----------
 6 files changed, 53 insertions(+), 65 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 6797e6c23c8a..d008cc46c0bd 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -205,7 +205,7 @@ aoedisk_add_debugfs(struct aoedev *d)
 	entry = debugfs_create_file(p, 0444, aoe_debugfs_dir, d,
 				    &aoe_debugfs_fops);
 	if (IS_ERR_OR_NULL(entry)) {
-		pr_info("aoe: cannot create debugfs file for %s\n",
+		pr_info("cannot create debugfs file for %s\n",
 			d->gd->disk_name);
 		return;
 	}
@@ -237,8 +237,7 @@ aoeblk_open(struct block_device *bdev, fmode_t mode)
 	ulong flags;
 
 	if (!virt_addr_valid(d)) {
-		pr_crit("aoe: invalid device pointer in %s\n",
-			__func__);
+		pr_crit("invalid device pointer in %s\n", __func__);
 		WARN_ON(1);
 		return -ENODEV;
 	}
@@ -282,8 +281,8 @@ aoeblk_request(struct request_queue *q)
 
 	d = q->queuedata;
 	if ((d->flags & DEVFL_UP) == 0) {
-		pr_info_ratelimited("aoe: device %ld.%d is not up\n",
-			d->aoemajor, d->aoeminor);
+		pr_info_ratelimited("device %ld.%d is not up\n",
+				    d->aoemajor, d->aoeminor);
 		while ((rq = blk_peek_request(q))) {
 			blk_start_request(rq);
 			aoe_end_request(d, rq, 1);
@@ -299,7 +298,7 @@ aoeblk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	struct aoedev *d = bdev->bd_disk->private_data;
 
 	if ((d->flags & DEVFL_UP) == 0) {
-		printk(KERN_ERR "aoe: disk not up\n");
+		pr_err("disk not up\n");
 		return -ENODEV;
 	}
 
@@ -319,7 +318,7 @@ aoeblk_ioctl(struct block_device *bdev, fmode_t mode, uint cmd, ulong arg)
 
 	d = bdev->bd_disk->private_data;
 	if ((d->flags & DEVFL_UP) == 0) {
-		pr_err("aoe: disk not up\n");
+		pr_err("disk not up\n");
 		return -ENODEV;
 	}
 
@@ -332,7 +331,7 @@ aoeblk_ioctl(struct block_device *bdev, fmode_t mode, uint cmd, ulong arg)
 
 	/* udev calls scsi_id, which uses SG_IO, resulting in noise */
 	if (cmd != SG_IO)
-		pr_info("aoe: unknown ioctl 0x%x\n", cmd);
+		pr_info("unknown ioctl 0x%x\n", cmd);
 
 	return -ENOTTY;
 }
@@ -370,22 +369,22 @@ aoeblk_gdalloc(void *vp)
 
 	gd = alloc_disk(AOE_PARTITIONS);
 	if (gd == NULL) {
-		pr_err("aoe: cannot allocate disk structure for %ld.%d\n",
-			d->aoemajor, d->aoeminor);
+		pr_err("cannot allocate disk structure for %ld.%d\n",
+		       d->aoemajor, d->aoeminor);
 		goto err;
 	}
 
 	mp = mempool_create(MIN_BUFS, mempool_alloc_slab, mempool_free_slab,
 		buf_pool_cache);
 	if (mp == NULL) {
-		printk(KERN_ERR "aoe: cannot allocate bufpool for %ld.%d\n",
-			d->aoemajor, d->aoeminor);
+		pr_err("cannot allocate bufpool for %ld.%d\n",
+		       d->aoemajor, d->aoeminor);
 		goto err_disk;
 	}
 	q = blk_init_queue(aoeblk_request, &d->lock);
 	if (q == NULL) {
-		pr_err("aoe: cannot allocate block queue for %ld.%d\n",
-			d->aoemajor, d->aoeminor);
+		pr_err("cannot allocate block queue for %ld.%d\n",
+		       d->aoemajor, d->aoeminor);
 		goto err_mempool;
 	}
 	blk_queue_bounce_limit(q, BLK_BOUNCE_HIGH);
@@ -457,7 +456,7 @@ aoeblk_init(void)
 		return -ENOMEM;
 	aoe_debugfs_dir = debugfs_create_dir("aoe", NULL);
 	if (IS_ERR_OR_NULL(aoe_debugfs_dir)) {
-		pr_info("aoe: cannot create debugfs directory\n");
+		pr_info("cannot create debugfs directory\n");
 		aoe_debugfs_dir = NULL;
 	}
 	return 0;
diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index ab41be625a53..57553ee1375c 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -69,8 +69,7 @@ static int
 interfaces(const char __user *str, size_t size)
 {
 	if (set_aoe_iflist(str, size)) {
-		printk(KERN_ERR
-			"aoe: could not set interface list: too many interfaces\n");
+		pr_err("could not set interface list: too many interfaces\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -93,7 +92,7 @@ revalidate(const char __user *str, size_t size)
 
 	n = sscanf(buf, "e%d.%d", &major, &minor);
 	if (n != 2) {
-		pr_err("aoe: invalid device specification %s\n", buf);
+		pr_err("invalid device specification %s\n", buf);
 		return -EINVAL;
 	}
 	d = aoedev_by_aoeaddr(major, minor, 0);
@@ -141,7 +140,7 @@ bail:		spin_unlock_irqrestore(&emsgs_lock, flags);
 
 	mp = kmemdup(msg, n, GFP_ATOMIC);
 	if (mp == NULL) {
-		printk(KERN_ERR "aoe: allocation failure, len=%ld\n", n);
+		pr_err("allocation failure, len=%ld\n", n);
 		goto bail;
 	}
 
@@ -165,7 +164,7 @@ aoechr_write(struct file *filp, const char __user *buf, size_t cnt, loff_t *offp
 
 	switch ((unsigned long) filp->private_data) {
 	default:
-		printk(KERN_INFO "aoe: can't write to that file.\n");
+		pr_info("can't write to that file\n");
 		break;
 	case MINOR_DISCOVER:
 		ret = discover();
@@ -287,7 +286,7 @@ aoechr_init(void)
 
 	n = register_chrdev(AOE_MAJOR, "aoechr", &aoe_fops);
 	if (n < 0) {
-		printk(KERN_ERR "aoe: can't register char device\n");
+		pr_err("can't register char device\n");
 		return n;
 	}
 	init_completion(&emsgs_comp);
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 540bb60cd071..e75a0ed67d92 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -256,7 +256,7 @@ newframe(struct aoedev *d)
 	int has_untainted;
 
 	if (!d->targets || !d->targets[0]) {
-		printk(KERN_ERR "aoe: NULL TARGETS!\n");
+		pr_err("NULL TARGETS!\n");
 		return NULL;
 	}
 	tt = d->tgt;	/* last used target */
@@ -425,7 +425,7 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
 
 		skb = new_skb(sizeof *h + sizeof *ch);
 		if (skb == NULL) {
-			printk(KERN_INFO "aoe: skb alloc failure\n");
+			pr_info("skb alloc failure\n");
 			goto cont;
 		}
 		skb_put(skb, sizeof *h + sizeof *ch);
@@ -463,7 +463,7 @@ resend(struct aoedev *d, struct frame *f)
 	skb = f->skb;
 	if (ifrotate(t) == NULL) {
 		/* probably can't happen, but set it up to fail anyway */
-		pr_info("aoe: resend: no interfaces to rotate to.\n");
+		pr_info("resend: no interfaces to rotate to\n");
 		ktcomplete(f, NULL);
 		return;
 	}
@@ -867,7 +867,7 @@ nextbuf(struct aoedev *d)
 	}
 	buf = mempool_alloc(d->bufpool, GFP_ATOMIC);
 	if (buf == NULL) {
-		pr_err("aoe: nextbuf: unable to mempool_alloc!\n");
+		pr_err("nextbuf: unable to mempool_alloc!\n");
 		return NULL;
 	}
 	bio = d->ip.nxbio;
@@ -968,8 +968,7 @@ ataid_complete(struct aoedev *d, struct aoetgt *t, unsigned char *id)
 	memcpy(d->ident, id, sizeof(d->ident));
 
 	if (d->ssize != ssize)
-		printk(KERN_INFO
-			"aoe: %pm e%ld.%d v%04x has %llu sectors\n",
+		pr_info("%pm e%ld.%d v%04x has %llu sectors\n",
 			t->addr,
 			d->aoemajor, d->aoeminor,
 			d->fw_ver, (long long)ssize);
@@ -1107,9 +1106,9 @@ ktiocomplete(struct frame *f)
 	ahin = (struct aoe_atahdr *) skb->data;
 	skb_pull(skb, sizeof(*ahin));
 	if (ahin->cmdstat & 0xa9) {	/* these bits cleared on success */
-		pr_err("aoe: ata error cmd=%2.2Xh stat=%2.2Xh from e%ld.%d\n",
-			ahout->cmdstat, ahin->cmdstat,
-			d->aoemajor, d->aoeminor);
+		pr_err("ata error cmd=%2.2Xh stat=%2.2Xh from e%ld.%d\n",
+		       ahout->cmdstat, ahin->cmdstat,
+		       d->aoemajor, d->aoeminor);
 noskb:		if (buf)
 			buf->bio->bi_status = BLK_STS_IOERR;
 		goto out;
@@ -1159,7 +1158,7 @@ noskb:		if (buf)
 		spin_unlock_irq(&d->lock);
 		break;
 	default:
-		pr_info("aoe: unrecognized ata command %2.2Xh for %d.%d\n",
+		pr_info("unrecognized ata command %2.2Xh for %d.%d\n",
 			ahout->cmdstat,
 			be16_to_cpu(get_unaligned(&hin->major)),
 			hin->minor);
@@ -1466,7 +1465,7 @@ addtgt(struct aoedev *d, char *addr, ulong nframes)
 	return *tt = t;
 
  nomem:
-	pr_info("aoe: cannot allocate memory to add target\n");
+	pr_info("cannot allocate memory to add target\n");
 	return NULL;
 }
 
@@ -1483,7 +1482,7 @@ setdbcnt(struct aoedev *d)
 			bcnt = (*t)->minbcnt;
 	if (bcnt != d->maxbcnt) {
 		d->maxbcnt = bcnt;
-		pr_info("aoe: e%ld.%d: setting %d byte data frames\n",
+		pr_info("e%ld.%d: setting %d byte data frames\n",
 			d->aoemajor, d->aoeminor, bcnt);
 	}
 }
@@ -1510,7 +1509,7 @@ setifbcnt(struct aoetgt *t, struct net_device *nd, int bcnt)
 	}
 	if (nd) {
 		if (p == e) {
-			pr_err("aoe: device setifbcnt failure; too many interfaces.\n");
+			pr_err("device setifbcnt failure; too many interfaces\n");
 			return;
 		}
 		dev_hold(nd);
@@ -1543,17 +1542,16 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	 */
 	aoemajor = get_unaligned_be16(&h->major);
 	if (aoemajor == 0xfff) {
-		printk(KERN_ERR "aoe: Warning: shelf address is all ones.  "
-			"Check shelf dip switches.\n");
+		pr_err("Warning: shelf address is all ones. Check shelf dip switches.\n");
 		return;
 	}
 	if (aoemajor == 0xffff) {
-		pr_info("aoe: e%ld.%d: broadcast shelf number invalid\n",
+		pr_info("e%ld.%d: broadcast shelf number invalid\n",
 			aoemajor, (int) h->minor);
 		return;
 	}
 	if (h->minor == 0xff) {
-		pr_info("aoe: e%ld.%d: broadcast slot number invalid\n",
+		pr_info("e%ld.%d: broadcast slot number invalid\n",
 			aoemajor, (int) h->minor);
 		return;
 	}
@@ -1564,7 +1562,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 
 	d = aoedev_by_aoeaddr(aoemajor, h->minor, 1);
 	if (d == NULL) {
-		pr_info("aoe: device allocation failure\n");
+		pr_info("device allocation failure\n");
 		return;
 	}
 
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 697f735b07a4..1ef8ff0ef312 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -69,8 +69,7 @@ minor_get_static(ulong *sysminor, ulong aoemaj, int aoemin)
 	};
 
 	if (aoemin >= NPERSHELF) {
-		pr_err("aoe: %s %d slots per shelf\n",
-			"static minor device numbers support only",
+		pr_err("static minor device numbers support only %d slots per shelf\n",
 			NPERSHELF);
 		error = -1;
 		goto out;
@@ -78,18 +77,16 @@ minor_get_static(ulong *sysminor, ulong aoemaj, int aoemin)
 
 	n = aoemaj * NPERSHELF + aoemin;
 	if (n >= N_DEVS) {
-		pr_err("aoe: %s with e%ld.%d\n",
-			"cannot use static minor device numbers",
-			aoemaj, aoemin);
+		pr_err("cannot use static minor device numbers with e%ld.%d\n",
+		       aoemaj, aoemin);
 		error = -1;
 		goto out;
 	}
 
 	spin_lock_irqsave(&used_minors_lock, flags);
 	if (test_bit(n, used_minors)) {
-		pr_err("aoe: %s %lu\n",
-			"existing device already has static minor number",
-			n);
+		pr_err("existing device already has static minor number %lu\n",
+		       n);
 		error = -1;
 	} else
 		set_bit(n, used_minors);
@@ -404,10 +401,8 @@ skbfree(struct sk_buff *skb)
 	while (atomic_read(&skb_shinfo(skb)->dataref) != 1 && i-- > 0)
 		msleep(Sms);
 	if (i < 0) {
-		printk(KERN_ERR
-			"aoe: %s holds ref: %s\n",
-			skb->dev ? skb->dev->name : "netif",
-			"cannot free skb -- memory leaked.");
+		pr_err("%s holds ref: cannot free skb -- memory leaked\n",
+		       skb->dev ? skb->dev->name : "netif");
 		return;
 	}
 	skb->truesize -= skb->data_len;
diff --git a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
index 251482066977..5995832a2596 100644
--- a/drivers/block/aoe/aoemain.c
+++ b/drivers/block/aoe/aoemain.c
@@ -59,10 +59,10 @@ aoe_init(void)
 		goto cmd_fail;
 	ret = register_blkdev(AOE_MAJOR, DEVICE_NAME);
 	if (ret < 0) {
-		printk(KERN_ERR "aoe: can't register major\n");
+		pr_err("can't register major\n");
 		goto blkreg_fail;
 	}
-	printk(KERN_INFO "aoe: AoE v%s initialised.\n", VERSION);
+	pr_info("AoE v%s initialised\n", VERSION);
 
 	timer_setup(&timer, discover_timer, 0);
 	discover_timer(&timer);
@@ -78,7 +78,7 @@ aoe_init(void)
  chr_fail:
 	aoedev_exit();
 
-	printk(KERN_INFO "aoe: initialisation failure.\n");
+	pr_info("initialisation failure\n");
 	return ret;
 }
 
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 63773a90581d..454edea1b517 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -61,9 +61,8 @@ tx(int id) __must_hold(&txlock)
 		spin_unlock_irq(&txlock);
 		ifp = skb->dev;
 		if (dev_queue_xmit(skb) == NET_XMIT_DROP && net_ratelimit())
-			pr_warn("aoe: packet could not be sent on %s.  %s\n",
-				ifp ? ifp->name : "netif",
-				"consider increasing tx_queue_len");
+			pr_warn("packet could not be sent on %s - consider increasing tx_queue_len\n",
+				ifp ? ifp->name : "netif");
 		spin_lock_irq(&txlock);
 	}
 	return 0;
@@ -102,7 +101,7 @@ set_aoe_iflist(const char __user *user_str, size_t size)
 		return -EINVAL;
 
 	if (copy_from_user(aoe_iflist, user_str, size)) {
-		printk(KERN_INFO "aoe: copy from user failed\n");
+		pr_info("copy from user failed\n");
 		return -EFAULT;
 	}
 	aoe_iflist[size] = 0x00;
@@ -160,12 +159,10 @@ aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt,
 		if (n > NECODES)
 			n = 0;
 		if (net_ratelimit())
-			printk(KERN_ERR
-				"%s%d.%d@%s; ecode=%d '%s'\n",
-				"aoe: error packet from ",
-				get_unaligned_be16(&h->major),
-				h->minor, skb->dev->name,
-				h->err, aoe_errlist[n]);
+			pr_err("error packet from %d.%d@%s; ecode=%d '%s'\n",
+			       get_unaligned_be16(&h->major),
+			       h->minor, skb->dev->name,
+			       h->err, aoe_errlist[n]);
 		goto exit;
 	}
 
@@ -180,7 +177,7 @@ aoenet_rcv(struct sk_buff *skb, struct net_device *ifp, struct packet_type *pt,
 	default:
 		if (h->cmd >= AOECMD_VEND_MIN)
 			break;	/* don't complain about vendor commands */
-		pr_info("aoe: unknown AoE command type 0x%02x\n", h->cmd);
+		pr_info("unknown AoE command type 0x%02x\n", h->cmd);
 		break;
 	}
 
-- 
2.15.0
