Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B810971
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 03:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660573; cv=none; b=IxA1TmClcbjXut2UO2AFjezSwdd4UpMKH/ATblIbDTtCHV6lBrEXsUl8IYaCWJMULaR34aG14QP9PN6HIdbHxZIfDu9VqFzvLchMf4tjvnt0xRSWxg6sWqSDZ2Jqw2QMgjI07W/vK2QRyvtmcVAar2MDL4ZZmVSrSOh8j0dzac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660573; c=relaxed/simple;
	bh=d0PtJwRdu2CDYq+yoHIktTBuHu+ZlpxG4H9Yvv+yTDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKJZRH9h6jCcGfA6vi3kTBA10FjWZWlic6vriBJJbQkx0XFaiZmM+RYn6RuukW8WVrjv/pIlXA5l3F5ZGeG05NddMeQ+O3vj8D0ulGPJww6niDukk4UilFbCeobC3+nhX5ohyMeN6yJNm8uwnCu25+tsvvOra6yGd1JDxsXgA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Tgx2j6Kc6zXh7x;
	Fri, 23 Feb 2024 11:54:05 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id E2B2B1400CA;
	Fri, 23 Feb 2024 11:56:02 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 11:56:02 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
CC: Chengming Zhou <chengming.zhou@linux.dev>, Huacai Chen
	<chenhuacai@kernel.org>, Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, <linux-mm@kvack.org>,
	<linux-block@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 5/5] mm: unify default compressor algorithm for zswap and zram
Date: Fri, 23 Feb 2024 11:55:48 +0800
Message-ID: <20240223035548.2591882-6-wangkefeng.wang@huawei.com>
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

Both zswap and zram could change compressor algorithm dynamically, it
can be overridden at boot time by 'zswap.compressor=' for zswap, also
there is a sysfs interface to change it, see
  /sys/block/zramX/comp_algorithm
  /sys/module/zswap/parameters/compressor

So there is no need to maintain independence default compressor algorithm, 
unify the Kconfig to use lzo-rle as the default page compressor algorithm.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 Documentation/admin-guide/mm/zswap.rst     |   2 +-
 arch/loongarch/configs/loongson3_defconfig |   2 +-
 drivers/block/zram/Kconfig                 |  47 +-------
 drivers/block/zram/zram_drv.c              |   2 +-
 mm/Kconfig                                 | 131 +++++++++++----------
 mm/zswap.c                                 |   8 +-
 6 files changed, 74 insertions(+), 118 deletions(-)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index b42132969e31..375366b9a642 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -90,7 +90,7 @@ controlled policy:
 * max_pool_percent - The maximum percentage of memory that the compressed
   pool can occupy.
 
-The default compressor is selected in ``CONFIG_ZSWAP_COMPRESSOR_DEFAULT``
+The default compressor is selected in ``CONFIG_COMPRESSOR_DEFAULT``
 Kconfig option, but it can be overridden at boot time by setting the
 ``compressor`` attribute, e.g. ``zswap.compressor=lzo``.
 It can also be changed at runtime using the sysfs "compressor"
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index f18c2ba871ef..dc718089a530 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -91,7 +91,7 @@ CONFIG_BFQ_GROUP_IOSCHED=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZPOOL=y
 CONFIG_ZSWAP=y
-CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=y
+CONFIG_COMPRESSOR_DEFAULT_ZSTD=y
 CONFIG_ZBUD=y
 CONFIG_Z3FOLD=y
 CONFIG_ZSMALLOC=m
diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index b007dda16430..26558159824e 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -2,7 +2,7 @@
 config ZRAM
 	tristate "Compressed RAM block device support"
 	depends on SWAP && SYSFS
-	depends on CRYPTO_LZO || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842 || CRYPTO_DEFLATE
+	select CRYPTO
 	select ZSMALLOC
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
@@ -15,51 +15,6 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
-choice
-	prompt "Default zram compressor"
-	default ZRAM_DEF_COMP_LZORLE
-	depends on ZRAM
-
-config ZRAM_DEF_COMP_DEFLATE
-	bool "Deflate"
-	depends on CRYPTO_DEFLATE
-
-config ZRAM_DEF_COMP_LZORLE
-	bool "lzo-rle"
-	depends on CRYPTO_LZO
-
-config ZRAM_DEF_COMP_ZSTD
-	bool "zstd"
-	depends on CRYPTO_ZSTD
-
-config ZRAM_DEF_COMP_LZ4
-	bool "lz4"
-	depends on CRYPTO_LZ4
-
-config ZRAM_DEF_COMP_LZO
-	bool "lzo"
-	depends on CRYPTO_LZO
-
-config ZRAM_DEF_COMP_LZ4HC
-	bool "lz4hc"
-	depends on CRYPTO_LZ4HC
-
-config ZRAM_DEF_COMP_842
-	bool "842"
-	depends on CRYPTO_842
-
-endchoice
-
-config ZRAM_DEF_COMP
-	string
-	default "deflate" if ZRAM_DEF_COMP_DEFLATE
-	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
-	default "zstd" if ZRAM_DEF_COMP_ZSTD
-	default "lz4" if ZRAM_DEF_COMP_LZ4
-	default "lzo" if ZRAM_DEF_COMP_LZO
-	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
-	default "842" if ZRAM_DEF_COMP_842
-
 config ZRAM_WRITEBACK
        bool "Write back incompressible or idle page to backing device"
        depends on ZRAM
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f0639df6cd18..664c4012ced4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -41,7 +41,7 @@ static DEFINE_IDR(zram_index_idr);
 static DEFINE_MUTEX(zram_index_mutex);
 
 static int zram_major;
-static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
+static const char *default_compressor = CONFIG_COMPRESSOR_DEFAULT;
 
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
diff --git a/mm/Kconfig b/mm/Kconfig
index f41a28b74efd..9da2671e0b20 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -9,9 +9,6 @@ menu "Memory Management options"
 config ARCH_NO_SWAP
 	bool
 
-config ZPOOL
-	bool
-
 menuconfig SWAP
 	bool "Support for paging of anonymous memory (swap)"
 	depends on MMU && BLOCK && !ARCH_NO_SWAP
@@ -22,116 +19,118 @@ menuconfig SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
-config ZSWAP
-	bool "Compressed cache for swap pages"
-	depends on SWAP
-	select CRYPTO
-	select ZPOOL
-	help
-	  A lightweight compressed cache for swap pages.  It takes
-	  pages that are in the process of being swapped out and attempts to
-	  compress them into a dynamically allocated RAM-based memory pool.
-	  This can result in a significant I/O reduction on swap device and,
-	  in the case where decompressing from RAM is faster than swap device
-	  reads, can also improve workload performance.
-
-config ZSWAP_DEFAULT_ON
-	bool "Enable the compressed cache for swap pages by default"
-	depends on ZSWAP
-	help
-	  If selected, the compressed cache for swap pages will be enabled
-	  at boot, otherwise it will be disabled.
-
-	  The selection made here can be overridden by using the kernel
-	  command line 'zswap.enabled=' option.
-
-config ZSWAP_SHRINKER_DEFAULT_ON
-	bool "Shrink the zswap pool on memory pressure"
-	depends on ZSWAP
-	default n
-	help
-	  If selected, the zswap shrinker will be enabled, and the pages
-	  stored in the zswap pool will become available for reclaim (i.e
-	  written back to the backing swap device) on memory pressure.
-
-	  This means that zswap writeback could happen even if the pool is
-	  not yet full, or the cgroup zswap limit has not been reached,
-	  reducing the chance that cold pages will reside in the zswap pool
-	  and consume memory indefinitely.
+if SWAP
 
 choice
-	prompt "Default compressor"
-	depends on ZSWAP
-	default ZSWAP_COMPRESSOR_DEFAULT_LZORLE
+	prompt "Default page compressor algorithm"
+	depends on ZSWAP || ZRAM
+	default COMPRESSOR_DEFAULT_LZORLE
 	help
-	  Selects the default compression algorithm for the compressed cache
-	  for swap pages.
+	  Selects the default compression algorithm for compressing pages.
 
 	  For an overview what kind of performance can be expected from
 	  a particular compression algorithm please refer to the benchmarks
 	  available at the following LWN page:
 	  https://lwn.net/Articles/751795/
 
-	  If in doubt, select 'LZO-RLE'.
+	  If in doubt, select 'LZO-rle'.
 
-	  The selection made here can be overridden by using the kernel
-	  command line 'zswap.compressor=' option.
-
-config ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
+config COMPRESSOR_DEFAULT_DEFLATE
 	bool "Deflate"
 	select CRYPTO_DEFLATE
 	help
 	  Use the Deflate algorithm as the default compression algorithm.
 
-config ZSWAP_COMPRESSOR_DEFAULT_LZORLE
+config COMPRESSOR_DEFAULT_LZORLE
 	bool "LZO-RLE"
 	select CRYPTO_LZO
 	help
 	  Use the LZO algorithm as the default compression algorithm.
 
-config ZSWAP_COMPRESSOR_DEFAULT_LZO
+config COMPRESSOR_DEFAULT_LZO
 	bool "LZO"
 	select CRYPTO_LZO
 	help
 	  Use the LZO algorithm as the default compression algorithm.
 
-config ZSWAP_COMPRESSOR_DEFAULT_842
+config COMPRESSOR_DEFAULT_842
 	bool "842"
 	select CRYPTO_842
 	help
 	  Use the 842 algorithm as the default compression algorithm.
 
-config ZSWAP_COMPRESSOR_DEFAULT_LZ4
+config COMPRESSOR_DEFAULT_LZ4
 	bool "LZ4"
 	select CRYPTO_LZ4
 	help
 	  Use the LZ4 algorithm as the default compression algorithm.
 
-config ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
+config COMPRESSOR_DEFAULT_LZ4HC
 	bool "LZ4HC"
 	select CRYPTO_LZ4HC
 	help
 	  Use the LZ4HC algorithm as the default compression algorithm.
 
-config ZSWAP_COMPRESSOR_DEFAULT_ZSTD
-	bool "zstd"
+config COMPRESSOR_DEFAULT_ZSTD
+	bool "ZSTD"
 	select CRYPTO_ZSTD
 	help
 	  Use the zstd algorithm as the default compression algorithm.
+
 endchoice
 
-config ZSWAP_COMPRESSOR_DEFAULT
+config COMPRESSOR_DEFAULT
        string
-       depends on ZSWAP
-       default "deflate" if ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
-       default "lzo-rle" if ZSWAP_COMPRESSOR_DEFAULT_LZORLE
-       default "lzo" if ZSWAP_COMPRESSOR_DEFAULT_LZO
-       default "842" if ZSWAP_COMPRESSOR_DEFAULT_842
-       default "lz4" if ZSWAP_COMPRESSOR_DEFAULT_LZ4
-       default "lz4hc" if ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
-       default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
+       depends on ZSWAP || ZRAM
+       default "deflate" if COMPRESSOR_DEFAULT_DEFLATE
+       default "lzo-rle" if COMPRESSOR_DEFAULT_LZORLE
+       default "lzo" if COMPRESSOR_DEFAULT_LZO
+       default "842" if COMPRESSOR_DEFAULT_842
+       default "lz4" if COMPRESSOR_DEFAULT_LZ4
+       default "lz4hc" if COMPRESSOR_DEFAULT_LZ4HC
+       default "zstd" if COMPRESSOR_DEFAULT_ZSTD
        default ""
 
+config ZPOOL
+	bool
+
+config ZSWAP
+	bool "Compressed cache for swap pages"
+	depends on SWAP
+	select CRYPTO
+	select ZPOOL
+	help
+	  A lightweight compressed cache for swap pages.  It takes
+	  pages that are in the process of being swapped out and attempts to
+	  compress them into a dynamically allocated RAM-based memory pool.
+	  This can result in a significant I/O reduction on swap device and,
+	  in the case where decompressing from RAM is faster than swap device
+	  reads, can also improve workload performance.
+
+config ZSWAP_DEFAULT_ON
+	bool "Enable the compressed cache for swap pages by default"
+	depends on ZSWAP
+	help
+	  If selected, the compressed cache for swap pages will be enabled
+	  at boot, otherwise it will be disabled.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.enabled=' option.
+
+config ZSWAP_SHRINKER_DEFAULT_ON
+	bool "Shrink the zswap pool on memory pressure"
+	depends on ZSWAP
+	default n
+	help
+	  If selected, the zswap shrinker will be enabled, and the pages
+	  stored in the zswap pool will become available for reclaim (i.e
+	  written back to the backing swap device) on memory pressure.
+
+	  This means that zswap writeback could happen even if the pool is
+	  not yet full, or the cgroup zswap limit has not been reached,
+	  reducing the chance that cold pages will reside in the zswap pool
+	  and consume memory indefinitely.
+
 choice
 	prompt "Default allocator"
 	depends on ZSWAP
@@ -231,6 +230,8 @@ config ZSMALLOC_CHAIN_SIZE
 
 	  For more information, see zsmalloc documentation.
 
+endif #SWAP
+
 menu "Slab allocator options"
 
 config SLUB
diff --git a/mm/zswap.c b/mm/zswap.c
index 011e068eb355..907ae7797d98 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -96,7 +96,7 @@ static const struct kernel_param_ops zswap_enabled_param_ops = {
 module_param_cb(enabled, &zswap_enabled_param_ops, &zswap_enabled, 0644);
 
 /* Crypto compressor to use */
-static char *zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
+static char *zswap_compressor = CONFIG_COMPRESSOR_DEFAULT;
 static int zswap_compressor_param_set(const char *,
 				      const struct kernel_param *);
 static const struct kernel_param_ops zswap_compressor_param_ops = {
@@ -386,11 +386,11 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
 
 	has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
 	if (!has_comp && strcmp(zswap_compressor,
-				CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
+				CONFIG_COMPRESSOR_DEFAULT)) {
 		pr_err("compressor %s not available, using default %s\n",
-		       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
+		       zswap_compressor, CONFIG_COMPRESSOR_DEFAULT);
 		param_free_charp(&zswap_compressor);
-		zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
+		zswap_compressor = CONFIG_COMPRESSOR_DEFAULT;
 		has_comp = crypto_has_acomp(zswap_compressor, 0, 0);
 	}
 	if (!has_comp) {
-- 
2.27.0

