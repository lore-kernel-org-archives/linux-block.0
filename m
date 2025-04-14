Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5171B2522A5
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637846; cv=none; b=SbkQ/MNGiUr9l+zeK9aNuZ7bXW6PvfyrUTxkA4FUpecXAkvX2Il8cXG3r/0MP/3Sr/z7nDUi+nU/VI7hOll7h5jDNgGJYFTlqWxflQHVCltGBSS2bVWdG2q1H/PcvkCI98M/PIBZMioTWp5O5HmKa2QNeJbx8srdSiRhQEP1KwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637846; c=relaxed/simple;
	bh=4Rs3RIQ/EVL64cZA25Q/Sqt8igFFe7wJWS6u3FWacQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnCg8rHXHzptYt0v0D230iNr2Ku8q6i6rh3+WqmG1Or2jnEAZJCP+g4rWw4NnTy8xraWhAzbIQNNB20Gl2W0QylCBWOH/suW2Bdk1KfR6BgoywHz5gRVNtUM00J6lp44+eTdq6t178GgK3/ZfiWLpRKNYYQTdK2VXjITmcyUpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZbpCk61rXzHrP8;
	Mon, 14 Apr 2025 21:33:54 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 877F4180080;
	Mon, 14 Apr 2025 21:37:20 +0800 (CST)
Received: from localhost.localdomain (10.175.112.188) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 21:37:19 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <yukuai3@huawei.com>, <wozizhi@huawei.com>,
	<ming.lei@redhat.com>, <tj@kernel.org>
Subject: [PATCH 3/7] blk-throttle: Split throtl_charge_bio() into bps and iops functions
Date: Mon, 14 Apr 2025 21:27:27 +0800
Message-ID: <20250414132731.167620-4-wozizhi@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250414132731.167620-1-wozizhi@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)

Split throtl_charge_bio() to facilitate subsequent patches that will
separately charge bps and iops after queue separation.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
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

