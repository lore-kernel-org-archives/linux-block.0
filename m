Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66412522BA
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637845; cv=none; b=qppSJp8v+Zzt2N09NZvUzySF37g2Woq6ZMgTp66bz+yJjrcnyAoCYcZDwcRIj2uUj88BCAGJ6yLk6E730quKVrqYAed2nJCy3rs3oNHVVysTt3JeQxbrfvnISerUIjsbFjNZjKV433TWGq3OW3UpCbWI0Js4w0nui9LqRrQSvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637845; c=relaxed/simple;
	bh=zXXkWZJwPfLE6lx7sQqdHy6crJ+l9NlMTq2p9dlWyaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRTMr+KaeUkO0TtwpuZTNKF+9MwU0utd/tJuOL3X+90PeD34JkV2e59z6sbWy0r68+x/umd7nW+DM1O5Uib9TwRWVPQjUcfdVMoxMK/7S3DGQdzE6LWsnMh1egmf+r+B7OgFzNM6xHPBSqsxBix7jeuCwDIjEq9W3JHNK9PfkkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZbpHb6wlZz2TS1K;
	Mon, 14 Apr 2025 21:37:15 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 33DFF14027A;
	Mon, 14 Apr 2025 21:37:21 +0800 (CST)
Received: from localhost.localdomain (10.175.112.188) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Apr 2025 21:37:20 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <yangerkun@huawei.com>, <yukuai3@huawei.com>, <wozizhi@huawei.com>,
	<ming.lei@redhat.com>, <tj@kernel.org>
Subject: [PATCH 4/7] blk-throttle: Introduce flag "BIO_TG_BPS_THROTTLED"
Date: Mon, 14 Apr 2025 21:27:28 +0800
Message-ID: <20250414132731.167620-5-wozizhi@huawei.com>
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

Subsequent patches will split the single queue into separate bps and iops
queues. To prevent IO that has already passed through the bps queue at a
single tg level from being counted toward bps wait time again, we introduce
"BIO_TG_BPS_THROTTLED" flag. Since throttle and QoS operate at different
levels, we reuse the value as "BIO_QOS_THROTTLED".

We set this flag when charge bps and clear it when charge iops, as the bio
will move to the upper-level tg or be dispatched.

This patch does not involve functional changes.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
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
index dce7615c35e7..f9d1230e27a7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -296,6 +296,11 @@ enum {
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_QOS_THROTTLED,	/* bio went through rq_qos throttle path */
+	/*
+	 * This bio has undergone rate limiting at the single throtl_grp level bps
+	 * queue. Since throttle and QoS are not at the same level, reused the value.
+	 */
+	BIO_TG_BPS_THROTTLED = BIO_QOS_THROTTLED,
 	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
-- 
2.46.1

