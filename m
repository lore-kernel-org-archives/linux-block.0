Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AE6C433F5
	for <linux-block@archiver.kernel.org>; Sun, 22 May 2022 20:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350907AbiEVUlL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 May 2022 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351223AbiEVUlD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 May 2022 16:41:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5274FE5
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 13:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=IhGfJBF1F6BJDdhicPBGQuKVWrA58Ble6RRUi+jw9tU=; b=GSSt9eILneY1h2v1DatjnZanXC
        qM8GU0d9ulhQDSOHfq67YY2d07VtMmGUb2Vd0mN/bC5DwkmbElE1KrDuvO2bfInoKXsG56eyNydPd
        IFkk3vSbRSFaOSras0exnizcSKqQK6XFJR7symKuoPaF3C+Agucd4az4TPZgH9Rf6nKbexkP7Y3AG
        5lF/+DMGr2GRgTJWhHU9J61kM7x1d2OTUbk5m/v1Fy9ZRd+o4Fgbm3erfG44kzCcJV6P/ofPvAbLk
        MLKPZYDZ/nBZ9hC+QMjebEQqVmLH47miRMDQciD6yedksuuDlV8xdUl8u137uSWuTgv9Sk4KjMJgv
        wFjo93Pw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nssNM-00Faoq-VF; Sun, 22 May 2022 20:40:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH -next] zram: fix Kconfig dependency warning
Date:   Sun, 22 May 2022 13:40:27 -0700
Message-Id: <20220522204027.22964-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ZSMALLOC depends on MMU so ZRAM should also depend on MMU
since 'select' does not follow any dependency chains.

Fixes this Kconfig warning:

WARNING: unmet direct dependencies detected for ZSMALLOC
  Depends on [n]: MMU [=n]
  Selected by [y]:
  - ZRAM [=y] && BLK_DEV [=y] && BLOCK [=y] && SYSFS [=y] && (CRYPTO_LZO [=y] || CRYPTO_ZSTD [=m] || CRYPTO_LZ4 [=m] || CRYPTO_LZ4HC [=n] || CRYPTO_842 [=n])

Fixes: b3fbd58fcbb10 ("mm: Kconfig: simplify zswap configuration")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/block/zram/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config ZRAM
 	tristate "Compressed RAM block device support"
-	depends on BLOCK && SYSFS
+	depends on BLOCK && SYSFS && MMU
 	depends on CRYPTO_LZO || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842
 	select ZSMALLOC
 	help
