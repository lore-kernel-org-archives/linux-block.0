Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FC5C2D0E4
	for <linux-block@archiver.kernel.org>; Sun, 15 Nov 2020 21:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100A12242E
	for <linux-block@archiver.kernel.org>; Sun, 15 Nov 2020 21:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKOVra (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Nov 2020 16:47:30 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60952 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgKOVra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Nov 2020 16:47:30 -0500
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 8E5553A6138
        for <linux-block@vger.kernel.org>; Sun, 15 Nov 2020 21:42:28 +0000 (UTC)
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 1F1B71C0004;
        Sun, 15 Nov 2020 21:41:56 +0000 (UTC)
Date:   Sun, 15 Nov 2020 13:41:53 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH RESEND] nbd: Support Kconfig configuration of nbds_max and
 max_part
Message-ID: <f0a162a4c7073e3ed47d981b86d845d3bb9aa955.1605476443.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This allows configuring them at compile time, rather than via the kernel
command line or module parameters. This doesn't change the default
defaults, just makes them configurable.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/block/Kconfig | 28 ++++++++++++++++++++++++++++
 drivers/block/nbd.c   | 10 ++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index ecceaaa1a66f..7df9a9609aee 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -273,6 +273,34 @@ config BLK_DEV_NBD
 
 	  If unsure, say N.
 
+config BLK_DEV_NBD_DEFAULT_NBDS_MAX
+	int "Default maximum number of NBD devices"
+	depends on BLK_DEV_NBD
+	default 16
+	help
+	  The NBD driver can provide a set of unconfigured NBD devices (nbd0,
+	  nbd1, ...) by default, so that userspace can open and configure these
+	  devices via the ioctl interface. If you know that your userspace uses
+	  exclusively the new netlink interface, you can set this to 0 to
+	  reduce the amount of time needed for the NBD driver to initialize.
+	  You can also set this parameter at runtime using the nbds_max module
+	  parameter.
+
+config BLK_DEV_NBD_DEFAULT_MAX_PART
+	int "Default maximum number of NBD device partitions"
+	depends on BLK_DEV_NBD
+	default 16
+	help
+	  Once an NBD device is set up and opened, the kernel can probe it for
+	  partitions, and set up corresponding devices for each partition
+	  (nbd0p1, nbd0p2, ...). By default, the kernel probes for up to 16
+	  partitions per device. This also adds a bit of time to NBD device
+	  initialization. You can set this to a lower number if you know you'll
+	  never use more than that many partitions on an NBD device. If you
+	  exclusively use unpartitioned NBD devices, you can set this to 0 to
+	  skip partition probing entirely.  You can also set this parameter at
+	  runtime using the max_part module parameter.
+
 config BLK_DEV_SKD
 	tristate "STEC S1120 Block Driver"
 	depends on PCI
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index edf8b632e3d2..42851956c9ce 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -145,8 +145,8 @@ static struct dentry *nbd_dbg_dir;
 
 #define NBD_DEF_BLKSIZE 1024
 
-static unsigned int nbds_max = 16;
-static int max_part = 16;
+static unsigned int nbds_max = CONFIG_BLK_DEV_NBD_DEFAULT_NBDS_MAX;
+static int max_part = CONFIG_BLK_DEV_NBD_DEFAULT_MAX_PART;
 static int part_shift;
 
 static int nbd_dev_dbg_init(struct nbd_device *nbd);
@@ -2456,6 +2456,8 @@ MODULE_DESCRIPTION("Network Block Device");
 MODULE_LICENSE("GPL");
 
 module_param(nbds_max, int, 0444);
-MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: 16)");
+MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: "
+	__stringify(CONFIG_BLK_DEV_NBD_DEFAULT_NBDS_MAX) ")");
 module_param(max_part, int, 0444);
-MODULE_PARM_DESC(max_part, "number of partitions per device (default: 16)");
+MODULE_PARM_DESC(max_part, "number of partitions per device (default: "
+	__stringify(CONFIG_BLK_DEV_NBD_DEFAULT_MAX_PART) ")");
-- 
2.29.2

