Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB9C4361B
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 12:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631142339D
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 12:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgLGMNd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 07:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLGMNd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 07:13:33 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB45C0613D1;
        Mon,  7 Dec 2020 04:12:53 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id c7so3934856qke.1;
        Mon, 07 Dec 2020 04:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tGf3xmW5vy1PIB7ezJ7vNPFReodCO4iqcW8JYnZ921E=;
        b=nO1NspUATMgozvuiB3X7OOHKYGNwSs81tyEGm1u9zVnTz+X45V9Tx2XbP8fqggIYfA
         qRBXkPUWgGFgiz/CK62y7rsjcDakoQyWrl2AWpJEzJNgH3tPfiLSQ6sBBNIlH1uYaKMd
         u32Df4ruUqo0zyoEhyW+KbYoZ7lHcyBPR48+f0eouCa4uLJlOY8+wE9dHU7Htjgqfrns
         s42pmL5NmPUifYq0KK5viuL8tFs2/qr81Kek7uVhCRC4EO1yoB+PbeIh2St8C0JG96ET
         szoA/Gf6aL2HbGHCe5jkUxhb5pMbvHUe8Kstfyb8bvvJ7mwd2WZN3HN5NsEn1NmdFmHb
         FI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tGf3xmW5vy1PIB7ezJ7vNPFReodCO4iqcW8JYnZ921E=;
        b=cDWOk2bqsL+vkO8owAn8JJzEhpX9W+flmHmhmjOHmSzeKvHf+S6/NALJhL6oqZ0ER3
         J4aRfsm8yLMIwbgMqhtz9/OjRJHG6BRHlFHnkM/ynUvp/dhMamFQjs0PAINuQUN1bled
         7CtzT/qtB33YryJZGUanZ+h9+EC0zw6THzo4RZsTi8VtppX6nhNmZrm+75iYxyAImS09
         HCrj70ue0m6w0Q8JsfNkQI+W+IlzbQa3ampYmCqXit/FjqSEuVJjT5GzVN3lBQ17f2qB
         AcmgGbot8GPFjHz+slIb+o5TsmPdfE1pK8P8DlFjtbd4bCJ14O/Ko7zOm1SGwQp9KD8b
         iDkw==
X-Gm-Message-State: AOAM5310O/YQ210diMFYpGAmn0nC0P8cxOc+KqAAcWTmWnALu7U5bBMx
        Uq7x39+9fFN4DbQgR8kBNcrHQJL0Jw==
X-Google-Smtp-Source: ABdhPJwjSN6PpfQtAzWn+o33BgBneRpJVvcStp6Noq57YNUSO0jLylY42fKOiLbDr9ONsYJrOZY7ig==
X-Received: by 2002:a37:8485:: with SMTP id g127mr1443993qkd.233.1607343172297;
        Mon, 07 Dec 2020 04:12:52 -0800 (PST)
Received: from presler.lan (a95-94-74-213.cpe.netcabo.pt. [95.94.74.213])
        by smtp.gmail.com with ESMTPSA id l20sm1711530qkj.19.2020.12.07.04.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 04:12:51 -0800 (PST)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH v7] zram: break the strict dependency from lzo
Date:   Mon,  7 Dec 2020 12:12:45 +0000
Message-Id: <20201207121245.50529-1-rsalvaterra@gmail.com>
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
v7: rebase against 5.10-rc7 and fix unmet direct dependencies, as reported by
Stephen Rothwell on linux-next.
v6: simplify the kconfig as per Minchan's suggestion.
v5: incorporate Minchan's feedback. Allow the user to choose a default algorithm.
v4: incorporate Sergey's feedback and fix a small typo.
v3: fix the default selection when lzo isn't present. Rebase against 5.10-rc1.
v2: fix the dependency on CRYPTO.

I had to change CRYPTO_LZO from "select" to "depends on", since it had the
unfortunate effect of causing unmet direct dependencies on some kernel
configurations. This also means at least one supported compression algorithm
must be selected in order for the zram block device to appear on the menu,
which isn't the perfect solution I'd hoped for, but it works for me (and make
oldconfig doesn't break existing configurations).

 drivers/block/zram/Kconfig    | 42 ++++++++++++++++++++++++++++++++++-
 drivers/block/zram/zcomp.c    |  2 ++
 drivers/block/zram/zram_drv.c |  2 +-
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fe7a4b7d30cf..668c6bf2554d 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -2,7 +2,7 @@
 config ZRAM
 	tristate "Compressed RAM block device support"
 	depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
-	select CRYPTO_LZO
+	depends on CRYPTO_LZO || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
 	  Pages written to these disks are compressed and stored in memory
@@ -14,6 +14,46 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
+choice
+	prompt "Default zram compressor"
+	default ZRAM_DEF_COMP_LZORLE
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

