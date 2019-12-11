Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D69C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD716222C4
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 20:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLKUrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:47:17 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:39917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLKUrR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 15:47:17 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mo73N-1hvNrF2EZP-00pfdu; Wed, 11 Dec 2019 21:46:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denis Efremov <efremov@linux.com>,
        Tim Waugh <tim@cyberelk.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH 11/24] compat_ioctl: block: handle cdrom compat ioctl in non-cdrom drivers
Date:   Wed, 11 Dec 2019 21:42:45 +0100
Message-Id: <20191211204306.1207817-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:J/m2/bKJ2+pQDxQ1q226bByLe0vDPb/F2fJ3RpYYYVapImzb8aV
 HWSvDBZiFBEiHXWH/xWL1jk4hQERohAteHEMq2lpbMCC2anNojNV6PsQ+gg2WufxemHktc1
 LyPWs3HbVs920rfFkymL5JQsEGJs//HvxV5XmvoL8txVyvk9ot9sTr81q1MSSw2dd/7OnwF
 PZSWIVICg0YVKDXL6K7dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DV6o32cCptM=:l/Of3UL40h1Gs6yrtcWn+e
 4767u/NI/4g42ftlcB1rmhfV1JWoVD4LaYYo0JaTG5s6dC/UvDLk5wUO/rzT35d0X74aGK/vw
 ZzuO5Sfiuyu3sh/R3qDuNr/OBJp8ZGii/aLBpIMxXHpzZMFfmKfvecMGNOmA+Gq50FsJkxQaR
 A2zIFRydZ47PpZefsLdEoTKcgvLPHb7Tm2GNslBvrDX6Rr0I67QRiTc3YLRBlX9ynDTUJXLwo
 LnOc0sqAlB/PtptI8I5TK/uxN/S5T//2LOTZDmsxpeWiocQBjRJO14A5K7cMEnIY5B+RHLxek
 gAAdg/nxcAUOceYLoJ1sP19//eXcqy50vqxRWFQNMqWG97Ve3eZdRRqduUhY+3JgZoF6FO6ZM
 aKBa4A1eJ/aKXU76mR9r9lvT4iABkg+0Sm/Cve2dyCTvhA7VAI7sksverbtJVW/2KJprZ72MV
 08/bikqWwwtd6GA0LKYzaRw/wNglfuToitJxn/a5LHf8tW2PKFth3O94FGIpiM3E4sXQBfAhr
 2WjnWXsWaxPtkJ6iijJeH9BfwCpmm5Qh4ConI9X0elJLxTbPZOGVFZPZQd+f07OvVTik2n8Fb
 6OrV2ynOjoohTm2MB0FpMDmjqPLVBSRArhIsvcb7uccbkHxfyKOs863DIYP3ChrqLvP1P/eck
 R9A8Rw1bnHmWjp3UtoQC5renptBxT3Jkw9nS5C4tvW1jF0+DYl6fBO8tXkud7GXVPsmUnHc72
 x+rBx1bA9kL3BV/2+7ZL27IZYx33bCjbMjeNGZFuOk5xhCQCnVUQDJicSDSNQwZCX7+86Y4eQ
 GEH8mehP/lSQ9dzTDymYLxem9zZdxhtFq5yFvsTCm1McKxM6Nf3brzo9Rm1bSQ/dHk1u2HGUz
 KOjNZeK9kNw+4KJDAdxQ==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Various block drivers implement the CDROMMULTISESSION,
CDROM_GET_CAPABILITY, and CDROMEJECT ioctl commands, relying on the
block layer to handle compat_ioctl mode for them.

Move this into the drivers directly as a preparation for simplifying
the block layer later.

Since some of these commands need a compat_ptr() conversion,
introduce a blkdev_compat_ptr_ioctl() helper function that
can be used as the .compat_ioctl callback for those drivers
that only support compatible commands.

The actual CD-ROM drivers that call cdrom_ioctl() are
converted in a separate patch.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/ioctl.c                | 21 +++++++++++++++++++++
 drivers/block/floppy.c       |  3 +++
 drivers/block/paride/pd.c    |  1 +
 drivers/block/paride/pf.c    |  1 +
 drivers/block/sunvdc.c       |  1 +
 drivers/block/xen-blkfront.c |  1 +
 include/linux/blkdev.h       |  7 +++++++
 7 files changed, 35 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 5de98b97af2a..e728331d1a5b 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/capability.h>
+#include <linux/compat.h>
 #include <linux/blkdev.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
@@ -285,6 +286,26 @@ int __blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
  */
 EXPORT_SYMBOL_GPL(__blkdev_driver_ioctl);
 
+#ifdef CONFIG_COMPAT
+/*
+ * This is the equivalent of compat_ptr_ioctl(), to be used by block
+ * drivers that implement only commands that are completely compatible
+ * between 32-bit and 64-bit user space
+ */
+int blkdev_compat_ptr_ioctl(struct block_device *bdev, fmode_t mode,
+			unsigned cmd, unsigned long arg)
+{
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (disk->fops->ioctl)
+		return disk->fops->ioctl(bdev, mode, cmd,
+					 (unsigned long)compat_ptr(arg));
+
+	return -ENOIOCTLCMD;
+}
+EXPORT_SYMBOL(blkdev_compat_ptr_ioctl);
+#endif
+
 static int blkdev_pr_register(struct block_device *bdev,
 		struct pr_registration __user *arg)
 {
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 485865fd0412..cd3612e4e2e1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3879,6 +3879,9 @@ static int fd_compat_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 {
 	int drive = (long)bdev->bd_disk->private_data;
 	switch (cmd) {
+	case CDROMEJECT: /* CD-ROM eject */
+	case 0x6470:	 /* SunOS floppy eject */
+
 	case FDMSGON:
 	case FDMSGOFF:
 	case FDSETEMSGTRESH:
diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 6f9ad3fc716f..c0967507d085 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -874,6 +874,7 @@ static const struct block_device_operations pd_fops = {
 	.open		= pd_open,
 	.release	= pd_release,
 	.ioctl		= pd_ioctl,
+	.compat_ioctl	= pd_ioctl,
 	.getgeo		= pd_getgeo,
 	.check_events	= pd_check_events,
 	.revalidate_disk= pd_revalidate
diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index 6b7d4cab3687..bb09f21ce21a 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -276,6 +276,7 @@ static const struct block_device_operations pf_fops = {
 	.open		= pf_open,
 	.release	= pf_release,
 	.ioctl		= pf_ioctl,
+	.compat_ioctl	= pf_ioctl,
 	.getgeo		= pf_getgeo,
 	.check_events	= pf_check_events,
 };
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 571612e233fe..39aeebc6837d 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -171,6 +171,7 @@ static const struct block_device_operations vdc_fops = {
 	.owner		= THIS_MODULE,
 	.getgeo		= vdc_getgeo,
 	.ioctl		= vdc_ioctl,
+	.compat_ioctl	= blkdev_compat_ptr_ioctl,
 };
 
 static void vdc_blk_queue_start(struct vdc_port *port)
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index a74d03913822..23c86350a5ab 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2632,6 +2632,7 @@ static const struct block_device_operations xlvbd_block_fops =
 	.release = blkif_release,
 	.getgeo = blkif_getgeo,
 	.ioctl = blkif_ioctl,
+	.compat_ioctl = blkdev_compat_ptr_ioctl,
 };
 
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 47eb22a3b7f9..3e0408618da7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1711,6 +1711,13 @@ struct block_device_operations {
 	const struct pr_ops *pr_ops;
 };
 
+#ifdef CONFIG_COMPAT
+extern int blkdev_compat_ptr_ioctl(struct block_device *, fmode_t,
+				      unsigned int, unsigned long);
+#else
+#define blkdev_compat_ptr_ioctl NULL
+#endif
+
 extern int __blkdev_driver_ioctl(struct block_device *, fmode_t, unsigned int,
 				 unsigned long);
 extern int bdev_read_page(struct block_device *, sector_t, struct page *);
-- 
2.20.0

