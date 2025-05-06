Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC532FF2BE
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498044; cv=none; b=os8O66K3lIV/4mvkuIscD3Kd+3qpETdR1RYWKjqEWRPq34kWKcEV7eEKTBa5/8MqqlDyBYEx2kXGMRgJ7Lznk9fdbxulAzKdO2La+rp0qCudGq6TFVmoz7sN8/MyJ3i9dlKbwBLY7R6up5zM2h4CV+j0lH0LQNybmREgRy2wzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498044; c=relaxed/simple;
	bh=teJ2xYcUXG0yJx36p39q64y1eSgCUeJHqx3CQLzRe18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGKVAF7gCsOUG/YpGEOHSjmctX2ZX7Xv9l1swuHvK4ciM6w/OFPl0j5T8kfSyHjM4EGbiVHuuNsn0EIViBwh1cLQ/dXYPTZ8U+sIyef3FcQMMjMqc/EvF1bzVn+b0kP2SSAr7/gPCUGEwQI+jBZrCEL4WQ/gDck3JEzAREbuRLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zs2DF3yjDz4f3l6v
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 066E81A018D
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:20:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGDxcRloS3NDLg--.28694S8;
	Tue, 06 May 2025 10:20:37 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V5 4/7] blk-throttle: Introduce flag "BIO_TG_BPS_THROTTLED"
Date: Tue,  6 May 2025 10:09:31 +0800
Message-ID: <20250506020935.655574-5-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXvGDxcRloS3NDLg--.28694S8
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWfWw43Wr17GF1DZw1kKrg_yoW5ArWfpF
	y8urs8Cw18Gr4v9r93Jw17XFZ7Ar4xCryYyrZxJr1avF12gryqqr1kZF18AF4Fkasa9F4U
	ZFsYgrWxC3W8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAV
	WUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvYLPUUUUU
	=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Subsequent patches will split the single queue into separate bps and iops
queues. To prevent IO that has already passed through the bps queue at a
single tg level from being counted toward bps wait time again, we introduce
"BIO_TG_BPS_THROTTLED" flag. Since throttle and QoS operate at different
levels, we reuse the value as "BIO_QOS_THROTTLED".

We set this flag when charge bps and clear it when charge iops, as the bio
will move to the upper-level tg or be dispatched.

This patch does not involve functional changes.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
---
 block/blk-throttle.c      | 9 +++++++--
 include/linux/blk_types.h | 8 ++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index fea09a91c20b..ee4eeee8f21f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -792,12 +792,16 @@ static void throtl_charge_bps_bio(struct throtl_grp *tg, struct bio *bio)
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
 	/* Charge the bio to the group */
-	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
+	if (!bio_flagged(bio, BIO_BPS_THROTTLED) &&
+	    !bio_flagged(bio, BIO_TG_BPS_THROTTLED)) {
+		bio_set_flag(bio, BIO_TG_BPS_THROTTLED);
 		tg->bytes_disp[bio_data_dir(bio)] += bio_size;
+	}
 }
 
 static void throtl_charge_iops_bio(struct throtl_grp *tg, struct bio *bio)
 {
+	bio_clear_flag(bio, BIO_TG_BPS_THROTTLED);
 	tg->io_disp[bio_data_dir(bio)]++;
 }
 
@@ -823,7 +827,8 @@ static unsigned long tg_dispatch_bps_time(struct throtl_grp *tg, struct bio *bio
 
 	/* no need to throttle if this bio's bytes have been accounted */
 	if (bps_limit == U64_MAX || tg->flags & THROTL_TG_CANCELING ||
-	    bio_flagged(bio, BIO_BPS_THROTTLED))
+	    bio_flagged(bio, BIO_BPS_THROTTLED) ||
+	    bio_flagged(bio, BIO_TG_BPS_THROTTLED))
 		return 0;
 
 	tg_update_slice(tg, rw);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5a46067e85b1..63fa100d2022 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -295,6 +295,14 @@ enum {
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_QOS_THROTTLED,	/* bio went through rq_qos throttle path */
+	/*
+	 * This bio has completed bps throttling at the single tg granularity,
+	 * which is different from BIO_BPS_THROTTLED. When the bio is enqueued
+	 * into the sq->queued of the upper tg, or is about to be dispatched,
+	 * this flag needs to be cleared. Since blk-throttle and rq_qos are not
+	 * on the same hierarchical level, reuse the value.
+	 */
+	BIO_TG_BPS_THROTTLED = BIO_QOS_THROTTLED,
 	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
-- 
2.46.1

