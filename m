Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76871A83E7
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896656; cv=none; b=dKPUOEJGY1p7/30TPz7tKz5FW6qYlIK+oaQ0Tm6higRaCXmwUypYz30TtGB6Xr1Q7WU55hNYULMdcQPtxT2bT2WWMvEGyRDhA9T5FB3sDbJ5YwEqkUxufxJvjDSmHwW1dzh+i/Rci2Rvh2S4vJ7a9dJqCC2i48l3u/bAAU/g97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896656; c=relaxed/simple;
	bh=EEkYiImOYCdl4AVkC+s8yY0EPMZD1JcKDKT2D1K8g7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+tlamzCNN/W5LILNJuFb3Juu1LwqYpnjECvq6G3Wauhze2y24/zKDGS8bDtwe8tILRS+oVd5/fRSEOEqohBrS5kBPqIV1pulUDzS2riZgyl5xgALSmR4u4y1WAibCG64wG1Uq4P3cV2SQNnSTf8EXpCDFZ5gnjhWA9JLe82lLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zdf0T0CRzz4f3jYl
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 21:30:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 67A3C1A018D
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 21:30:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl+KAgFoiwYGJw--.9194S5;
	Thu, 17 Apr 2025 21:30:51 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V2 1/3] blk-throttle: Fix wrong tg->[bytes/io]_disp update in __tg_update_carryover()
Date: Thu, 17 Apr 2025 21:20:52 +0800
Message-ID: <20250417132054.2866409-2-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDXOl+KAgFoiwYGJw--.9194S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAr17XF48KF15JrykJw18Zrb_yoW5Gw4xpF
	yYya13Jw1DXF4fW3sxA3Z7KFWUXayxAry3JrZ2kr4YyF1Yk34vgrW5Cr90kay0yFn3GFW8
	A34qqrZxWF1rurDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU-_-PUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

In commit 6cc477c36875 ("blk-throttle: carry over directly"), the carryover
bytes/ios was be carried to [bytes/io]_disp. However, its update mechanism
has some issues.

In __tg_update_carryover(), we calculate "bytes" and "ios" to represent the
carryover, but the computation when updating [bytes/io]_disp is incorrect.
And if the sq->nr_queued is empty, we may not update tg->[bytes/io]_disp to
0 in tg_update_carryover(). We should set it to 0 in non carryover case.
This patch fixes the issue.

Fixes: 6cc477c36875 ("blk-throttle: carry over directly")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/blk-throttle.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 91dab43c65ab..8ac8db116520 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -644,6 +644,18 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
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
@@ -656,8 +668,8 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
 	if (iops_limit != UINT_MAX)
 		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
 			tg->io_disp[rw];
-	tg->bytes_disp[rw] -= *bytes;
-	tg->io_disp[rw] -= *ios;
+	tg->bytes_disp[rw] = -*bytes;
+	tg->io_disp[rw] = -*ios;
 }
 
 static void tg_update_carryover(struct throtl_grp *tg)
@@ -665,10 +677,8 @@ static void tg_update_carryover(struct throtl_grp *tg)
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

