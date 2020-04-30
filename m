Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4DAC47254
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0D52082E
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OIA7jp+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD3PEE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:04:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20784 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgD3PED (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 11:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588259043; x=1619795043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7nS6FlViSHcumKei79u9znQZZkzR2NNtzyPGkp843A4=;
  b=OIA7jp+OCfHQ9EvQXVhyZ3NMhbTUGXvS/lUAHVpVxF9+IL1+lugpUPlL
   NcStZFKoHF5KhGGc6YAALOaMDLSIVI5rls1etcN6BjFIHVWGo2eKkykFR
   F6S9NrEzVIzI4dCsPdfDJdlwMNvfrEVjuvh39jlDv/6IxIVHar2hM7fJb
   Xlu4Swa+V1TjMDhk20fruKojOklRbJrQOjS2kMHcD5zd6cd8QL088PHgW
   g+yPK0b/42VsEumq2L2PweXlCwK1LkbYK3Jlqj8XSvxV3dCOfQh87+gUc
   6cQwUoslMhUqcoLEqFX6+0JJHgvk1JIQlsdaHgRyWlmG0EwdV0jk2enfF
   A==;
IronPort-SDR: EA1SXK9rb5WVNC7trMHoXOM/elIh49PRaaq4NB2cfuRlX67wa8q487TjgzpabiBQtIQqWPNDah
 xLuEk66T1xMKqPya2qxD/lrEJ2pRcHJgcVvu3TkHto8pSj+i9NSgwHFTXmCQGSnPXQfHN/6zVo
 rRoZDSGzOTwNk/Kbn+KZaWJhPQbqdH43L2wIrte1BQScmRm3jWTcQDNMJ+awjpbgkntV+vknKn
 a4pas2u+tleRbhshLD/Wivxse1QukSOy7oA8OXJjXLCFxH8qG/R2oK5Aazb06Mgb0PsqTrN0xw
 Tf0=
X-IronPort-AV: E=Sophos;i="5.73,336,1583164800"; 
   d="scan'208";a="140916568"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 23:04:03 +0800
IronPort-SDR: GR9BQAIwowaDOsBv1l2Ne8l7U9JnQDGRbMP53AaRNld6ehtahv9t6zk9foueg4QkI19xDWqMiP
 9DtH7fSvwFkVctZ04ZDmzEwL0ynDQUv1s=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 07:54:06 -0700
IronPort-SDR: J3AwICK6z2iUXA0mGMC9t43WUn3LlaXpnPz6k/HjZGKE94JBkIZXoxcnRvOaQdPd51QRt5hr+h
 0cW+PK8lgzkA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2020 08:04:03 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/3] block: move blkcg_bio_issue_check out of line
Date:   Fri,  1 May 2020 00:03:55 +0900
Message-Id: <20200430150356.35691-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200430150356.35691-1-johannes.thumshirn@wdc.com>
References: <20200430150356.35691-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c         | 57 ++++++++++++++++++++++++++++++++++++
 include/linux/blk-cgroup.h | 60 +-------------------------------------
 2 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c5dc833212e1..88453cb866bb 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1706,6 +1706,63 @@ void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
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
+		 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a
+		 * split bio and we would have already accounted for the size of
+		 * the bio.
+		 */
+		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
+			bio_set_flag(bio, BIO_CGROUP_ACCT);
+			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
+		}
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
index a606767cdcc7..b356d4eed08d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -559,65 +559,6 @@ static inline void blkcg_bio_issue_init(struct bio *bio)
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
-		 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a
-		 * split bio and we would have already accounted for the size of
-		 * the bio.
-		 */
-		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
-			bio_set_flag(bio, BIO_CGROUP_ACCT);
-			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
-		}
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
@@ -668,6 +609,7 @@ static inline void blkcg_clear_delay(struct blkcg_gq *blkg)
 	}
 }
 
+bool blkcg_bio_issue_check(struct request_queue *q, struct bio *bio);
 void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta);
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
 void blkcg_maybe_throttle_current(void);
-- 
2.24.1

