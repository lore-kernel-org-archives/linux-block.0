Return-Path: <SRS0=cVCO=ED=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71567C55179
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 23:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6DD20790
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 23:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOBCu0Kw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgJ1XIo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgJ1XHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 19:07:44 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF24C0613CF;
        Wed, 28 Oct 2020 16:07:44 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z5so1362612iob.1;
        Wed, 28 Oct 2020 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3EY2gk1/SDN2YzEyGXKM1C+DGZj50Xy872wMeO8RSQ=;
        b=rOBCu0Kw6G9sh4eQn+4UFakYd7cJAiOxKbXk969CTsxPvlBvfUiwLLMVkD9+eI/b9K
         oivm/90w/v3wcDrmD+CfkKZN5RZmez3YvldlszYIMq8/PSCmN0XbZEub0QR9ojOqMccB
         zHHDpBq9TxtmrXtqAPZToPduOb5tSdDy47ubXEY3tvtsy6ChKStO0Nvc00DmoH46xgJE
         mhveLTrf74iLkro7amr6qF8POZenzvGV4qG3Xq1OMGFClpt+n8GXbPHN87nQlCoJ1PP2
         /HIZAIKpsYd1Jj26hgdNgSf562SCITnKnp5Xk7WAp1HoBnbWI9dVIU7xtxaAASTDt6Pp
         YHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3EY2gk1/SDN2YzEyGXKM1C+DGZj50Xy872wMeO8RSQ=;
        b=BTDEEV3J683s4ZoGBBPq22hD6j23eqsOf510favTHKY+wqV1NhDUCWVekxrKvgFd1Z
         /Ig9491uRqwR3eUKakHkBqxeOwdc2+4bXAY+S4+uXyD5Dn8URoA8//spNRVCLOu18pqo
         MIRsQwyTRfybghuQ4FpLR0jYDdXJ8CeHIia/8Di/gzojczh3YfqOg5mEZ9TjiYWmWpt8
         XzT6Hdw4MZdS4Go62UJt67Vj1ObcXw3fP/eKPlon20Uc8n983ampd0mMGVCarcfkXzJ3
         SUWgG3TBrKSCmklEMmUws1HuhWQmyqZGdXfTE8ytsGIB74BMXa3bx3Noc6/2oVTtNZU9
         KlMQ==
X-Gm-Message-State: AOAM533m5CQE1YJ+P1RUk9rYWhwEa07FC6GR9b+afqDYPWPJt4h/uzHE
        W/P2kaClYOJYe2xlD8qizFDB5kFkBJzoIXc=
X-Google-Smtp-Source: ABdhPJz9mqf2yZ3wTbc/fTPaFQRcOHMg1DLzs9y+RJ2RMaAFXLGB5vqGyLmWfeyzYuTBAiCkF0Mf5g==
X-Received: by 2002:ac8:7b2c:: with SMTP id l12mr6484103qtu.309.1603886374646;
        Wed, 28 Oct 2020 04:59:34 -0700 (PDT)
Received: from presler.lan (a95-94-69-32.cpe.netcabo.pt. [95.94.69.32])
        by smtp.gmail.com with ESMTPSA id e19sm2717697qkl.94.2020.10.28.04.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 04:59:34 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH v4] zram: break the strict dependency from lzo
Date:   Wed, 28 Oct 2020 11:59:21 +0000
Message-Id: <20201028115921.848-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's nothing special about zram and lzo. It works just fine without it, so
as long as at least one of the other supported compression algorithms is
selected.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
v4: incorporate Sergey's feedback and fix a small typo.
v3: fix the default selection when lzo isn't present. Rebase against 5.10-rc1.
v2: fix the dependency on CRYPTO.

 drivers/block/zram/Kconfig    |  6 +++++-
 drivers/block/zram/zcomp.c    | 17 +++++++++++++++++
 drivers/block/zram/zcomp.h    |  1 +
 drivers/block/zram/zram_drv.c |  5 +++--
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fe7a4b7d30cf..141ce0ebad06 100644
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
@@ -14,6 +13,11 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
+config ZRAM_AUTOSEL_ALGO
+	def_bool y
+	depends on ZRAM && !(CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842 || CRYPTO_ZSTD)
+	select CRYPTO_LZO
+
 config ZRAM_WRITEBACK
        bool "Write back incompressible or idle page to backing device"
        depends on ZRAM
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 33e3b76c4fa9..4fad177c78c4 100644
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
@@ -202,6 +204,21 @@ void zcomp_destroy(struct zcomp *comp)
 	kfree(comp);
 }
 
+const char *default_compressor(void)
+{
+	/*
+	 * Pick the first available one (there should be at least one).
+	 *
+	 * In theory, we can drop all the ifdefs from backends[] and
+	 * just iterate backends array doing crypto_has_comp(comp, 0, 0)
+	 * for each entry and return the first one which is recognized by
+	 * crypto. But crypto_has_comp() modprobes compression drivers,
+	 * so we may end up with extra loaded drivers, when the 'default'
+	 * compressor is not what zram is configured to use.
+	 */
+	return backends[0];
+}
+
 /*
  * search available compressors for requested algorithm.
  * allocate new zcomp and initialize it. return compressing
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 40f6420f4b2e..f104be9eae9c 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -27,6 +27,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf);
 bool zcomp_available_algorithm(const char *comp);
 
+const char *default_compressor(void);
 struct zcomp *zcomp_create(const char *comp);
 void zcomp_destroy(struct zcomp *comp);
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1b697208d661..f02ee050c7bf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -42,7 +42,6 @@ static DEFINE_IDR(zram_index_idr);
 static DEFINE_MUTEX(zram_index_mutex);
 
 static int zram_major;
-static const char *default_compressor = "lzo-rle";
 
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
@@ -1960,7 +1959,9 @@ static int zram_add(void)
 	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
 	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
 
-	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
+	strlcpy(zram->compressor,
+		default_compressor(),
+		sizeof(zram->compressor));
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
-- 
2.29.1

