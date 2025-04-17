Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E02DFA56
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896658; cv=none; b=jHUg6Hy0v060C7JPB8gkJCkUXMkz4c9nwU3DCM5oOVbQfCbsmVd4QMhsvaM23y31bQyM/8ccDYtNs0II5LDRjfxaVK/Jmkk7Yk7oF76et0zQvUTa81f/bGeQu6jNwwoXP0mUx2Ush0QuBnEBvH07xR/uryXsSl7qWhyfkad7uzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896658; c=relaxed/simple;
	bh=M9dEGbP+kpsUVA7jS8Xmf7qa0/WAUkE0jQNsNxPgBo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtUI4LQHkWQTjNUNJFdUdneHsyzwIQdMI0IfF2m3zNoy0bhREF83FfAmd2WvYHbB5oA/P8NzGZIU+BxeUTM5I+F1hMx39OpWcNy90cKRZq7LpiXQ0obpnKGvMgLvJ+lgVdLjul5PcwODf3p0gyBXKJo2CaL1EMv+SFVB5Jx+5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zdf0L5ngFz4f3m7N
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 21:30:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1D4121A018D
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 21:30:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl+KAgFoiwYGJw--.9194S7;
	Thu, 17 Apr 2025 21:30:51 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V2 3/3] blk-throttle: Add an additional overflow check to the call calculate_bytes/io_allowed
Date: Thu, 17 Apr 2025 21:20:54 +0800
Message-ID: <20250417132054.2866409-4-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250417132054.2866409-1-wozizhi@huaweicloud.com>
References: <20250417132054.2866409-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl+KAgFoiwYGJw--.9194S7
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyktr43CryDWw1xWFykZrb_yoW7WFW7pr
	4fJF17Ka1qqF1xJrn3A3ZayFWrJrWxAryUJrW5W3yrAF98Kryvgr1DurZ8tayIyFyxZayf
	A34DZasrCr4jyaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvoGdUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

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
 block/blk-throttle.c | 83 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 66a9044a5207..a0c2b2813ee7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -571,6 +571,48 @@ static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
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
+	if (bytes_trim <= 0 || tg->bytes_disp[rw] < bytes_trim) {
+		bytes_trim = tg->bytes_disp[rw];
+		tg->bytes_disp[rw] = 0;
+	} else {
+		tg->bytes_disp[rw] -= bytes_trim;
+	}
+
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
+	if (io_trim <= 0 || tg->io_disp[rw] < io_trim) {
+		io_trim = tg->io_disp[rw];
+		tg->io_disp[rw] = 0;
+	} else {
+		tg->io_disp[rw] -= io_trim;
+	}
+
+	return io_trim;
+}
+
 /* Trim the used slices and adjust slice start accordingly */
 static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 {
@@ -612,22 +654,11 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
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
@@ -643,6 +674,8 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
 	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
 	u64 bps_limit = tg_bps_limit(tg, rw);
 	u32 iops_limit = tg_iops_limit(tg, rw);
+	long long bytes_allowed;
+	int io_allowed;
 
 	/*
 	 * If the queue is empty, carryover handling is not needed. In such cases,
@@ -661,13 +694,19 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
 	 * accumulate how many bytes/ios are waited across changes. And use the
 	 * calculated carryover (@bytes/@ios) to update [bytes/io]_disp, which
 	 * will be used to calculate new wait time under new configuration.
+	 * And we need to consider the case of bytes/io_allowed overflow.
 	 */
-	if (bps_limit != U64_MAX)
-		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
-			tg->bytes_disp[rw];
-	if (iops_limit != UINT_MAX)
-		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
-			tg->io_disp[rw];
+	if (bps_limit != U64_MAX) {
+		bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed);
+		if (bytes_allowed > 0)
+			*bytes = bytes_allowed - tg->bytes_disp[rw];
+	}
+	if (iops_limit != UINT_MAX) {
+		io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed);
+		if (io_allowed > 0)
+			*ios = io_allowed - tg->io_disp[rw];
+	}
+
 	tg->bytes_disp[rw] = -*bytes;
 	tg->io_disp[rw] = -*ios;
 }
@@ -734,7 +773,9 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
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

