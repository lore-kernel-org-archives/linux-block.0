Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F09C5517A
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 21:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8366F24640
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 21:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wled5Cal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372330AbgJVVa1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Oct 2020 17:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503244AbgJVVa1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Oct 2020 17:30:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668DBC0613CE;
        Thu, 22 Oct 2020 14:30:27 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s14so3361543qkg.11;
        Thu, 22 Oct 2020 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5XbP/ePea5ve+lr+ok+lLgPRSmAtHjLF6TiuE4ZXnI=;
        b=Wled5Cal4HsYw7LWBdQFDll07iJHzAtPx1m3aL9UXv4HtEHlxP6ZrKKwBQTKeGzsep
         mv1eORtd5J6Nj6c6jQYTAYLejkIbwieTzLWOVoMESZg4SMxJUED28sbMFPNNGRA6jsAN
         Xz95rPgKG/m45hAHxzAjlLxpdok/Df5BO607x84RnlnBqRLLRipWbfkVqcUSHVDyBTp7
         hPpjx3XcXcxgYbdOBotuxnJ55ho5XX3eudMzZ38xfCVZupQnB7UeIHLriy7dyttdlZde
         I+FwJsobjIJSu+kNZsLviSZ+tRU+COJ5PY/VyPl/YgUSiOkXSvAjsB8UriC23PE7hEiP
         d0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5XbP/ePea5ve+lr+ok+lLgPRSmAtHjLF6TiuE4ZXnI=;
        b=odexYW607g4MDhX+MwfZrGZ8qs9CofxIyjn1xp60szM4FFvNE2zlahKWqSMTEfzdk0
         yBQ8InMWiQ4QfxrqbMimlJI19vYgrPxtJcaZE61KcNBM0SSKNHPTsrzEQrgqiqDpJokJ
         ekNPLQYEc9uTOxqMbVrbSaEZtj3behdu3jhGF9MvhftQthS58lzB/P3MshPxNX6Ev8aE
         kwH5bxca5USHegOJ/NDPXQ9oOFN5N58SpasTV5Lc+8vwlj9LmjCD52HaFKN89O4lFqF0
         7XjM0blbb0xfE5CdVM3oFXXS2YLBQ74edMuyK/mEowAsVRJWKFR93TBL4d7qdwjveALJ
         Gd4A==
X-Gm-Message-State: AOAM531wyK+uXFV2rHkfhqwpXALgTJCCxKXvuDPwei34zntx4psqL1v8
        xP74TvhrNSZeSYEL+yl5JQ==
X-Google-Smtp-Source: ABdhPJyel37j5CHsE74o2AH4Co54SrpAI5F3ngt/zegiKHRXBwu/yKJgFv7H3F/Ek7manj1DYAvCew==
X-Received: by 2002:a37:2c03:: with SMTP id s3mr4566501qkh.91.1603402226311;
        Thu, 22 Oct 2020 14:30:26 -0700 (PDT)
Received: from presler.lan (a95-94-69-32.cpe.netcabo.pt. [95.94.69.32])
        by smtp.gmail.com with ESMTPSA id v6sm1991237qtb.76.2020.10.22.14.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 14:30:25 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH v2] zram: break the strict dependency from lzo
Date:   Thu, 22 Oct 2020 22:30:17 +0100
Message-Id: <20201022213017.8066-1-rsalvaterra@gmail.com>
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
v2: fix the dependency on CRYPTO.

 drivers/block/zram/Kconfig | 6 +++++-
 drivers/block/zram/zcomp.c | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
-- 
2.28.0

