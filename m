Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635ED1A7249
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744855241; cv=none; b=cNEe8Mx4sAMy8qRWUzGT8HA1G7gx/STd4A8UMa0nGpuYpf5ZbDSPGS2SdRHXxYU8rQSR8l7doCL0oC/UXC4YNwOw3RSy0aUHneuO7MeI9UKEePe8Aa/iUjWW60l8xSEG4whUuaWUB5Rz+ohCYl0QIQkTSOUDLQqMg4DiZB7Sml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744855241; c=relaxed/simple;
	bh=oJGBHPCgCNkklOm/mDKcszhr4shQXbohWBAJk24rHHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmKRW3+ybi4rlp70/TmnqBCa4jBjerrHYoVzzCgPZk3rzUMpy/OZCpy+wCr8b4Pkx2IfJM7TMq/a2UxUyjQvrATlvxtrqjGxg+ZcthVClOhOapfzdyap6VCBCjGTKgl66PtPrCwp/u0xKmki/SgAHQGssY6ZUT1wlydElPzgblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZdLh61wCKz2TSB9;
	Thu, 17 Apr 2025 10:00:22 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id AEB231401F1;
	Thu, 17 Apr 2025 10:00:30 +0800 (CST)
Received: from localhost.localdomain (10.175.112.188) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Apr 2025 10:00:29 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <yukuai3@huawei.com>, <wozizhi@huawei.com>,
	<ming.lei@redhat.com>, <tj@kernel.org>
Subject: [PATCH 3/3] blk-throttle: Add an additional overflow check to the call calculate_bytes/io_allowed
Date: Thu, 17 Apr 2025 09:50:33 +0800
Message-ID: <20250417015033.512940-4-wozizhi@huawei.com>
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

Now the tg->[bytes/io]_disp type is signed, and calculate_bytes/io_allowed
return type is unsigned. Even if the bps/iops limit is not set to max, the
return value of the function may still exceed INT_MAX or LLONG_MAX, which
can cause overflow in outer variables. In such cases, we can add additional
checks accordingly.

And in throtl_trim_slice(), if the BPS/IOPS limit is set to max, there's
no need to call calculate_bytes/io_allowed(). Introduces the helper
functions throtl_trim_bps/iops to simplifies the process. For cases when
the calculated trim value exceeds INT_MAX (causing an overflow), we reset
tg->[bytes/io]_disp to zero, so return original tg->[bytes/io]_disp because
it is the size that is actually trimmed.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/blk-throttle.c | 94 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 21 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 4e4609dce85d..cfb9c47d1af7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -571,6 +571,56 @@ static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
 }
 
+static long long throtl_trim_bps(struct throtl_grp *tg, bool rw,
+				 unsigned long time_elapsed)
+{
+	u64 bps_limit = tg_bps_limit(tg, rw);
+	long long bytes_trim;
+
+	if (bps_limit == U64_MAX)
+		return 0;
+
+	/* Need to consider the case of bytes_allowed overflow. */
+	bytes_trim = calculate_bytes_allowed(bps_limit, time_elapsed);
+	if (bytes_trim <= 0) {
+		bytes_trim = tg->bytes_disp[rw];
+		tg->bytes_disp[rw] = 0;
+		goto out;
+	}
+
+	if (tg->bytes_disp[rw] >= bytes_trim)
+		tg->bytes_disp[rw] -= bytes_trim;
+	else
+		tg->bytes_disp[rw] = 0;
+out:
+	return bytes_trim;
+}
+
+static int throtl_trim_iops(struct throtl_grp *tg, bool rw,
+			    unsigned long time_elapsed)
+{
+	u32 iops_limit = tg_iops_limit(tg, rw);
+	int io_trim;
+
+	if (iops_limit == UINT_MAX)
+		return 0;
+
+	/* Need to consider the case of io_allowed overflow. */
+	io_trim = calculate_io_allowed(iops_limit, time_elapsed);
+	if (io_trim <= 0) {
+		io_trim = tg->io_disp[rw];
+		tg->io_disp[rw] = 0;
+		goto out;
+	}
+
+	if (tg->io_disp[rw] >= io_trim)
+		tg->io_disp[rw] -= io_trim;
+	else
+		tg->io_disp[rw] = 0;
+out:
+	return io_trim;
+}
+
 /* Trim the used slices and adjust slice start accordingly */
 static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 {
@@ -612,22 +662,11 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	 * one extra slice is preserved for deviation.
 	 */
 	time_elapsed -= tg->td->throtl_slice;
-	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
-					     time_elapsed);
-	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed);
-	if (bytes_trim <= 0 && io_trim <= 0)
+	bytes_trim = throtl_trim_bps(tg, rw, time_elapsed);
+	io_trim = throtl_trim_iops(tg, rw, time_elapsed);
+	if (!bytes_trim && !io_trim)
 		return;
 
-	if ((long long)tg->bytes_disp[rw] >= bytes_trim)
-		tg->bytes_disp[rw] -= bytes_trim;
-	else
-		tg->bytes_disp[rw] = 0;
-
-	if ((int)tg->io_disp[rw] >= io_trim)
-		tg->io_disp[rw] -= io_trim;
-	else
-		tg->io_disp[rw] = 0;
-
 	tg->slice_start[rw] += time_elapsed;
 
 	throtl_log(&tg->service_queue,
@@ -643,6 +682,8 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
 	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
 	u64 bps_limit = tg_bps_limit(tg, rw);
 	u32 iops_limit = tg_iops_limit(tg, rw);
+	long long bytes_allowed;
+	int io_allowed;
 
 	/*
 	 * If the queue is empty, carryover handling is not needed. In such cases,
@@ -661,19 +702,28 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
 	 * accumulate how many bytes/ios are waited across changes. And use the
 	 * calculated carryover (@bytes/@ios) to update [bytes/io]_disp, which
 	 * will be used to calculate new wait time under new configuration.
+	 * And we need to consider the case of bytes/io_allowed overflow.
 	 */
 	if (bps_limit != U64_MAX) {
-		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
-			tg->bytes_disp[rw];
-		tg->bytes_disp[rw] = -*bytes;
+		bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed);
+		if (bytes_allowed < 0) {
+			tg->bytes_disp[rw] = 0;
+		} else {
+			*bytes = bytes_allowed - tg->bytes_disp[rw];
+			tg->bytes_disp[rw] = -*bytes;
+		}
 	} else {
 		tg->bytes_disp[rw] = 0;
 	}
 
 	if (iops_limit != UINT_MAX) {
-		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
-			tg->io_disp[rw];
-		tg->io_disp[rw] = -*ios;
+		io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed);
+		if (io_allowed < 0) {
+			tg->io_disp[rw] = 0;
+		} else {
+			*ios = io_allowed - tg->io_disp[rw];
+			tg->io_disp[rw] = -*ios;
+		}
 	} else {
 		tg->io_disp[rw] = 0;
 	}
@@ -741,7 +791,9 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
 	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
-	if (bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
+	/* Need to consider the case of bytes_allowed overflow. */
+	if ((bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
+	    || bytes_allowed < 0)
 		return 0;
 
 	/* Calc approx time to dispatch */
-- 
2.46.1

