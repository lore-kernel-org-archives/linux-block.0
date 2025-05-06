Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25482FF71A
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498042; cv=none; b=C58Zh6nk4RaEvZNm+NP2XB3MTLhOCaqd8coMBGEGht2GanAO+KzCzKIFI8w3Ffl0QAxGajCdpWXAC20huFr4XX5/qsLxyT3ykVA+NxvagpbSsFOppNZWbF8w0Jc4JBraigbVoofDzX0tANFHG258PsDaeMFWGlkuX2zsMZJrWZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498042; c=relaxed/simple;
	bh=ZgUkGmIYX/DOAGCJIAS/P7vBU0PVgS8NpNAlNGciLqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIvaqa/hE8GHr/cp86OXcCcsBp0sHHO2AIbZ/VogA2J0HFpuvREbi9nygHUuo11hEvrCMF9qRFg0P7ngeLNDv36fceQWkSifXpqmKIxGE3VKeodjscAXnR7OZudgwnQ96kBG88h8tklkG9yjjuCPLBPimtEYDwLy63GuXvvSII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4Zs2Dk68KXzKHMjV
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A802C1A018D
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGDxcRloS3NDLg--.28694S7;
	Tue, 06 May 2025 10:20:37 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V5 3/7] blk-throttle: Split throtl_charge_bio() into bps and iops functions
Date: Tue,  6 May 2025 10:09:30 +0800
Message-ID: <20250506020935.655574-4-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250506020935.655574-1-wozizhi@huaweicloud.com>
References: <20250506020935.655574-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGDxcRloS3NDLg--.28694S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXr45KF4DtFy3Wr4xZry7KFg_yoW5WF4kpa
	yUCwsxGw4kJrsrKrsxXF17GFZ5ta1xAry2k39xGay5Aa1293s8Kw1DZryrAFW8ZFZ3uwn3
	ZF90qw1xG3WUJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU9J5rUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Split throtl_charge_bio() to facilitate subsequent patches that will
separately charge bps and iops after queue separation.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
---
 block/blk-throttle.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 24bc1a850581..fea09a91c20b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -787,6 +787,20 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	return jiffy_wait;
 }
 
+static void throtl_charge_bps_bio(struct throtl_grp *tg, struct bio *bio)
+{
+	unsigned int bio_size = throtl_bio_data_size(bio);
+
+	/* Charge the bio to the group */
+	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
+		tg->bytes_disp[bio_data_dir(bio)] += bio_size;
+}
+
+static void throtl_charge_iops_bio(struct throtl_grp *tg, struct bio *bio)
+{
+	tg->io_disp[bio_data_dir(bio)]++;
+}
+
 /*
  * If previous slice expired, start a new one otherwise renew/extend existing
  * slice to make sure it is at least throtl_slice interval long since now. New
@@ -859,18 +873,6 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
 	return max(bps_wait, iops_wait);
 }
 
-static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
-{
-	bool rw = bio_data_dir(bio);
-	unsigned int bio_size = throtl_bio_data_size(bio);
-
-	/* Charge the bio to the group */
-	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
-		tg->bytes_disp[rw] += bio_size;
-
-	tg->io_disp[rw]++;
-}
-
 /**
  * throtl_add_bio_tg - add a bio to the specified throtl_grp
  * @bio: bio to add
@@ -957,7 +959,8 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
 	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
 	sq->nr_queued[rw]--;
 
-	throtl_charge_bio(tg, bio);
+	throtl_charge_bps_bio(tg, bio);
+	throtl_charge_iops_bio(tg, bio);
 
 	/*
 	 * If our parent is another tg, we just need to transfer @bio to
@@ -1684,7 +1687,8 @@ bool __blk_throtl_bio(struct bio *bio)
 	while (true) {
 		if (tg_within_limit(tg, bio, rw)) {
 			/* within limits, let's charge and dispatch directly */
-			throtl_charge_bio(tg, bio);
+			throtl_charge_bps_bio(tg, bio);
+			throtl_charge_iops_bio(tg, bio);
 
 			/*
 			 * We need to trim slice even when bios are not being
@@ -1707,7 +1711,8 @@ bool __blk_throtl_bio(struct bio *bio)
 			 * control algorithm is adaptive, and extra IO bytes
 			 * will be throttled for paying the debt
 			 */
-			throtl_charge_bio(tg, bio);
+			throtl_charge_bps_bio(tg, bio);
+			throtl_charge_iops_bio(tg, bio);
 		} else {
 			/* if above limits, break to queue */
 			break;
-- 
2.46.1

