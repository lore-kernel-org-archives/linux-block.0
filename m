Return-Path: <SRS0=T2Jf=2X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAF8C2D0DC
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 15:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1B42072C
	for <linux-block@archiver.kernel.org>; Thu,  2 Jan 2020 15:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgABPAA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:00:00 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:38155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgABPAA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 10:00:00 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MRC7g-1j80hl0TzQ-00NCqd; Thu, 02 Jan 2020 15:59:41 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Denis Efremov <efremov@linux.com>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v3 09/22] compat_ioctl: block: handle cdrom compat ioctl in non-cdrom drivers
Date:   Thu,  2 Jan 2020 15:55:27 +0100
Message-Id: <20200102145552.1853992-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wdBfmrr02CDq12M4nkT7pYNOf7/IjRYzD6XaAXcfqVJrqqMMGD4
 Mj1RZUqzgSy3Zk9mHA3hDqTUTSPM2zyioOW8jhhA1emfYvfFwxO+++Pe9hS9QA4czZwQg6k
 4MKhacs+eRa3ix03OK5bjf21w6KCI94uyIGo7K/HqOPIsCwIUA6+IKC9zLuD0yBNFu2gdqy
 nI8s23bcuYnMA59aKrR6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vqvyIdRboDI=:4G6b2uAPholNj2UDYiYmio
 JDXbP4extzMTSJHJgAyBUUCyBnivB++pBb80Vcp87nHRYSpxu2qXNgFymOZpoQXAwlejNRI8w
 ba59u58QOcgD2QKRCt0jPhzU+N4dn/EBnBZiB09mZPCpuMdAmhx6KYdAzdzCl441XvV2bBhqy
 qyprK6D1Kc3S/A9ngV1tZ3cKUB/2ndb4cHtqSg6ajI3StbJFA75on6GaNbqOdul6R+JiODwVm
 Wvd6/wb+1tnKN7jyyMhrLM+gvjg57Ze+cwLOwa+Xv8TsumZYtuMsdvw6XPLMOekb4Pnw6ibY4
 aYVXfZ24lB7yDNpF1z2eqx4wItOZxb4uN9DwVANPeXiBYgBCfYN3rj+ke2bU8975XxeCMLE99
 kcPi6glqkmKk8dHxM9220A/YNhoJOuyg9f5jN7TxWIA1V2oXvG3MxdXbyx5YjipMJs6Y23nG7
 jd/M3t8I0ck1nv/gn3/c51IYY66Mcggsz28Rn/3mV1f9yIrCGKGd4Aikip43xz40YZsXLkUhg
 MLwabVeTnSpKKlcDL4UvkdSAB+BjlnwpRtSTmBdMYN61wukrYTQXZs5UuxN5BcfnH+Zjdgkw1
 ztwz+WhkzdS+maadwl1X2syIckfFIOStWau12zybQUEknzc9iCGfn6Q5f7QKvLIjmJYC42pBA
 nhOsEM+SgSh+DKojLrUhxVsZ1AwzMdUDp6UgIFJHIY47ugiqUCJD/MnVOJRkIOMpFE6QAg9xy
 uisF1/f5wpGcN9Lh5RA+fs4RDKg2dcXPkozJl3diLjS0apQhlkWBRBjkDdPuxAlBTujiuBZDm
 kH6M268ja7s+OktpaLNIl6o6/KCND2KWfDcgNPWNZ0BsU69eU2eQ+08k1NVyU9HDLb2phBonK
 ltQ8HA/kA1Rq2ZBOf41w==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Various block drivers implement the CDROMMULTISESSION,
CDROM_GET_CAPABILITY, and CDROMEJECT ioctl commands, relying on the
block layer to handle compat_ioctl mode for them.

Move this into the drivers directly as a preparation for simplifying
the block layer later.

When only integer arguments or no arguments are passed, the
same handler can be used for .ioctl and .compat_ioctl, and
when only pointer arguments are passed, the newly added
blkdev_compat_ptr_ioctl can be used.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/floppy.c       | 3 +++
 drivers/block/paride/pd.c    | 1 +
 drivers/block/paride/pf.c    | 1 +
 drivers/block/sunvdc.c       | 1 +
 drivers/block/xen-blkfront.c | 1 +
 5 files changed, 7 insertions(+)

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
index c02be06c5299..57d50c5ba309 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2632,6 +2632,7 @@ static const struct block_device_operations xlvbd_block_fops =
 	.release = blkif_release,
 	.getgeo = blkif_getgeo,
 	.ioctl = blkif_ioctl,
+	.compat_ioctl = blkdev_compat_ptr_ioctl,
 };
 
 
-- 
2.20.0

