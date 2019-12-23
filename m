Return-Path: <SRS0=vQdV=2N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF23EC2D0C0
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 08:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C709A2073A
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 08:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfLWIN6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:13:58 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59898 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfLWIN6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Dec 2019 03:13:58 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ijIqi-0008Uc-Kv; Mon, 23 Dec 2019 16:13:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ijIqd-0008Jf-Hj; Mon, 23 Dec 2019 16:13:51 +0800
Date:   Mon, 23 Dec 2019 16:13:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: Allow t10-pi to be modular
Message-ID: <20191223081351.gsunwl6zwcltfdy6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently t10-pi can only be built into the block layer which via
crc-t10dif pulls in a whole chunk of the Crypto API.  In fact all
users of t10-pi work as modules and there is no reason for it to
always be built-in.

This patch adds a new hidden option for t10-pi that is selected
automatically based on BLK_DEV_INTEGRITY and whether the users
of t10-pi are built-in or not.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/block/Kconfig b/block/Kconfig
index c23094a14a2b..3bc76bb113a0 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -66,7 +66,6 @@ config BLK_DEV_BSGLIB
 
 config BLK_DEV_INTEGRITY
 	bool "Block layer data integrity support"
-	select CRC_T10DIF if BLK_DEV_INTEGRITY
 	---help---
 	Some storage devices allow extra information to be
 	stored/retrieved to help protect the data.  The block layer
@@ -77,6 +76,11 @@ config BLK_DEV_INTEGRITY
 	T10/SCSI Data Integrity Field or the T13/ATA External Path
 	Protection.  If in doubt, say N.
 
+config BLK_DEV_INTEGRITY_T10
+	tristate
+	depends on BLK_DEV_INTEGRITY
+	select CRC_T10DIF
+
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
 	select MQ_IOSCHED_DEADLINE
diff --git a/block/Makefile b/block/Makefile
index 205a5f2fef17..f6cef6d4363c 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -27,7 +27,8 @@ obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
 
 obj-$(CONFIG_BLOCK_COMPAT)	+= compat_ioctl.o
 obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
-obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
+obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o
+obj-$(CONFIG_BLK_DEV_INTEGRITY_T10)	+= t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
 obj-$(CONFIG_BLK_MQ_VIRTIO)	+= blk-mq-virtio.o
 obj-$(CONFIG_BLK_MQ_RDMA)	+= blk-mq-rdma.o
diff --git a/block/t10-pi.c b/block/t10-pi.c
index f4907d941f03..d910534b3a41 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -7,6 +7,7 @@
 #include <linux/t10-pi.h>
 #include <linux/blkdev.h>
 #include <linux/crc-t10dif.h>
+#include <linux/module.h>
 #include <net/checksum.h>
 
 typedef __be16 (csum_fn) (void *, unsigned int);
@@ -280,3 +281,5 @@ const struct blk_integrity_profile t10_pi_type3_ip = {
 	.complete_fn		= t10_pi_type3_complete,
 };
 EXPORT_SYMBOL(t10_pi_type3_ip);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index c6439638a419..b9358db83e96 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NVME_CORE
 	tristate
+	select BLK_DEV_INTEGRITY_T10 if BLK_DEV_INTEGRITY
 
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 90cf4691b8c3..a7881f8eb05e 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -68,6 +68,7 @@ comment "SCSI support type (disk, tape, CD-ROM)"
 config BLK_DEV_SD
 	tristate "SCSI disk support"
 	depends on SCSI
+	select BLK_DEV_INTEGRITY_T10 if BLK_DEV_INTEGRITY
 	---help---
 	  If you want to use SCSI hard disks, Fibre Channel disks,
 	  Serial ATA (SATA) or Parallel ATA (PATA) hard disks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
