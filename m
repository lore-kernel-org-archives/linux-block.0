Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80953D2FB
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744855235; cv=none; b=bZ9+mpn7TkDDw7K8iMgSWlka4n6GI0uDPNfYchRAN4BaMhvGg2Q3qA9Af40FXIsC4sw49QCaTAY4LoEqFNOoLjEPVarLAFlrBo7kAEyxznGpixMifE2XkyLfC5SeKpjr7uCO0/lLpIG4e4t6xyw9JFakLl+hm27yHjeJLpqq+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744855235; c=relaxed/simple;
	bh=7fQUoX0FPCcKNWlQ4BiupIBThKS2yKB8zYvdF89Q+u0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plKAld97wiArSweCO0AZS3Fjt1fk/CUvvqaM/NNVaOr/Vmn/1ngD972hxdSl4kcVNOL5kJBaWnKqDFqVq78hxnuF9cYBqYRZmGH4RTp3zZ7b1FgMk+ur6j2UhhEUaDLYxFK+Oj/JIyv+6SFCicmvkphJDDpEYllP83vZF2G8HXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZdLf03MP9z1R7Ys;
	Thu, 17 Apr 2025 09:58:32 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EE431A016C;
	Thu, 17 Apr 2025 10:00:29 +0800 (CST)
Received: from localhost.localdomain (10.175.112.188) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 10:00:28 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <yukuai3@huawei.com>, <wozizhi@huawei.com>,
	<ming.lei@redhat.com>, <tj@kernel.org>
Subject: [PATCH 1/3] blk-throttle: Fix wrong tg->[bytes/io]_disp update in __tg_update_carryover()
Date: Thu, 17 Apr 2025 09:50:31 +0800
Message-ID: <20250417015033.512940-2-wozizhi@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250417015033.512940-1-wozizhi@huawei.com>
References: <20250417015033.512940-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)

In commit 6cc477c36875 ("blk-throttle: carry over directly"), the carryover
bytes/ios was be carried to [bytes/io]_disp. However, its update mechanism
has some issues.

In __tg_update_carryover(), we calculate "bytes" and "ios" to represent the
carryover, but the computation when updating [bytes/io]_disp is incorrect.
This patch fixes the issue.

And if the bps/iops limit was previously set to max and later changed to a
smaller value, we may not update tg->[bytes/io]_disp to 0 in
tg_update_carryover(). Relying solely on throtl_trim_slice() is not
sufficient, which can lead to subsequent bio dispatches not behaving as
expected. We should set tg->[bytes/io]_disp to 0 in non_carryover case.
The same handling applies when nr_queued is 0.

Fixes: 6cc477c36875 ("blk-throttle: carry over directly")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/blk-throttle.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 91dab43c65ab..df9825eb83be 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -644,20 +644,39 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
 	u64 bps_limit = tg_bps_limit(tg, rw);
 	u32 iops_limit = tg_iops_limit(tg, rw);
 
+	/*
+	 * If the queue is empty, carryover handling is not needed. In such cases,
+	 * tg->[bytes/io]_disp should be reset to 0 to avoid impacting the dispatch
+	 * of subsequent bios. The same handling applies when the previous BPS/IOPS
+	 * limit was set to max.
+	 */
+	if (tg->service_queue.nr_queued[rw] == 0) {
+		tg->bytes_disp[rw] = 0;
+		tg->io_disp[rw] = 0;
+		return;
+	}
+
 	/*
 	 * If config is updated while bios are still throttled, calculate and
 	 * accumulate how many bytes/ios are waited across changes. And
 	 * carryover_bytes/ios will be used to calculate new wait time under new
 	 * configuration.
 	 */
-	if (bps_limit != U64_MAX)
+	if (bps_limit != U64_MAX) {
 		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
 			tg->bytes_disp[rw];
-	if (iops_limit != UINT_MAX)
+		tg->bytes_disp[rw] = -*bytes;
+	} else {
+		tg->bytes_disp[rw] = 0;
+	}
+
+	if (iops_limit != UINT_MAX) {
 		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
 			tg->io_disp[rw];
-	tg->bytes_disp[rw] -= *bytes;
-	tg->io_disp[rw] -= *ios;
+		tg->io_disp[rw] = -*ios;
+	} else {
+		tg->io_disp[rw] = 0;
+	}
 }
 
 static void tg_update_carryover(struct throtl_grp *tg)
@@ -665,10 +684,8 @@ static void tg_update_carryover(struct throtl_grp *tg)
 	long long bytes[2] = {0};
 	int ios[2] = {0};
 
-	if (tg->service_queue.nr_queued[READ])
-		__tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
-	if (tg->service_queue.nr_queued[WRITE])
-		__tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
+	__tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
+	__tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
 
 	/* see comments in struct throtl_grp for meaning of these fields. */
 	throtl_log(&tg->service_queue, "%s: %lld %lld %d %d\n", __func__,
-- 
2.46.1

