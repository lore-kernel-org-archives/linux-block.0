Return-Path: <SRS0=usZV=ZM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87129C432C0
	for <linux-block@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C14D22528
	for <linux-block@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257378;
	bh=mcshde1DXfPlrTcso7HevGxkj/tsZLZId92qk1mAbV4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nY5MRBwfaNXROy7qmbqNJbUTOEcu4xueDR5HyBgLqjnO5NI0DLnY8wS5tzYloE+nI
	 W5WRSVg/u39/9I3mCBFeq0E4Yv4EEkWSy6s+0oSIXFlkW/mYsXDpDeUo1mqaiRGup5
	 Lb0bC+0FOaeVyGOGuigc42QuEgn3T9MknMZnTwCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfKTNm5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:42:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbfKTNm4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:56 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081AB224FC;
        Wed, 20 Nov 2019 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257376;
        bh=mcshde1DXfPlrTcso7HevGxkj/tsZLZId92qk1mAbV4=;
        h=From:To:Cc:Subject:Date:From;
        b=rXRH0AUI5l8YdAs6ip+DUnHABA3BVOMvgunFz7rPz6Hac9d+khiyYIlWhNpo/5M1J
         lz73qXW4lMGc+juwkL5kN1riPG27w5/7My/xiIny7wL5bNRz1WVmU0mEnDgaGG/sf9
         cUOvg4T+R6dNo2vpTSWw4VG1uC8SNkmQlEtBKQZ4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] block: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:52 +0800
Message-Id: <20191120134252.16129-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/block/Kconfig          | 28 ++++++++++++++--------------
 drivers/block/mtip32xx/Kconfig |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

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
2.17.1

