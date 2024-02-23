Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1856D2E6
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660567; cv=none; b=roJtIfJO2garm58R8DvZzaBGymqAnKOrq4TwMVKcADbr9dlZQ3N0+mPR3H+mv7p803A6LmvU8A1mal30l/GTwMofSmy5/lsePgmzW4ejYt9S5+H1AkNqNyDZgKXLiLRsCbCUMzjpQeSZkoy9thCKLsZFLbbXCLjCFGmDiwQyLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660567; c=relaxed/simple;
	bh=p440YFG9lPgSq8HFwoKWlaFAhsV5uzvTMX4KQdrHDRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m52n40J9//YQa6+KfSsmS9QF9FgYVsF2W1fkW9ZVTqkiz2PDIkf4xrBJSohLKiaQHxMn607zYcVhrA5sJd0Usx4mTHFYmkwvFzgrttqP0aZtlM4qqfNFmEdsdDANXnzOUyknUyxV1Zpn/4cohPsfJsopRtIZJBkb/jfpwlsMLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TgwzJ1DHHz1FKW7;
	Fri, 23 Feb 2024 11:51:08 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id BB1EA140155;
	Fri, 23 Feb 2024 11:56:01 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 11:56:01 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
CC: Chengming Zhou <chengming.zhou@linux.dev>, Huacai Chen
	<chenhuacai@kernel.org>, Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, <linux-mm@kvack.org>,
	<linux-block@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 3/5] zram: support deflate compressor
Date: Fri, 23 Feb 2024 11:55:46 +0800
Message-ID: <20240223035548.2591882-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240223035548.2591882-1-wangkefeng.wang@huawei.com>
References: <20240223035548.2591882-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Add deflate compressor support, also it is prepare for unifying the
default compressor compressor for zram and zswap.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/block/zram/Kconfig | 7 ++++++-
 drivers/block/zram/zcomp.c | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 0cee425da0f5..b007dda16430 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -2,7 +2,7 @@
 config ZRAM
 	tristate "Compressed RAM block device support"
 	depends on SWAP && SYSFS
-	depends on CRYPTO_LZO || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842
+	depends on CRYPTO_LZO || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842 || CRYPTO_DEFLATE
 	select ZSMALLOC
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
@@ -20,6 +20,10 @@ choice
 	default ZRAM_DEF_COMP_LZORLE
 	depends on ZRAM
 
+config ZRAM_DEF_COMP_DEFLATE
+	bool "Deflate"
+	depends on CRYPTO_DEFLATE
+
 config ZRAM_DEF_COMP_LZORLE
 	bool "lzo-rle"
 	depends on CRYPTO_LZO
@@ -48,6 +52,7 @@ endchoice
 
 config ZRAM_DEF_COMP
 	string
+	default "deflate" if ZRAM_DEF_COMP_DEFLATE
 	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
 	default "zstd" if ZRAM_DEF_COMP_ZSTD
 	default "lz4" if ZRAM_DEF_COMP_LZ4
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 8237b08c49d8..1f9a431f771e 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -16,6 +16,9 @@
 #include "zcomp.h"
 
 static const char * const backends[] = {
+#if IS_ENABLED(CONFIG_CRYPTO_DEFLATE)
+	"deflate",
+#endif
 #if IS_ENABLED(CONFIG_CRYPTO_LZO)
 	"lzo",
 	"lzo-rle",
-- 
2.27.0

