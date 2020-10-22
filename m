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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B9CC388F9
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14852463D
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 16:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czEwsvzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895933AbgJVQL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Oct 2020 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895930AbgJVQL4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Oct 2020 12:11:56 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB39BC0613CE;
        Thu, 22 Oct 2020 09:11:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 188so1992129qkk.12;
        Thu, 22 Oct 2020 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VUEOW9CHp/deOH81JRtiOJPAOKkJUb1n+cEO+W0skrI=;
        b=czEwsvzDLL9JQQ6KoahV8nHWd/xlhJZxwM9sfK+JVoR52s79ywU+GifieRjOrbO6us
         rLzd9+DgGUIU9llOXX0ErTqoKhJ7Wkm7Zh63MloPRtyDn0lPgMcf2OsiRZ9cwE1mQ+B1
         mW0AmVI8jlxTuXwbjiQrrtBGNLpFbepp8w5k9nOahFPTjl5WpUmoEoz+XrJZCKAzm0AX
         MH20/10P9ptj6aS/4tbXjn7NV1KFF8jnJO5C1rlpkaa/BXyRwuZgFnof746WQoj87GSl
         LmnuPwpdDCHoCEHRe1s5Bu8BH+gyNZYTE6fVTc4E8c6kyCkLN5+p9MDevjhpXzDuDt+Q
         vKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VUEOW9CHp/deOH81JRtiOJPAOKkJUb1n+cEO+W0skrI=;
        b=qRxIkXZFo4JrVENEGKcQuwmbCMTOTrSAj/UoyB3eoAvYf/4wm+CIcIvVfkErMDU32e
         h4tDamQYifMNOtpDHZ7pVg2KJ3iE8uxC2uX/ypU1IqHDqRn2JB9pWRpcJ/YLcVT2NSFt
         SauogkDLpQFK8XD86HMKOdicFTQE+6EiAbOvL3S9xBZZ5pB4ROWqBzT/DlinXgYOeG/+
         6fmpPrt3LOZVPviErtnFZt2R3E9R70JLp543bb9D9JD+eeUHdIL6eQPhP/BkFqgKtW3w
         885owZPpfJNV2JerfoKtf/hi7cUu0mNU5FYsNKWB3WOzLeHlkymVqwufhtBH8HCDQYWp
         ZkGw==
X-Gm-Message-State: AOAM533xjEwDdVEFKXMOGjY8yPi+MegEkDRvJiTGXfx3StCb7Igi6+rY
        U/eCtZfEF/Y8PHJN3/qtyg==
X-Google-Smtp-Source: ABdhPJwgIrpu/BfYe75NhyjTLrrEM95HxEVBcWn9d1YWIRoeshtLB4TIH2jYH5PbbgiOfjKTInbrFQ==
X-Received: by 2002:a37:6688:: with SMTP id a130mr1549507qkc.219.1603383114941;
        Thu, 22 Oct 2020 09:11:54 -0700 (PDT)
Received: from presler.lan (a95-94-69-32.cpe.netcabo.pt. [95.94.69.32])
        by smtp.gmail.com with ESMTPSA id g24sm1228192qka.111.2020.10.22.09.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 09:11:54 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH] zram: break the strict dependency from lzo
Date:   Thu, 22 Oct 2020 17:11:34 +0100
Message-Id: <20201022161134.2115-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's nothing special about zram and lzo. It works just fine without it, so
as long as at least one of the other supported compression algorithms is
selected.

Additionally, drop the explicit dependency from CRYPTO, as it's implied by the
selection of the algorithms themselves.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 drivers/block/zram/Kconfig | 8 ++++++--
 drivers/block/zram/zcomp.c | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fe7a4b7d30cf..2641b86f8677 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config ZRAM
 	tristate "Compressed RAM block device support"
-	depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
-	select CRYPTO_LZO
+	depends on BLOCK && SYSFS && ZSMALLOC
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

