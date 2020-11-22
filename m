Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB57C5519F
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 09:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6192075E
	for <linux-block@archiver.kernel.org>; Sun, 22 Nov 2020 09:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1/dHNqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgKVJu7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Nov 2020 04:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgKVJu6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Nov 2020 04:50:58 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C081C0613CF;
        Sun, 22 Nov 2020 01:50:58 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id w8so12866554ilg.12;
        Sun, 22 Nov 2020 01:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnKYol3awXSMBEJA5H/D1Fjrf0eIceqD/ij7jv9spx8=;
        b=H1/dHNqURhbHwNQo0ZoQVdwDOEz21oyfSPqSOVz0E02Pg/HKJczuk4Yown9FbW/f2s
         9pT4bTL/W5S+iy56UlIV1m9eIYf3aiAtbgLJZN8Gkarap4M+NyFUHa/u02XZWWwD/KSq
         GSvfHYvLTvXiGYlVsiLspCi7Fz2IV9RNNlPRVcF+6X/H62NnRtuoO8DMK7e/0XBmzRa5
         uEiya1VOCJCWJjSYDcfOT50p8iEq9DegJ8J6RzYV/4wcu6HLOa1LC8MqiOClGua7bj9A
         qdkqDLjfX70SRYA3V6XaDj0sxv3GN50cpti8MNTX2sL8Q0rBCIBy4xT4QhbPZCNHo7Ip
         8shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnKYol3awXSMBEJA5H/D1Fjrf0eIceqD/ij7jv9spx8=;
        b=huPjOfmTuRxP2Nz20YEhaNPdIXC10T5iL7VyGhKv3oPGGYogf/6xVJTtiYVA2BXQSu
         S8j9/hhil6rXerMAWwJ4JJbC0WuUzpiAbpmKO+kuajUUHd3D8pWm6SGB6n2rucifKGYT
         b+mIRtgglQFCpoq3li0IGL7/HdLXHkOc6C5+mc7Xhr/JCjP5DlFHsZTRYtA1+FVUTdbz
         9jvsVk7UA//uY2oI72WsFyoIA4gTI3jp8sRlYoBaOdTfFQ4a2D+QJQNaqWcscTcvRj0v
         MWR0DyqBzR34UEO5al7/y/m+6rOmIqeAcV3U+RJKOrmBsgwuxkWmAUw/8DSVPqhlctXw
         Jwsg==
X-Gm-Message-State: AOAM530pF6PtJ2l7GnlTDA3nyIRjAIfa9fYbb5AWibyk5G3nPrdaf9Yw
        ZFm6O3q7OZm3yfHLAzbKiQYwpzCANfTk
X-Google-Smtp-Source: ABdhPJy40rwFde9e/oBmZ0poGVPMC4USkZQNHMA84sK51xCNGxfSE4FsU4NS3ZyTYXLOJ6Gf7/qSqQ==
X-Received: by 2002:a92:d20c:: with SMTP id y12mr4824223ily.178.1606038657427;
        Sun, 22 Nov 2020 01:50:57 -0800 (PST)
Received: from presler.lan (a109-49-14-36.cpe.netcabo.pt. [109.49.14.36])
        by smtp.gmail.com with ESMTPSA id i8sm5551066ilj.1.2020.11.22.01.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 01:50:56 -0800 (PST)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH v6] zram: break the strict dependency from lzo
Date:   Sun, 22 Nov 2020 09:50:51 +0000
Message-Id: <20201122095051.4819-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From the beginning, the zram block device always enabled CRYPTO_LZO, since
lzo-rle is hardcoded as the fallback compression algorithm. As a consequence, on
systems where another compression algorithm is chosen (e.g. CRYPTO_ZSTD), the
lzo kernel module becomes unused, while still having to be built/loaded.

This patch removes the hardcoded lzo-rle dependency and allows the user to
select the default compression algorithm for zram at build time. The previous
behaviour is kept, as the default algorithm is still lzo-rle.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
v6: simplify the kconfig as per Minchan's suggestion.
v5: incorporate Minchan's feedback. Allow the user to choose a default algorithm.
v4: incorporate Sergey's feedback and fix a small typo.
v3: fix the default selection when lzo isn't present. Rebase against 5.10-rc1.
v2: fix the dependency on CRYPTO.

 drivers/block/zram/Kconfig    | 41 ++++++++++++++++++++++++++++++++++-
 drivers/block/zram/zcomp.c    |  2 ++
 drivers/block/zram/zram_drv.c |  2 +-
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fe7a4b7d30cf..6303fe5dee88 100644
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
@@ -14,6 +13,46 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
+choice
+	prompt "Default zram compressor"
+	default ZRAM_DEF_COMP_LZORLE
+	depends on ZRAM || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842
+
+config ZRAM_DEF_COMP_LZORLE
+	bool "lzo-rle"
+	select CRYPTO_LZO
+
+config ZRAM_DEF_COMP_ZSTD
+	bool "zstd"
+	depends on CRYPTO_ZSTD
+
+config ZRAM_DEF_COMP_LZ4
+	bool "lz4"
+	depends on CRYPTO_LZ4
+
+config ZRAM_DEF_COMP_LZO
+	bool "lzo"
+	select CRYPTO_LZO
+
+config ZRAM_DEF_COMP_LZ4HC
+	bool "lz4hc"
+	depends on CRYPTO_LZ4HC
+
+config ZRAM_DEF_COMP_842
+	bool "842"
+	depends on CRYPTO_842
+
+endchoice
+
+config ZRAM_DEF_COMP
+	string
+	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
+	default "zstd" if ZRAM_DEF_COMP_ZSTD
+	default "lz4" if ZRAM_DEF_COMP_LZ4
+	default "lzo" if ZRAM_DEF_COMP_LZO
+	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
+	default "842" if ZRAM_DEF_COMP_842
+
 config ZRAM_WRITEBACK
        bool "Write back incompressible or idle page to backing device"
        depends on ZRAM
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
index 1b697208d661..9ddccb968c68 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -42,7 +42,7 @@ static DEFINE_IDR(zram_index_idr);
 static DEFINE_MUTEX(zram_index_mutex);
 
 static int zram_major;
-static const char *default_compressor = "lzo-rle";
+static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
 
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
-- 
2.29.2

