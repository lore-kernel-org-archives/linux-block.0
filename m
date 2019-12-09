Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4233FC2D0C0
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 09:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C852077B
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 09:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ld0SiPNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLIJe2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:34:28 -0500
Received: from mout01.posteo.de ([185.67.36.65]:58700 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfLIJe2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Dec 2019 04:34:28 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 45F3C160061
        for <linux-block@vger.kernel.org>; Mon,  9 Dec 2019 10:34:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1575884064; bh=WKh0sIAEhxAQidqExK43MxzbufOPA+awPeWCVoz6J8k=;
        h=From:To:Cc:Subject:Date:From;
        b=ld0SiPNHHIr0xU0YACrKiiwfB2QhUmq9gZMmJXGuevqvck4JgEfhTBfduZOjbvEIJ
         YJH9+6oSVtm5O0cWz6jJqlAFncEjxSyuAQRWeAdptYa9kTeyISEChGrrSrpXvbI2KO
         a+ee9AA71HJpigFEpDc2mfvleTpOvC2KgMHrVJZF6H6l6GCbeMWNYUVz5FR01IVNMT
         xCH8gNDbEEorJrfUCR47TRQxzvrnbaKRBtDaiRrH+zGTcsfGyOap699uOHMvupgVul
         bxfmtU30wxqRvIvuMARsx3usScx6tu+b3MtGqmcbKmvrNIEiQhxMBDa+Jo4bukFsAL
         K0YhpoTPgo5tw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 47WdLk5X4sz6tmH;
        Mon,  9 Dec 2019 10:34:22 +0100 (CET)
From:   =?UTF-8?q?Moritz=20M=C3=BCller?= <moritzm.mueller@posteo.de>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Cc:     =?UTF-8?q?Moritz=20M=C3=BCller?= <moritzm.mueller@posteo.de>,
        "Philip K ." <philip@warpmail.net>
Subject: [PATCH v3] floppy: hide invalid floppy disk types
Date:   Mon,  9 Dec 2019 10:32:59 +0100
Message-Id: <20191209093258.14319-1-moritzm.mueller@posteo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <d3f0613c-6c3a-8efc-1c27-a6b75c34972f@gmail.com>
References: <d3f0613c-6c3a-8efc-1c27-a6b75c34972f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In some cases floppy disks are being indexed, even though no actual
device exists. In our case this was caused by the CMOS-RAM having a few
peculiar bits. This caused a non-existent floppy disk of the type 13 (in
our case) to be registered as an possibly mountable device, even though
it could not be mounted by any user.

We believe this to be an instance of this bug:

 https://bugzilla.kernel.org/show_bug.cgi?id=13486
 https://bugs.launchpad.net/ubuntu/+source/linux/+bug/384579

This patch adds the option FLOPPY_ALLOW_UNKNOWN_TYPES to prevent the
additional check that fixed the issue on our reference system, and
increases the startup time of affected systems by over a minute.

Co-developed-by: Philip K. <philip@warpmail.net>
Signed-off-by: Philip K. <philip@warpmail.net>
Signed-off-by: Moritz Müller <moritzm.mueller@posteo.de>
---
 drivers/block/Kconfig  | 10 ++++++++++
 drivers/block/floppy.c |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1bb8ec575352..9e6b32c50b67 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -72,6 +72,16 @@ config AMIGA_Z2RAM
 	  To compile this driver as a module, choose M here: the
 	  module will be called z2ram.
 
+config FLOPPY_ALLOW_UNKNOWN_TYPES
+	bool "Allow floppy disks of unknown type to be registered."
+	default n
+	help
+	  Select this option if you want the Kernel to register floppy
+	  disks of an unknown type.
+
+	  This should usually not be enabled, because of cases where the
+	  system falsely recognizes a non-existent floppy disk as mountable.
+
 config CDROM
 	tristate
 	select BLK_SCSI_REQUEST
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 485865fd0412..9439444d46d0 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3949,7 +3949,11 @@ static void __init config_types(void)
 			} else
 				allowed_drive_mask &= ~(1 << drive);
 		} else {
+#ifdef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
 			params = &default_drive_params[0].params;
+#else
+ 			params = UDP;
+#endif
 			snprintf(temparea, sizeof(temparea),
 				 "unknown type %d (usb?)", type);
 			name = temparea;
@@ -4518,7 +4520,10 @@ static bool floppy_available(int drive)
 		return false;
 	if (fdc_state[FDC(drive)].version == FDC_NONE)
 		return false;
+#ifndef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
+	if (UDP->cmos >= ARRAY_SIZE(default_drive_params))
+		return false;
+#endif
 	return true;
 }
 
-- 
2.20.1

