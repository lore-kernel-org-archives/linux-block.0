Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE62356AA
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888121; cv=none; b=Ur6MyY5J9Ijw+vVbHbCTOmpXO32qQRlCjL1c6oDwd+ymEAE6NfhDdtfDNkzfWA1A6act6t3oIi1mqO6vCKH8Z6fJgE3CEPP2hAd/61NqsPlupLl0ilyb39OliUHY+FoUQNMV1lfb/JLJTjN+MJ4Ctl0vHn727GRoN4036SOSB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888121; c=relaxed/simple;
	bh=d2jYNP46pjZwMxFz8e5VGc2oTprAnxIoTZXpKCw3rJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhiOXSTpDSXsC6+TtSgtsyi3sWgOyk3e3W5frIRvy04UlmztJPshis6zCIAJ/GHRmwX6gz5hKpuV9Pg/rWFGGPlxTAPzIOK/GxrB4TCXpORbUMbLHMkG9JwoeKP7HGAzgerUMl4WdhSWwwyUE7RAthYS2OUpYLKZhsyQ1RrZkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZdZrF19Nkz4f3jt7
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 877241A019B
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl8s4QBoyDT8Jg--.2150S8;
	Thu, 17 Apr 2025 19:08:31 +0800 (CST)
From: Zizhi Wo <wozizhi@huawei.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V2 4/7] blk-throttle: Introduce flag "BIO_TG_BPS_THROTTLED"
Date: Thu, 17 Apr 2025 18:58:30 +0800
Message-ID: <20250417105833.1930283-5-wozizhi@huawei.com>
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
X-CM-TRANSID:gCh0CgC3Gl8s4QBoyDT8Jg--.2150S8
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWfWw43Wr17GF1DZw1kKrg_yoW5Xr1rpF
	W8urs5Cw18Gr4vgr97J3W3ua97Ar4xCry5ArZxJr1YvF17Kr1Dtrn7Zr10ya1Fka9a9F47
	ZFs5KrWxC3WUGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x
	0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UMBTnUUUUU=
Sender: wozizhi@huaweicloud.com
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

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
---
 block/blk-throttle.c      | 9 +++++++--
 include/linux/blk_types.h | 5 +++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 91ee1c502b41..caae2e3b7534 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -741,12 +741,16 @@ static void throtl_charge_bps_bio(struct throtl_grp *tg, struct bio *bio)
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
 
@@ -772,7 +776,8 @@ static unsigned long tg_dispatch_bps_time(struct throtl_grp *tg, struct bio *bio
 
 	/* no need to throttle if this bio's bytes have been accounted */
 	if (bps_limit == U64_MAX || tg->flags & THROTL_TG_CANCELING ||
-	    bio_flagged(bio, BIO_BPS_THROTTLED))
+	    bio_flagged(bio, BIO_BPS_THROTTLED) ||
+	    bio_flagged(bio, BIO_TG_BPS_THROTTLED))
 		return 0;
 
 	tg_update_slice(tg, rw);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dce7615c35e7..7e0eddfaaa98 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -296,6 +296,11 @@ enum {
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_QOS_THROTTLED,	/* bio went through rq_qos throttle path */
+	/*
+	 * This bio has undergone rate limiting at the single throtl_grp level bps
+	 * queue. Since throttle and QoS are not at the same level, reuse the value.
+	 */
+	BIO_TG_BPS_THROTTLED = BIO_QOS_THROTTLED,
 	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
-- 
2.46.1

