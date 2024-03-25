Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92943AF2E2
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337536; cv=none; b=X8NTVn8gfVEMOIevX/HONetiUg0GDTcFbPCjLu35U6rBzu09Ut6VwRVWh1otNZrYbtk/WbA1usaqqUF917vCo8voVyIjAZQ2AWakUUyrrehgeVkIjxepkMNnJq6ksm01iv/kMCYsVBTu3S6DfIraKtaAQIKDOn+jUukAo74okLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337536; c=relaxed/simple;
	bh=XIt5W1lDG/OYW9mBP/9gKBdaolxrEqGuDk835KRuYWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WmQD5AiTMr+29kzjey4B87ENqwl4E8E8md07DzAQoFM1B2nKNkdtKWTYmEBs530AEwoiCf2alXgOXmt0nCr3f4bQOAEeOq95JYs3baxmhBCl+QaHCmj+39+2BwsUOa4ZXMyHcT198ejOga4fxQeKjRLm2WLnSGYjl9sOk+U5gxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V2z4T5kXMz1GCwy;
	Mon, 25 Mar 2024 11:31:37 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E947140153;
	Mon, 25 Mar 2024 11:32:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 11:32:05 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Jens Axboe <axboe@kernel.dk>, Dennis Zhou <dennis@kernel.org>
CC: <linux-block@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] blk-cgroup: use group allocation/free of per-cpu counters API
Date: Mon, 25 Mar 2024 11:59:55 +0800
Message-ID: <20240325035955.50019-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
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

Use group allocation/free of per-cpu counters api to accelerate
blkg_rwstat_init/exit() and simplify code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 block/blk-cgroup-rwstat.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
index 3304e841df7c..a55fb0c53558 100644
--- a/block/blk-cgroup-rwstat.c
+++ b/block/blk-cgroup-rwstat.c
@@ -9,25 +9,19 @@ int blkg_rwstat_init(struct blkg_rwstat *rwstat, gfp_t gfp)
 {
 	int i, ret;
 
-	for (i = 0; i < BLKG_RWSTAT_NR; i++) {
-		ret = percpu_counter_init(&rwstat->cpu_cnt[i], 0, gfp);
-		if (ret) {
-			while (--i >= 0)
-				percpu_counter_destroy(&rwstat->cpu_cnt[i]);
-			return ret;
-		}
+	ret = percpu_counter_init_many(rwstat->cpu_cnt, 0, gfp, BLKG_RWSTAT_NR);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < BLKG_RWSTAT_NR; i++)
 		atomic64_set(&rwstat->aux_cnt[i], 0);
-	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(blkg_rwstat_init);
 
 void blkg_rwstat_exit(struct blkg_rwstat *rwstat)
 {
-	int i;
-
-	for (i = 0; i < BLKG_RWSTAT_NR; i++)
-		percpu_counter_destroy(&rwstat->cpu_cnt[i]);
+	percpu_counter_destroy_many(rwstat->cpu_cnt, BLKG_RWSTAT_NR);
 }
 EXPORT_SYMBOL_GPL(blkg_rwstat_exit);
 
-- 
2.41.0

