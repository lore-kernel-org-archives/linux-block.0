Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA059C432C0
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D6E208A1
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306350;
	bh=TPz5EgcuOBWB3eKu+t5L++624Br3DKKb2jnElgd4ADM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=n7zvYMWNS6scBI2mtnXLfGpqRRzJAu6H5PbrmwxTutq5OESG6o27ro61lAc2SQuRM
	 COZm3BDRsi9jczjTu5RxtonsPVM6vHbNedbp903czzsBrKWB67Kxi3gv4P1AehLh4Z
	 2u91wkXjdXwCW/41FGf20M2q9ZP930j4QcxB+Uaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKUDTJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:19:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKUDTJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:09 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2537820721;
        Thu, 21 Nov 2019 03:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306348;
        bh=TPz5EgcuOBWB3eKu+t5L++624Br3DKKb2jnElgd4ADM=;
        h=From:To:Cc:Subject:Date:From;
        b=X1rWb2kJtwT/XvLPH6WcQrDch7Xhcu4VIHH2NGjxICLVYGKq0bsFPNPQmK4S+GbXB
         hgHdXmIkpQw/WiqP8HG0s2fTzysuGgsDK/33Edenab+weWQH4oxvykbqlPhnGNnP9y
         nFCadSKsplCX7k6s5BMoS9NtCrUhgxaukZcYOWxc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH v2] block: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:05 +0100
Message-Id: <1574306345-29160-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 block/Kconfig                  | 14 +++++++-------
 block/Kconfig.iosched          | 12 ++++++------
 drivers/block/Kconfig          | 28 ++++++++++++++--------------
 drivers/block/mtip32xx/Kconfig |  2 +-
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 9fa6ce2177bc..ec3b958f0a23 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -3,11 +3,11 @@
 # Block layer core configuration
 #
 menuconfig BLOCK
-       bool "Enable the block layer" if EXPERT
-       default y
-       select SBITMAP
-       select SRCU
-       help
+	bool "Enable the block layer" if EXPERT
+	default y
+	select SBITMAP
+	select SRCU
+	help
 	 Provide block layer support for the kernel.
 
 	 Disable this option to remove the block layer support from the
@@ -171,8 +171,8 @@ config BLK_DEBUG_FS
 	say Y here.
 
 config BLK_DEBUG_FS_ZONED
-       bool
-       default BLK_DEBUG_FS && BLK_DEV_ZONED
+	bool
+	default BLK_DEBUG_FS && BLK_DEV_ZONED
 
 config BLK_SED_OPAL
 	bool "Logic for interfacing with Opal enabled SEDs"
diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 7df14133adc8..b11a421b7387 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -29,13 +29,13 @@ config IOSCHED_BFQ
 	Documentation/block/bfq-iosched.rst
 
 config BFQ_GROUP_IOSCHED
-       bool "BFQ hierarchical scheduling support"
-       depends on IOSCHED_BFQ && BLK_CGROUP
-       select BLK_CGROUP_RWSTAT
-       ---help---
+	bool "BFQ hierarchical scheduling support"
+	depends on IOSCHED_BFQ && BLK_CGROUP
+	select BLK_CGROUP_RWSTAT
+	---help---
 
-       Enable hierarchical scheduling in BFQ, using the blkio
-       (cgroups-v1) or io (cgroups-v2) controller.
+	Enable hierarchical scheduling in BFQ, using the blkio
+	(cgroups-v1) or io (cgroups-v2) controller.
 
 config BFQ_CGROUP_DEBUG
 	bool "BFQ IO controller debugging"
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1bb8ec575352..fa0cd072f5a1 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -142,10 +142,10 @@ config BLK_DEV_UBD
 	bool "Virtual block device"
 	depends on UML
 	---help---
-          The User-Mode Linux port includes a driver called UBD which will let
-          you access arbitrary files on the host computer as block devices.
-          Unless you know that you do not need such virtual block devices say
-          Y here.
+	  The User-Mode Linux port includes a driver called UBD which will let
+	  you access arbitrary files on the host computer as block devices.
+	  Unless you know that you do not need such virtual block devices say
+	  Y here.
 
 config BLK_DEV_UBD_SYNC
 	bool "Always do synchronous disk IO for UBD"
@@ -156,16 +156,16 @@ config BLK_DEV_UBD_SYNC
 	  Linux 'Virtual Machine' uses a journalling filesystem and the host
 	  computer crashes.
 
-          Synchronous operation (i.e. always writing data to the host's disk
-          immediately) is configurable on a per-UBD basis by using a special
-          kernel command line option.  Alternatively, you can say Y here to
-          turn on synchronous operation by default for all block devices.
+	  Synchronous operation (i.e. always writing data to the host's disk
+	  immediately) is configurable on a per-UBD basis by using a special
+	  kernel command line option.  Alternatively, you can say Y here to
+	  turn on synchronous operation by default for all block devices.
 
-          If you're running a journalling file system (like reiserfs, for
-          example) in your virtual machine, you will want to say Y here.  If
-          you care for the safety of the data in your virtual machine, Y is a
-          wise choice too.  In all other cases (for example, if you're just
-          playing around with User-Mode Linux) you can choose N.
+	  If you're running a journalling file system (like reiserfs, for
+	  example) in your virtual machine, you will want to say Y here.  If
+	  you care for the safety of the data in your virtual machine, Y is a
+	  wise choice too.  In all other cases (for example, if you're just
+	  playing around with User-Mode Linux) you can choose N.
 
 config BLK_DEV_COW_COMMON
 	bool
@@ -430,7 +430,7 @@ config VIRTIO_BLK
 	depends on VIRTIO
 	---help---
 	  This is the virtual block driver for virtio.  It can be used with
-          QEMU based VMMs (like KVM or Xen).  Say Y or M.
+	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
 config VIRTIO_BLK_SCSI
 	bool "SCSI passthrough request for the Virtio block driver"
diff --git a/drivers/block/mtip32xx/Kconfig b/drivers/block/mtip32xx/Kconfig
index bf221358567e..a469dc72e67a 100644
--- a/drivers/block/mtip32xx/Kconfig
+++ b/drivers/block/mtip32xx/Kconfig
@@ -7,4 +7,4 @@ config BLK_DEV_PCIESSD_MTIP32XX
 	tristate "Block Device Driver for Micron PCIe SSDs"
 	depends on PCI
 	help
-          This enables the block driver for Micron PCIe SSDs.
+	  This enables the block driver for Micron PCIe SSDs.
-- 
2.7.4

