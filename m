Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B721E19E96A
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896656; cv=none; b=MHxTo/vRR3rfqwvt/u9qy22fXH/dkAM6LdihTr0UxmSERf675Gg2KFx7hRsJAdMHE16O2HceF4wYxgTkhqzKWutsAxSuqlwQHs3nTP6quvlVyjuKKAL+MMUouZsxRbB6xpW7/WmnnJpMvppKPKxzQ2q0B9QdLuJVYD0GrbGpH4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896656; c=relaxed/simple;
	bh=y93Fzk6LVw9QOoH46kv3J8hV0gcjYJEGw7gYB0MeVVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+W8ATTL8te55iLBs2sdkRN+gyqrSlSK415ti40duB8Mq5XkVVUDdjWEtBGw9yAtzgT30tXrOzpqi15RPOp3MaGvzBrSLJIwt6QGohDKjkBF+7mwChXFvVNyfMIKQ+iS+7l4Vzi8FgeohXhUSLF+dkjAEevWXBqo5VAjpofyCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zdf0L3QhQz4f3m7H
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 21:30:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BCCA81A111D
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 21:30:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl+KAgFoiwYGJw--.9194S6;
	Thu, 17 Apr 2025 21:30:51 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V2 2/3] blk-throttle: Delete unnecessary carryover-related fields from throtl_grp
Date: Thu, 17 Apr 2025 21:20:53 +0800
Message-ID: <20250417132054.2866409-3-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDXOl+KAgFoiwYGJw--.9194S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGw17ur4kWw48Wr18GryxGrg_yoW5Cr15pF
	Wag3W8W3WUtFnxWa13G3WftFWUX393Gry5J398Gr1SyFyakr929r95Cr1Fya10yF93CFW0
	qw1jqr9rAF1UuFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUoBT5UUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

We no longer need carryover_[bytes/ios] in tg, so it is removed. The
related comments about carryover in tg are also merged into
[bytes/io]_disp, and modify other related comments.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c |  8 ++++----
 block/blk-throttle.h | 19 ++++++++-----------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8ac8db116520..66a9044a5207 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -658,9 +658,9 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
 
 	/*
 	 * If config is updated while bios are still throttled, calculate and
-	 * accumulate how many bytes/ios are waited across changes. And
-	 * carryover_bytes/ios will be used to calculate new wait time under new
-	 * configuration.
+	 * accumulate how many bytes/ios are waited across changes. And use the
+	 * calculated carryover (@bytes/@ios) to update [bytes/io]_disp, which
+	 * will be used to calculate new wait time under new configuration.
 	 */
 	if (bps_limit != U64_MAX)
 		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
@@ -680,7 +680,7 @@ static void tg_update_carryover(struct throtl_grp *tg)
 	__tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
 	__tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
 
-	/* see comments in struct throtl_grp for meaning of these fields. */
+	/* see comments in struct throtl_grp for meaning of carryover. */
 	throtl_log(&tg->service_queue, "%s: %lld %lld %d %d\n", __func__,
 		   bytes[READ], bytes[WRITE], ios[READ], ios[WRITE]);
 }
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 7964cc041e06..8bd16535302c 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -101,19 +101,16 @@ struct throtl_grp {
 	/* IOPS limits */
 	unsigned int iops[2];
 
-	/* Number of bytes dispatched in current slice */
-	int64_t bytes_disp[2];
-	/* Number of bio's dispatched in current slice */
-	int io_disp[2];
-
 	/*
-	 * The following two fields are updated when new configuration is
-	 * submitted while some bios are still throttled, they record how many
-	 * bytes/ios are waited already in previous configuration, and they will
-	 * be used to calculate wait time under new configuration.
+	 * Number of bytes/bio's dispatched in current slice.
+	 * When new configuration is submitted while some bios are still throttled,
+	 * first calculate the carryover: the amount of bytes/IOs already waited
+	 * under the previous configuration. Then, [bytes/io]_disp are represented
+	 * as the negative of the carryover, and they will be used to calculate the
+	 * wait time under the new configuration.
 	 */
-	long long carryover_bytes[2];
-	int carryover_ios[2];
+	int64_t bytes_disp[2];
+	int io_disp[2];
 
 	unsigned long last_check_time;
 
-- 
2.46.1

