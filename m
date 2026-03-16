Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80F299944
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651329; cv=none; b=sNo3VxzDbLo0Q7EGJgtD+sHRNJAlNafs3SCSkbVZx0PqMR3o7PgMeIkel83hBnL6jU3oSoRlLk6LFl4NQbqoAhNpzmK3PkN5AhsxcOCC3qFu8MkVLTD3BoaH3bIkjN85kol2OMAdRbET7exUMKr9CkDoaMuLdOO6DDvG4GhuGmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651329; c=relaxed/simple;
	bh=ZCgrO93eOd/x+wnBB7jGbjGyUuhnR9Gh8bo8Ig6Z6q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kEOWS9Qe6F1/Cr/0rhAX+bFpNy31aPsX7+GiGd4RJZSNuE56cMvdiOrrtqtSmX3zx670tX17ouqnRm/J3fD8aQPbraq69efdjNpfIjQRDd/lX+IFYUG4YtPw1427EnZW+Tya+qwYTgg1/q7pxkwFOAw6QGO/E+nUpTPgPhJ1owQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fZ86p39q3zKHMn1
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 16:54:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D09A54056F
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 16:55:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP1 (Coremail) with SMTP id cCh0CgA3Otp6xbdpKYBhBA--.38497S5;
	Mon, 16 Mar 2026 16:55:22 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	yukuai@fnnas.com,
	ming.lei@redhat.com,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huaweicloud.com
Subject: [PATCH 1/2] blk-throttle: remove leftover carryover checks in tg_within_[bps/iops]_limit
Date: Mon, 16 Mar 2026 16:44:54 +0800
Message-Id: <20260316084455.3323966-2-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260316084455.3323966-1-wozizhi@huaweicloud.com>
References: <20260316084455.3323966-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3Otp6xbdpKYBhBA--.38497S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4kJry3Jr1fWF1UKrWUCFg_yoW5Wryrpr
	WrGr1xWa1xXFn7trnxJan8ZFWrJrnrAr98JrW3Wa48CFn8CF1qqF909rWYyayxZF97uFWf
	A3ZYq3Z7Ar4qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw
	1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfU5DGOUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Commit bb8d5587bdc3 ("blk-throttle: fix wrong comparation while
'carryover_ios/bytes' is negative") changed the type of "io_allowed" and
"bytes_allowed", and added "io_allowed > 0" and "bytes_allowed > 0" checks
to handle the case where carryover_ios/bytes could be negative.

Since commit 6cc477c36875 ("blk-throttle: carry over directly") removed
the "carryover" fields, the allowed values are now computed solely by
calculate_io_allowed() and calculate_bytes_allowed(), which always return
non-negative results. The extra checks are therefore no longer necessary.

Remove the now-unnecessary "> 0" checks and restore the types of
"io_allowed" and "bytes_allowed" to unsigned to match the return types of
the corresponding calculate functions.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/blk-throttle.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 97188a795848..b82da0dfa8e8 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -760,7 +760,7 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 				 u32 iops_limit)
 {
 	bool rw = bio_data_dir(bio);
-	int io_allowed;
+	unsigned int io_allowed;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 
 	jiffy_elapsed = jiffies - tg->slice_start[rw];
@@ -768,7 +768,7 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
 	/* Round up to the next throttle slice, wait time must be nonzero */
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, DFL_THROTL_SLICE);
 	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
-	if (io_allowed > 0 && tg->io_disp[rw] + 1 <= io_allowed)
+	if (tg->io_disp[rw] + 1 <= io_allowed)
 		return 0;
 
 	/* Calc approx time to dispatch */
@@ -783,8 +783,7 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 				u64 bps_limit)
 {
 	bool rw = bio_data_dir(bio);
-	long long bytes_allowed;
-	u64 extra_bytes;
+	u64 bytes_allowed, extra_bytes;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
@@ -796,9 +795,7 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, DFL_THROTL_SLICE);
 	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
-	/* Need to consider the case of bytes_allowed overflow. */
-	if ((bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
-	    || bytes_allowed < 0)
+	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed)
 		return 0;
 
 	/* Calc approx time to dispatch */
-- 
2.39.2

