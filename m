Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDB2356C8
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888122; cv=none; b=HG/5ND6PKPmytNO0rr/HmCDp7yHRmXF2gRSQHuzH+uawM6YD4LsX46t9LWRhm1HOT3WHzVRoYFjqzBbNtTHg8kalPHZQ4AENtOg4p7T7rZT/Kkizb6DNVSdpTJDJOFnBA/F4D1K5TikCzxT692vcOGYwxOyOryqcHwAhEKZcA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888122; c=relaxed/simple;
	bh=T7Jrj4b0Gwm2nlkldATwC4/KAP38uK8GsChMZY1pDq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzVOwrbJ8sTpqpu8u2v7atzFhm7+mxtUO6i89kGrWu/+3JfBfO8mRdJKcU2Rd20QNB8693/cEuB/yBdCx0pnYE4lCuxOvwXx7Qlr8oLLWqQydenoxaCSQjukHZEgoyRdfVpapAEjjFjKDQw7MygDrYX3qxKskNffhqYT3p255MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZdZr56VSRz4f3m6S
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 328771A019B
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl8s4QBoyDT8Jg--.2150S7;
	Thu, 17 Apr 2025 19:08:31 +0800 (CST)
From: Zizhi Wo <wozizhi@huawei.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V2 3/7] blk-throttle: Split throtl_charge_bio() into bps and iops functions
Date: Thu, 17 Apr 2025 18:58:29 +0800
Message-ID: <20250417105833.1930283-4-wozizhi@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250417105833.1930283-1-wozizhi@huawei.com>
References: <20250417105833.1930283-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl8s4QBoyDT8Jg--.2150S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXr45KF43uw48Zw4xAw1xAFb_yoW5XFWDpa
	y7CwsxGw4kJr4DKrsxXF17GFZ5ta1xAry2k393G3yUAanI9w1Dtr1UZryrAFWUuFZ3Wwn7
	ZF90qw17G3WUJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262
	kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UNjjgUUUUU=
Sender: wozizhi@huaweicloud.com
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Split throtl_charge_bio() to facilitate subsequent patches that will
separately charge bps and iops after queue separation.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 0633ae0cce90..91ee1c502b41 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -736,6 +736,20 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
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
  * slice to make sure it is at least throtl_slice interval long since now.
@@ -808,18 +822,6 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
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
@@ -906,7 +908,8 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
 	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
 	sq->nr_queued[rw]--;
 
-	throtl_charge_bio(tg, bio);
+	throtl_charge_bps_bio(tg, bio);
+	throtl_charge_iops_bio(tg, bio);
 
 	/*
 	 * If our parent is another tg, we just need to transfer @bio to
@@ -1633,7 +1636,8 @@ bool __blk_throtl_bio(struct bio *bio)
 	while (true) {
 		if (tg_within_limit(tg, bio, rw)) {
 			/* within limits, let's charge and dispatch directly */
-			throtl_charge_bio(tg, bio);
+			throtl_charge_bps_bio(tg, bio);
+			throtl_charge_iops_bio(tg, bio);
 
 			/*
 			 * We need to trim slice even when bios are not being
@@ -1656,7 +1660,8 @@ bool __blk_throtl_bio(struct bio *bio)
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

