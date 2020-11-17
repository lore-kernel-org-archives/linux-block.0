Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEBCC2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 17:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62153217A0
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 17:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgKQRvd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Nov 2020 12:51:33 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgKQRvd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Nov 2020 12:51:33 -0500
Received: from orion.localdomain ([95.118.38.12]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MpTpc-1jtxc701JU-00prgx; Tue, 17 Nov 2020 18:51:31 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: [PATCH] drivers: block: Kconfig: indention cleanup
Date:   Tue, 17 Nov 2020 18:51:30 +0100
Message-Id: <20201117175130.6798-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:mZ2RaeE0WlohBHryGDQHPN0hjye2+k7L9HbGwkjDVzD7RolnPtI
 jtEnPZRj6rOwdSuNCilqyGKBkAqvw2dRyGvzYeiivmShOOQhLiz1w/tvDI3Pr/aLEOj4a1u
 ti5jibkHazcO9FhP8rU31rFBHtGEHmDcukwgQrWtVQ6+ijr2kWmG3A9VEXpXkVL63FR1+2L
 rlBU2g8ycCIBSszcPAfiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t4x1dtKWYm4=:YPvqAJfQSN+iBNpvwqr014
 kk8c0ktL4GWrPUn02mbo0sPR+jd0SxwNciRJCadsXByONgwemQgtR6TnGEWo/7xNvcmcaqBEV
 BlcnODqHFc0Q0gAQCDFzV/SD75pVWRXMnJc4S8uFOslighCc5YQujJhX17ACs3uAaDxy9FAFB
 wtxuPLUqW0fi6VTAtNoXFqw0WkAtFybczu9i/U3qpeZb/nx2+jmaOegzxvf3XsWitG4sVQKM5
 +C2Y96qe6cBeGmi7P8zE4t25B0L117Z7iBh0JX6AgrS1omEu+ajQ3NTRBzBTqVDMxYGTEA7bA
 qUAeE6fazLMLWA+6W4T2qMlym1ODqp1wSTsujsvQMS9PgMR7u8i/+ine89x9h5UTf2UosX5Aj
 W3E1NZaou5kjldvXofLGSyzXtdGZXyP27o1zKX/BU8Q5vrqFhBZtPQOGtr2Nx
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Making the indentions in Kconfig file a bit more consistent.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/block/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index ecceaaa1a66f..48fee9be3cf8 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -142,10 +142,10 @@ config BLK_DEV_UBD
 	bool "Virtual block device"
 	depends on UML
 	help
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
 	help
 	  This is the virtual block driver for virtio.  It can be used with
-          QEMU based VMMs (like KVM or Xen).  Say Y or M.
+	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
 config BLK_DEV_RBD
 	tristate "Rados block device (RBD)"
-- 
2.11.0

