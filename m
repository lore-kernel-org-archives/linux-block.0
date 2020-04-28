Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941C8C83001
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A362063A
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b8WjwKKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgD1Qol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:44:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8957 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgD1Qol (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 12:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588092282; x=1619628282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q2f7cB+y9fvxJVhbz7lxjL19R0ZBQ9k1bw/0y5KygJw=;
  b=b8WjwKKJ1j7XVcRssCqr4st3Sf65iJXP4NcHNUwqoGXQezM1Tg0BwNtc
   f+VNX+t5uRzFjhxMMerih2jQBuWnv5QyTyNaSqCXvFV6ghg8dHhkEhoea
   MLkpaIrhEBKhpz5DdPR9zb58lEpYJBx/rcsn1C5lvNNXIRl1R/GcwNEdt
   Hc76v+9J2u8Au8bl6K22SppBN9Yd/9gI9y2XwT49PSceQw6tAWv6lTIw+
   1R6p4xUwWmr6SS7q5ZOepkNVs40x3QmwHGjT//SYKyw1+X887Ac4cCgHP
   EJLYtxcITxn2mOF9SerQtKU+M21PGxDSk6q/M7/TIw3sDn5+XDairLLuP
   Q==;
IronPort-SDR: /6qSFBpfrnC+vzYcqGFY+YVXoBB5NLJDbu5jaTWoRewiPBiUQDDZpE7hpAdXmKQ5H3jR+8Y4Ar
 Zof2BpNaHxM0U5/fDJ4xnkUXBgikLP1jvEjsJvOwnE0OyjZpX/BxKb9EcoWXyY1Q/1pu2TmQiR
 3/cpB9dF1bSjd5nIy50s8W112wmL/LXbaKC3UVIPryVq1IRfUtlzknu0s+q2o418W9Upo0MT45
 /ZdzSohEP6NrsYbeQGU8x6vfqbW1yrSplyA04iwVjuDiYDIuGBgnj6aq/lgcYLzwhvuS46j7MQ
 8X8=
X-IronPort-AV: E=Sophos;i="5.73,328,1583164800"; 
   d="scan'208";a="140725863"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2020 00:44:42 +0800
IronPort-SDR: qaSGbMxaMivsXGFmCV2asWW+Vab4bOwBuzCoisnuTBMt+gkGyTQ6fqQGYIjhIalislt0zmBC4H
 A8oyocmcgf+1W9JByNhV0NPeI/LEzrGQM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 09:34:48 -0700
IronPort-SDR: iq+P2MB3+Z6sozoYZ/fht+D66VMJ2/I4QnueXyKhv41PPiPtzYMCHu0l5UvKNQ1E18f/aOe3Q6
 /qiVnBNhKZVQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 09:44:39 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/3] block: move blkcg_bio_issue_check out of line
Date:   Wed, 29 Apr 2020 01:44:33 +0900
Message-Id: <20200428164434.1517-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
References: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkcg_bio_issue_check() is way to big to be an inline function, move it to
the other blkcg related functions in block/blk-cgroup.c.

According to the bloat-o-meter this brings it's sole caller
generic_make_request_checks() down from 2417 to 1881 bytes (~22%).

$ ./scripts/bloat-o-meter -t vmlinux.old vmlinux
add/remove: 1/0 grow/shrink: 1/1 up/down: 667/-539 (128)
Function                                     old     new   delta
blkcg_bio_issue_check                          -     664    +664
generic_make_request_checks.cold              45      48      +3
generic_make_request_checks                 2372    1833    -539
Total: Before=9624970, After=9625098, chg +0.00%

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-cgroup.c         | 56 ++++++++++++++++++++++++++++++++++++
 include/linux/blk-cgroup.h | 58 +-------------------------------------
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c5dc833212e1..9003c76124e8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1706,6 +1706,62 @@ void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
 	set_notify_resume(current);
 }
 
+bool blkcg_bio_issue_check(struct request_queue *q, struct bio *bio)
+{
+	struct blkcg_gq *blkg;
+	bool throtl = false;
+
+	rcu_read_lock();
+
+	if (!bio->bi_blkg) {
+		char b[BDEVNAME_SIZE];
+
+		WARN_ONCE(1,
+			  "no blkg associated for bio on block-device: %s\n",
+			  bio_devname(bio, b));
+		bio_associate_blkg(bio);
+	}
+
+	blkg = bio->bi_blkg;
+
+	throtl = blk_throtl_bio(q, blkg, bio);
+
+	if (!throtl) {
+		struct blkg_iostat_set *bis;
+		int rwd, cpu;
+
+		if (op_is_discard(bio->bi_opf))
+			rwd = BLKG_IOSTAT_DISCARD;
+		else if (op_is_write(bio->bi_opf))
+			rwd = BLKG_IOSTAT_WRITE;
+		else
+			rwd = BLKG_IOSTAT_READ;
+
+		cpu = get_cpu();
+		bis = per_cpu_ptr(blkg->iostat_cpu, cpu);
+		u64_stats_update_begin(&bis->sync);
+
+		/*
+		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this
+		 * is a split bio and we would have already accounted for the
+		 * size of the bio.
+		 */
+		if (!bio_flagged(bio, BIO_QUEUE_ENTERED))
+			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
+		bis->cur.ios[rwd]++;
+
+		u64_stats_update_end(&bis->sync);
+		if (cgroup_subsys_on_dfl(io_cgrp_subsys))
+			cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);
+		put_cpu();
+	}
+
+	blkcg_bio_issue_init(bio);
+
+	rcu_read_unlock();
+	return !throtl;
+}
+
 /**
  * blkcg_add_delay - add delay to this blkg
  * @blkg: blkg of interest
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 333885133b1f..b356d4eed08d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -559,63 +559,6 @@ static inline void blkcg_bio_issue_init(struct bio *bio)
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 }
 
-static inline bool blkcg_bio_issue_check(struct request_queue *q,
-					 struct bio *bio)
-{
-	struct blkcg_gq *blkg;
-	bool throtl = false;
-
-	rcu_read_lock();
-
-	if (!bio->bi_blkg) {
-		char b[BDEVNAME_SIZE];
-
-		WARN_ONCE(1,
-			  "no blkg associated for bio on block-device: %s\n",
-			  bio_devname(bio, b));
-		bio_associate_blkg(bio);
-	}
-
-	blkg = bio->bi_blkg;
-
-	throtl = blk_throtl_bio(q, blkg, bio);
-
-	if (!throtl) {
-		struct blkg_iostat_set *bis;
-		int rwd, cpu;
-
-		if (op_is_discard(bio->bi_opf))
-			rwd = BLKG_IOSTAT_DISCARD;
-		else if (op_is_write(bio->bi_opf))
-			rwd = BLKG_IOSTAT_WRITE;
-		else
-			rwd = BLKG_IOSTAT_READ;
-
-		cpu = get_cpu();
-		bis = per_cpu_ptr(blkg->iostat_cpu, cpu);
-		u64_stats_update_begin(&bis->sync);
-
-		/*
-		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this
-		 * is a split bio and we would have already accounted for the
-		 * size of the bio.
-		 */
-		if (!bio_flagged(bio, BIO_QUEUE_ENTERED))
-			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
-		bis->cur.ios[rwd]++;
-
-		u64_stats_update_end(&bis->sync);
-		if (cgroup_subsys_on_dfl(io_cgrp_subsys))
-			cgroup_rstat_updated(blkg->blkcg->css.cgroup, cpu);
-		put_cpu();
-	}
-
-	blkcg_bio_issue_init(bio);
-
-	rcu_read_unlock();
-	return !throtl;
-}
-
 static inline void blkcg_use_delay(struct blkcg_gq *blkg)
 {
 	if (atomic_add_return(1, &blkg->use_delay) == 1)
@@ -666,6 +609,7 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 	}
 }
 
+bool blkcg_bio_issue_check(struct request_queue *q, struct bio *bio);
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
 void blkcg_maybe_throttle_current(void);
-- 
2.24.1

