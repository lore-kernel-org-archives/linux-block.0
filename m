Return-Path: <SRS0=i0oD=EB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E89C2D0A3
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 08:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024642240C
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 08:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl79HKs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771273AbgJZIwR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 04:52:17 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40990 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441099AbgJZIwR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 04:52:17 -0400
Received: by mail-qv1-f67.google.com with SMTP id t20so3914756qvv.8;
        Mon, 26 Oct 2020 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ81NUuIemJAy2R0JSstUiGK8+6LXbAftpC5+8me1yM=;
        b=Nl79HKs/B0/VVhY56WShizUovm7xkXKRiCSFO6bV7Tn0roJl41Ns1LfdX2Cea4/uqY
         GWZ7p2n3NdpCYBIyhddQlLFnQBdQkOUFIiVFjwxrn1cZAcjxGMjKAtsA7RmRUVhRsCsR
         bCsYGhu59F0bzIgrUTC7VG/YCwMJNX9pYTt6gezfPEeyr/wGiVQbMZaMmcM2eJpAQEqI
         tbCGf6YS+KwysDQOhoetRvSMMotFEdweLG8RG1Gc6bucVMNl4a8akCBdmJ2XW+tD+K/6
         D/m05xejhXv45Da52ZIw+PjYrqMMKe8XcyQZvqpqUD2WOf0cN0hAW3vOQ8aRy2GIyvPn
         7e6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ81NUuIemJAy2R0JSstUiGK8+6LXbAftpC5+8me1yM=;
        b=fNk5s95fTyLS3oaCsNt6zwUiAE9+UOSNWVeZkzPgA16DIOJbet1gH+HsK5LKRHIM8A
         kP+gpPzX6Pf14AQhou7cc9IZxHwffilD0ef0ddzz5hoIdXmWqX0uEI7wMzZBwTxXqUwA
         E7KasQeTouWVvCx5t1jgM/DYeVw97lsX/JBChJBEjpY9zvtKeyn0JSm/Z56yRWtX8Vo5
         g5u6fsfTd8P5gauEP5iKAAbu5I54gc4DmzkEAgJDYt23P/sDVC7a481gwaK1PJT7C7A9
         JFb4Qskz1OHNjXBiqHrAaLpbWoIzLHdEMGtG1Zch2JkhaX4W/2bnM2chw4vdn3c83e05
         umyw==
X-Gm-Message-State: AOAM530Pkh2OpRUN93vsNpaFWlszrZXK2d6fjaWf2RP7ox5v3sL3sf+F
        YSdCyq+U1GzKOYB1BKh8LA==
X-Google-Smtp-Source: ABdhPJyXJ7X/NnUP1OIhMYSAioiVhE5tmIEdaqJ0RTK/67sLtcw4pW0TWpDQYLR2s1+wGc3HFc4RJw==
X-Received: by 2002:ad4:5191:: with SMTP id b17mr12807357qvp.0.1603702335629;
        Mon, 26 Oct 2020 01:52:15 -0700 (PDT)
Received: from presler.lan (a95-94-69-32.cpe.netcabo.pt. [95.94.69.32])
        by smtp.gmail.com with ESMTPSA id 128sm5961352qkh.53.2020.10.26.01.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 01:52:15 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH v3] zram: break the strict dependency from lzo
Date:   Mon, 26 Oct 2020 08:51:41 +0000
Message-Id: <20201026085141.1179-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's nothing special about zram and lzo. It works just fine without it, so
as long as at least one of the other supported compression algorithms is
selected.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
v3: fix the default selection when lzo isn't present. Rebase against 5.10-rc1.
v2: fix the dependency on CRYPTO.

 drivers/block/zram/Kconfig    |  6 +++++-
 drivers/block/zram/zcomp.c    |  2 ++
 drivers/block/zram/zram_drv.c | 14 +++++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fe7a4b7d30cf..14b2b098d662 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -2,7 +2,6 @@
 config ZRAM
 	tristate "Compressed RAM block device support"
 	depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
-	select CRYPTO_LZO
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
 	  Pages written to these disks are compressed and stored in memory
@@ -37,3 +36,8 @@ config ZRAM_MEMORY_TRACKING
 	  /sys/kernel/debug/zram/zramX/block_state.
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
+
+config ZRAM_AUTOSEL_ALGO
+	def_bool y
+	depends on ZRAM && !(CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842 || CRYPTO_ZSTD)
+	select CRYPTO_LZO
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 33e3b76c4fa9..052aa3f65514 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -15,8 +15,10 @@
 #include "zcomp.h"
 
 static const char * const backends[] = {
+#if IS_ENABLED(CONFIG_CRYPTO_LZO)
 	"lzo",
 	"lzo-rle",
+#endif
 #if IS_ENABLED(CONFIG_CRYPTO_LZ4)
 	"lz4",
 #endif
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1b697208d661..2ae09561ba79 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -42,7 +42,19 @@ static DEFINE_IDR(zram_index_idr);
 static DEFINE_MUTEX(zram_index_mutex);
 
 static int zram_major;
-static const char *default_compressor = "lzo-rle";
+
+static const char *default_compressor =
+#if IS_ENABLED(CONFIG_CRYPTO_LZO)
+	"lzo-rle";
+#elif IS_ENABLED(CONFIG_CRYPTO_LZ4)
+	"lz4";
+#elif IS_ENABLED(CONFIG_CRYPTO_LZ4HC)
+	"lz4hc";
+#elif IS_ENABLED(CONFIG_CRYPTO_842)
+	"842";
+#elif IS_ENABLED(CONFIG_CRYPTO_ZSTD)
+	"zstd";
+#endif
 
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
-- 
2.28.0

