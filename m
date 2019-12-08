Return-Path: <SRS0=3zrn=Z6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC7C43603
	for <linux-block@archiver.kernel.org>; Sun,  8 Dec 2019 17:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F9020692
	for <linux-block@archiver.kernel.org>; Sun,  8 Dec 2019 17:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="hnanfFNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLHRAI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Dec 2019 12:00:08 -0500
Received: from mout01.posteo.de ([185.67.36.65]:39473 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfLHRAI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 8 Dec 2019 12:00:08 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id ABFC0160063
        for <linux-block@vger.kernel.org>; Sun,  8 Dec 2019 18:00:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1575824405; bh=YFoFHhM4VD18eShuz4mN7CRcZATk+krghvupPMPzEP4=;
        h=From:To:Cc:Subject:Date:From;
        b=hnanfFNki6YEUXmB6dssFQhzY8hOLrjsJ6lEV5hlLDpSTId9Lb8+dmOLfrH9DvvFc
         PSJx3rJ745k6XqvYFE/aQ0n/LQbYqDlD2FS4ECVUT+p/sn4ww8SzRHfWcAoqvAyyyP
         VPFHCo1dsYPGEH9y9XJynWxvSbjH1WNGByKvZgEtdSwlWtLuSgRtcxupSfQt/nKfwb
         w97cnGfMmXeMHahzGEzPdmk1mLPxAuB9pcW0C6SGHAa5uNxCmb+sqTF6TEpOa+sO3z
         QwMeiAu5lmRH+DJfn7n/EehFCmp6vxe5io1P/5HKKjM3pqo7atIxO93NQbwktsFSP1
         NQd00H24qXEGQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 47WCHT0q04z6tmG;
        Sun,  8 Dec 2019 18:00:05 +0100 (CET)
From:   =?UTF-8?q?Moritz=20M=C3=BCller?= <moritzm.mueller@posteo.de>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Cc:     =?UTF-8?q?Moritz=20M=C3=BCller?= <moritzm.mueller@posteo.de>,
        "Philip K ." <philip@warpmail.net>
Subject: [PATCH] floppy: hide invalid floppy disk types
Date:   Sun,  8 Dec 2019 17:59:00 +0100
Message-Id: <20191208165900.25588-1-moritzm.mueller@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In some cases floppy disks are recognised even though no such device
exists. In our case this has been caused by the CMOS-RAM having a few
wrong bits. This caused a non-existent floppy disk with the type 13
(for example) to be registered as an available device, even though it
could not be mounted by any user.

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
+	  system falsely recongizes a non-existent floppy disk as mountable.
+
 config CDROM
 	tristate
 	select BLK_SCSI_REQUEST
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 485865fd0412..9439444d46d0 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3949,7 +3949,9 @@ static void __init config_types(void)
 			} else
 				allowed_drive_mask &= ~(1 << drive);
 		} else {
+#ifdef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
 			params = &default_drive_params[0].params;
+#ifdef
 			snprintf(temparea, sizeof(temparea),
 				 "unknown type %d (usb?)", type);
 			name = temparea;
@@ -4518,6 +4520,10 @@ static bool floppy_available(int drive)
 		return false;
 	if (fdc_state[FDC(drive)].version == FDC_NONE)
 		return false;
+#ifndef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
+	if (type >= ARRAY_SIZE(default_drive_params))
+		return false;
+#endif
 	return true;
 }
 
-- 
2.20.1

