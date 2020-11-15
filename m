Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AEAC2D0E4
	for <linux-block@archiver.kernel.org>; Sun, 15 Nov 2020 10:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434E923A32
	for <linux-block@archiver.kernel.org>; Sun, 15 Nov 2020 10:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+TCI0+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgKOKPV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Nov 2020 05:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgKOKPU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Nov 2020 05:15:20 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE48C0613D1;
        Sun, 15 Nov 2020 02:15:20 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i18so12781962ioa.3;
        Sun, 15 Nov 2020 02:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xSVdviLWj0gsKTmJeuHr9VEM+E2hXEU8yAl0L5uEJjc=;
        b=u+TCI0+YQIzzTzIo/j61nsEM2+y4Oamb+QQN1gYNYR2EXuE5IdcnbuPb/xgNTAU2eL
         FCvNc2HYBV4dsMTXayk1+8/qdTH7gi3Q9WIJygZ7I0wbAVtqnE+Y5p4c68k4bioJwkz3
         FsH6w+7M24VYx+j64Q4VgdsIvhfsGyvtG2yz569Um7HB+5HFX1r7Uv6EokPNuyk1RDD9
         xcaM62HfrLBnRsCDezhq1EDEYtFamFyDhscKW7aIj0g62YdVJhCHhKD5T4sTbeWzyUgs
         msOtNRWRo/K/Meiedjb9ynpXZWhLQUbkzi70cHw9fzQCPyoTFVD5/lFGDkiZ0yRV54yA
         Zs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xSVdviLWj0gsKTmJeuHr9VEM+E2hXEU8yAl0L5uEJjc=;
        b=P/imvqd55I6YJiobueViHcvbmvx/P5bjaoKkfjJGKOURaH8dNNcFAuyzayLft1Ihqk
         GJa/knXtp7BJcXcJWv9QHfOaxo7ndF5gnHX26XIS8kqCTjPoIUgKDWVV7psVaHd0PKfo
         E0x58uGg4MSZXrfbCa7CJ9cY9VHGUfmxBtsrY+1ZgYCCRFVzA+JpoCEfF9WSK7GRTfkm
         onoEsm4g0tLMg9ZY3QRbnbiXGgXbBqkFhLtnUpqAR7XO3YkSeVzYEDxUFV3eRA3EPpuk
         esK8RsKPKj25nHeaiQA5PAxIAR4PUGztnaIOydc6niQH8xWNPYozrKrdXeFZim76GVRE
         hNiw==
X-Gm-Message-State: AOAM530Gm9lX/Ve+O3cyAqzteSGiPhNvyqW8Pol/Aub2zUF0r7NgLA+i
        W8RYfP/qhSzyppyo5WjboA==
X-Google-Smtp-Source: ABdhPJzBcG21vvSxJVDV5TA2Q9MWUuFC0YEg/GOj3yGRzMN8nXkYryFPgSNDv5RYyGDcFABOOcju5g==
X-Received: by 2002:a6b:e613:: with SMTP id g19mr4885517ioh.17.1605435319708;
        Sun, 15 Nov 2020 02:15:19 -0800 (PST)
Received: from presler.lan (a95-94-69-32.cpe.netcabo.pt. [95.94.69.32])
        by smtp.gmail.com with ESMTPSA id t26sm7518889ioi.11.2020.11.15.02.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 02:15:19 -0800 (PST)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH v5] zram: break the strict dependency from lzo
Date:   Sun, 15 Nov 2020 10:15:14 +0000
Message-Id: <20201115101514.954-1-rsalvaterra@gmail.com>
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
v5: incorporate Minchan's feedback. Allow the user to choose a default algorithm.
v4: incorporate Sergey's feedback and fix a small typo.
v3: fix the default selection when lzo isn't present. Rebase against 5.10-rc1.
v2: fix the dependency on CRYPTO.

I believe this is the final version, but it does deserve some comment. Given the
choice of having more preprocessor #if/#endif directives in C files or making
the kconfig a bit more complex, I went for the latter. However, since kconfig
choices can only be boolean, I had to devise a way to make a string selection
based on the boolean choice, hence the ZRAM_DEF_COMP symbol.
I also tried to make the ZRAM_AUTOSEL_ALGO definition a bit less painful to the
eye, while still allowing for the compression algorithms to be selected as
modules, as per Sergey's suggestion.

 drivers/block/zram/Kconfig    | 49 ++++++++++++++++++++++++++++++++++-
 drivers/block/zram/zcomp.c    |  2 ++
 drivers/block/zram/zram_drv.c |  2 +-
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fe7a4b7d30cf..cde089c30ffb 100644
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
@@ -14,6 +13,54 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
+choice
+	prompt "Default zram compression algorithm"
+	depends on ZRAM
+
+config ZRAM_DEF_COMP_LZORLE
+	bool "lzo-rle"
+	depends on CRYPTO_LZO
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
+	depends on CRYPTO_LZO
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
+config ZRAM_AUTOSEL_ALGO
+	def_bool y
+	depends on ZRAM && \
+		!(CRYPTO_LZ4=m   || CRYPTO_LZ4=y   || \
+		  CRYPTO_LZ4HC=m || CRYPTO_LZ4HC=y || \
+		  CRYPTO_842=m   || CRYPTO_842=y   || \
+		  CRYPTO_ZSTD=m  || CRYPTO_ZSTD=y)
+	select CRYPTO_LZO
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

