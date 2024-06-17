Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A317F50F
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613347; cv=none; b=OpjCRiZ6e3UZja8mCklOhS0u4XqyaUR3hhDKWnPHjlrmrnMQvy/acfSftHk+xA2Kp1X80/wUjlOkVb9PkcuV101pnBVqyouLOfdwajR/tSBUFzxf8QN6nOreza6YiN2Qk7ZslHj1IxqNWiiHKNiG5hze7kqiTJE8FtbQ0snoITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613347; c=relaxed/simple;
	bh=IoaN8E1Pdki3SGYhde0+ZbYXciTDKsfV8vV9wp1ti8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDiBWEteTjnq7cUov8sPMlKl7k1b3pECtxeOXl9Orfsa7uV7IUWxQA7hYBDR2ZZ98cl3MpGK1kI40lc5Pn1T69DrlTFf5gxx108WaaYR3zohXEApOgufGGymWso0pQhNQRCIWBTzkUsv1c34L/5nknXu7wp3JPDqP9OUY4wlEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8e9c35302c8411ef9305a59a3cc225df-20240617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:6eb13f1d-67bb-42a5-926b-7cf4c6586d73,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:40
X-CID-INFO: VERSION:1.1.38,REQID:6eb13f1d-67bb-42a5-926b-7cf4c6586d73,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-META: VersionHash:82c5f88,CLOUDID:47d8a092d17540ec392ee5e7b7675156,BulkI
	D:240617153440C2F234Z8,BulkQuantity:1,Recheck:0,SF:38|24|72|19|44|66|102,T
	C:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 8e9c35302c8411ef9305a59a3cc225df-20240617
Received: from node4.com.cn [(39.156.73.12)] by mailgw.kylinos.cn
	(envelope-from <xialonglong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 59095662; Mon, 17 Jun 2024 16:35:31 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id E139A16002082;
	Mon, 17 Jun 2024 16:35:30 +0800 (CST)
X-ns-mid: postfix-666FF552-561047785
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 97E1216002082;
	Mon, 17 Jun 2024 08:35:28 +0000 (UTC)
From: Longlong Xia <xialonglong@kylinos.cn>
To: justin@coraid.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH 1/1] block: aoe: Standardize logging with pr_<level> macros and DEVICE_NAME prefix
Date: Mon, 17 Jun 2024 16:35:05 +0800
Message-ID: <20240617083505.3830370-1-xialonglong@kylinos.cn>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Convert printks to pr_<level> and use the pr_fmt()
macro to prefix all the output with DEVICE_NAME.

No functional changes.

Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 drivers/block/aoe/aoe.h     | 3 +++
 drivers/block/aoe/aoeblk.c  | 4 ++--
 drivers/block/aoe/aoechr.c  | 7 +++----
 drivers/block/aoe/aoecmd.c  | 9 ++++-----
 drivers/block/aoe/aoedev.c  | 3 +--
 drivers/block/aoe/aoemain.c | 6 +++---
 drivers/block/aoe/aoenet.c  | 7 +++----
 7 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 749ae1246f4c..13b7d388929b 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -5,6 +5,9 @@
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
=20
+#undef pr_fmt
+#define pr_fmt(fmt) DEVICE_NAME ": " fmt
+
 /* set AOE_PARTITIONS to 1 to use whole-disks only
  * default is 16, which is 15 partitions plus the whole disk
  */
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index b6dac8cee70f..6a9fc9578a6d 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -274,7 +274,7 @@ aoeblk_getgeo(struct block_device *bdev, struct hd_ge=
ometry *geo)
 	struct aoedev *d =3D bdev->bd_disk->private_data;
=20
 	if ((d->flags & DEVFL_UP) =3D=3D 0) {
-		printk(KERN_ERR "aoe: disk not up\n");
+		pr_err("disk not up\n");
 		return -ENODEV;
 	}
=20
@@ -356,7 +356,7 @@ aoeblk_gdalloc(void *vp)
 	mp =3D mempool_create(MIN_BUFS, mempool_alloc_slab, mempool_free_slab,
 		buf_pool_cache);
 	if (mp =3D=3D NULL) {
-		printk(KERN_ERR "aoe: cannot allocate bufpool for %ld.%d\n",
+		pr_err("cannot allocate bufpool for %ld.%d\n",
 			d->aoemajor, d->aoeminor);
 		goto err;
 	}
diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index a42c4bcc85ba..49e579047c99 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -79,8 +79,7 @@ static int
 interfaces(const char __user *str, size_t size)
 {
 	if (set_aoe_iflist(str, size)) {
-		printk(KERN_ERR
-			"aoe: could not set interface list: too many interfaces\n");
+		pr_err("could not set interface list: too many interfaces\n");
 		return -EINVAL;
 	}
 	return 0;
@@ -173,7 +172,7 @@ aoechr_write(struct file *filp, const char __user *bu=
f, size_t cnt, loff_t *offp
=20
 	switch ((unsigned long) filp->private_data) {
 	default:
-		printk(KERN_INFO "aoe: can't write to that file.\n");
+		pr_info("can't write to that file.\n");
 		break;
 	case MINOR_DISCOVER:
 		ret =3D discover();
@@ -290,7 +289,7 @@ aoechr_init(void)
=20
 	n =3D register_chrdev(AOE_MAJOR, "aoechr", &aoe_fops);
 	if (n < 0) {
-		printk(KERN_ERR "aoe: can't register char device\n");
+		pr_err("can't register char device\n");
 		return n;
 	}
 	init_completion(&emsgs_comp);
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index cc9077b588d7..290b92467406 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -255,7 +255,7 @@ newframe(struct aoedev *d)
 	int has_untainted;
=20
 	if (!d->targets || !d->targets[0]) {
-		printk(KERN_ERR "aoe: NULL TARGETS!\n");
+		pr_err("NULL TARGETS!\n");
 		return NULL;
 	}
 	tt =3D d->tgt;	/* last used target */
@@ -426,7 +426,7 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoemin=
or, struct sk_buff_head *qu
=20
 		skb =3D new_skb(sizeof *h + sizeof *ch);
 		if (skb =3D=3D NULL) {
-			printk(KERN_INFO "aoe: skb alloc failure\n");
+			pr_info("skb alloc failure\n");
 			dev_put(ifp);
 			continue;
 		}
@@ -955,8 +955,7 @@ ataid_complete(struct aoedev *d, struct aoetgt *t, un=
signed char *id)
 	memcpy(d->ident, id, sizeof(d->ident));
=20
 	if (d->ssize !=3D ssize)
-		printk(KERN_INFO
-			"aoe: %pm e%ld.%d v%04x has %llu sectors\n",
+		pr_info("%pm e%ld.%d v%04x has %llu sectors\n",
 			t->addr,
 			d->aoemajor, d->aoeminor,
 			d->fw_ver, (long long)ssize);
@@ -1533,7 +1532,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	 */
 	aoemajor =3D get_unaligned_be16(&h->major);
 	if (aoemajor =3D=3D 0xfff) {
-		printk(KERN_ERR "aoe: Warning: shelf address is all ones.  "
+		pr_err("Warning: shelf address is all ones.  "
 			"Check shelf dip switches.\n");
 		return;
 	}
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 3523dd82d7a0..9782c6e31448 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -411,8 +411,7 @@ skbfree(struct sk_buff *skb)
 	while (atomic_read(&skb_shinfo(skb)->dataref) !=3D 1 && i-- > 0)
 		msleep(Sms);
 	if (i < 0) {
-		printk(KERN_ERR
-			"aoe: %s holds ref: %s\n",
+		pr_err("%s holds ref: %s\n",
 			skb->dev ? skb->dev->name : "netif",
 			"cannot free skb -- memory leaked.");
 		return;
diff --git a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
index 6238c4c87cfc..a37ed6806e37 100644
--- a/drivers/block/aoe/aoemain.c
+++ b/drivers/block/aoe/aoemain.c
@@ -65,10 +65,10 @@ aoe_init(void)
 		goto cmd_fail;
 	ret =3D register_blkdev(AOE_MAJOR, DEVICE_NAME);
 	if (ret < 0) {
-		printk(KERN_ERR "aoe: can't register major\n");
+		pr_err("can't register major\n");
 		goto blkreg_fail;
 	}
-	printk(KERN_INFO "aoe: AoE v%s initialised.\n", VERSION);
+	pr_info("AoE v%s initialised.\n", VERSION);
=20
 	timer_setup(&timer, discover_timer, 0);
 	discover_timer(&timer);
@@ -86,7 +86,7 @@ aoe_init(void)
  dev_fail:
 	destroy_workqueue(aoe_wq);
=20
-	printk(KERN_INFO "aoe: initialisation failure.\n");
+	pr_info("initialisation failure.\n");
 	return ret;
 }
=20
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 923a134fd766..7c8311e7cfb0 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -102,7 +102,7 @@ set_aoe_iflist(const char __user *user_str, size_t si=
ze)
 		return -EINVAL;
=20
 	if (copy_from_user(aoe_iflist, user_str, size)) {
-		printk(KERN_INFO "aoe: copy from user failed\n");
+		pr_info("copy from user failed\n");
 		return -EFAULT;
 	}
 	aoe_iflist[size] =3D 0x00;
@@ -160,9 +160,8 @@ aoenet_rcv(struct sk_buff *skb, struct net_device *if=
p, struct packet_type *pt,
 		if (n > NECODES)
 			n =3D 0;
 		if (net_ratelimit())
-			printk(KERN_ERR
-				"%s%d.%d@%s; ecode=3D%d '%s'\n",
-				"aoe: error packet from ",
+			pr_err("%s%d.%d@%s; ecode=3D%d '%s'\n",
+				"error packet from ",
 				get_unaligned_be16(&h->major),
 				h->minor, skb->dev->name,
 				h->err, aoe_errlist[n]);
--=20
2.45.1

