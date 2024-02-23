Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD3B67F
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660566; cv=none; b=lN/doA7+YJl+QWxe7T0BHYr4/JNs1k3DTz/2KgzoO1oATKZ5cupUCdwUbfQn0ylPyDXIPMqZImTo3Yqim7qep9vdmt7v1gc9aHwUzN/5ozFGgYCayrT78bkfuRX4PWuwaVOVHpbbN2U5JKFr7pAaJvdo7kaNH+KHlnr/vbR0JvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660566; c=relaxed/simple;
	bh=brGBZ9P1VPb4XpFtJMfvT/hhEfEYKxqN4etRyOQiKfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9+9wF/TVB5hvcDv9qVPh9mPZDtFY0qnWTJfJosxAzVkBCGzlDhROJrQoVX0gARfXsOX+xQAZg1cvlbBfM11F/ZzhfRifm/WqHdHsPAFd1MI2vBgvEYOzp/6mNKpDBFmneySu9OfK8E2350dRiOALs+w9tu3wqbQrNhDPcGc5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Tgx4G1kvhz1vtxj;
	Fri, 23 Feb 2024 11:55:26 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A7911A016C;
	Fri, 23 Feb 2024 11:56:01 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 11:56:00 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
CC: Chengming Zhou <chengming.zhou@linux.dev>, Huacai Chen
	<chenhuacai@kernel.org>, Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, <linux-mm@kvack.org>,
	<linux-block@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/5] zram: make zram depends on SWAP
Date: Fri, 23 Feb 2024 11:55:45 +0800
Message-ID: <20240223035548.2591882-3-wangkefeng.wang@huawei.com>
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

The zram is useless when SWAP is disabled, make zram depends on SWAP.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/block/zram/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 7b29cce60ab2..0cee425da0f5 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config ZRAM
 	tristate "Compressed RAM block device support"
-	depends on BLOCK && SYSFS && MMU
+	depends on SWAP && SYSFS
 	depends on CRYPTO_LZO || CRYPTO_ZSTD || CRYPTO_LZ4 || CRYPTO_LZ4HC || CRYPTO_842
 	select ZSMALLOC
 	help
-- 
2.27.0

