Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1896DDB1
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660568; cv=none; b=SKPQoclzLdWiJ3mVNDX9FejxC6/bfIDTYuaqtngyJ9DCwnlzhbEV9aoWXE5st5b3H9enCH5tVs4YFZ+Y2R0DjBP8O/dBb7uW/XnbbChB7gSYZAOjfKfeVa03+heGQXkPI3wiz1U2vLSbu9HRyQEUMW0lWkGrgIw4sToTGRL8KaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660568; c=relaxed/simple;
	bh=KiOu5h3IDER5dAH5Zs/e4rFZ9RBxGacT4w9BAMy7iTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBDqGXESXa+9PpgcV11D3qWB511ODApy0CuFZ0qs5hgPzxzTG2vxx6tgt3SJN/dFcq9Mr1V96vjN1oDRCY2jB2Ud4fwbo4UaKn9ZT7cBJk6GEqiopLh4FlKXu3qpxKTJgO8x6dLhwbvT/K+RpnDwpQ/xBzYzdBNYUpaJLQPVEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tgx2S18Rwz1gyhf;
	Fri, 23 Feb 2024 11:53:52 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AC04140155;
	Fri, 23 Feb 2024 11:56:02 +0800 (CST)
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
Subject: [PATCH 4/5] mm: zswap: default to lzo-rle instead of lzo
Date: Fri, 23 Feb 2024 11:55:47 +0800
Message-ID: <20240223035548.2591882-5-wangkefeng.wang@huawei.com>
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

Since lzo-rle performance is better than lzo, see commit ce82f19fd580
("zram: default to lzo-rle instead of lzo"), converting zswap to use
lze-rle too.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/Kconfig | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index b1448aa81e15..f41a28b74efd 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -62,7 +62,7 @@ config ZSWAP_SHRINKER_DEFAULT_ON
 choice
 	prompt "Default compressor"
 	depends on ZSWAP
-	default ZSWAP_COMPRESSOR_DEFAULT_LZO
+	default ZSWAP_COMPRESSOR_DEFAULT_LZORLE
 	help
 	  Selects the default compression algorithm for the compressed cache
 	  for swap pages.
@@ -72,7 +72,7 @@ choice
 	  available at the following LWN page:
 	  https://lwn.net/Articles/751795/
 
-	  If in doubt, select 'LZO'.
+	  If in doubt, select 'LZO-RLE'.
 
 	  The selection made here can be overridden by using the kernel
 	  command line 'zswap.compressor=' option.
@@ -83,6 +83,12 @@ config ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
 	help
 	  Use the Deflate algorithm as the default compression algorithm.
 
+config ZSWAP_COMPRESSOR_DEFAULT_LZORLE
+	bool "LZO-RLE"
+	select CRYPTO_LZO
+	help
+	  Use the LZO algorithm as the default compression algorithm.
+
 config ZSWAP_COMPRESSOR_DEFAULT_LZO
 	bool "LZO"
 	select CRYPTO_LZO
@@ -118,6 +124,7 @@ config ZSWAP_COMPRESSOR_DEFAULT
        string
        depends on ZSWAP
        default "deflate" if ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
+       default "lzo-rle" if ZSWAP_COMPRESSOR_DEFAULT_LZORLE
        default "lzo" if ZSWAP_COMPRESSOR_DEFAULT_LZO
        default "842" if ZSWAP_COMPRESSOR_DEFAULT_842
        default "lz4" if ZSWAP_COMPRESSOR_DEFAULT_LZ4
-- 
2.27.0

