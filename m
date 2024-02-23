Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D2610971
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660570; cv=none; b=sdxYGXLYt+fW9p0RwBADpAqAf3YZb95Xlp3frpUZoyQh6eQLE60QmGbtCvQkHmU3hj8q4PoQDkjZAnClMug7k8v1ULvNWfuICK4hIDOrIht7vc6CCc8jWy4a3niH/SO27TTa1hKet1Z4SpSvtJqRr5tm3ZiQQ5OuMf5frSJ2TMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660570; c=relaxed/simple;
	bh=d/R/4aR4gC50xsS9lw/06sGRWh/mHdlq/aSZyPL2FnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDB6gxXmf+bRxXlEDLD+KoNFiTZKR4EjtfuE0vJoZjPcyqLhzTgs0aHBbcWbPqpdqc8UDz5NSu+riGi72oXC9+qnO52UhxeJSsrjwjV8qkU8ySASeh3vTXsLyEO9IlURp+kSY07Hdw/cXqXdmPYXVT6LPFoKIqmt7VvTYADP7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tgx3J0qT7z1xpBD;
	Fri, 23 Feb 2024 11:54:36 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 92D6C140136;
	Fri, 23 Feb 2024 11:56:00 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 11:55:59 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
CC: Chengming Zhou <chengming.zhou@linux.dev>, Huacai Chen
	<chenhuacai@kernel.org>, Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, <linux-mm@kvack.org>,
	<linux-block@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/5] zram: zcomp: remove zcomp_set_max_streams() declaration
Date: Fri, 23 Feb 2024 11:55:44 +0800
Message-ID: <20240223035548.2591882-2-wangkefeng.wang@huawei.com>
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

The zcomp_set_max_streams() is removed from commit 43209ea2d17a
("zram: remove max_comp_streams internals"), remove the declaration.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/block/zram/zcomp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index cdefdef93da8..e9fe63da0e9b 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -39,5 +39,4 @@ int zcomp_compress(struct zcomp_strm *zstrm,
 int zcomp_decompress(struct zcomp_strm *zstrm,
 		const void *src, unsigned int src_len, void *dst);
 
-bool zcomp_set_max_streams(struct zcomp *comp, int num_strm);
 #endif /* _ZCOMP_H_ */
-- 
2.27.0

