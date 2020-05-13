Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDED5CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22E2206B8
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YOgpmTpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbgEMKts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgEMKts (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 06:49:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DE4C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 03:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=F/NH/9q61yuZ9adaN7QZtKXqXhtxRs14Y+v+M24HUi4=; b=YOgpmTpBxsblNtKqpp7RX8+/8M
        l0FXFPBGToxGckJ79ruyLYXhEU4cgaHwbbSo93h3nCdwlUTpLsVF1VszfIyUEkz1ZYecZ7EacKhtV
        p4uG2mo4j/IOrQ8bOLMeVqyC5/DBDQ2nP4qkIElURwi1NyHYKyymtwdCi248GqizHVThbKfRJ2O2i
        CqcoQuacML4u3WbSwechfq7ebcL2vXKI4RDOjxmEgf6KVdlzoOahN3etiP5ej5n0j+1GZiPTyX77r
        KDfPXpMoNlFR4s6zynuHAM1zv2uNsFvGBPghV5OLt+iEioXzdcQ14uoSAtujmOD6lkJKe7YCXUCdT
        Pgx36idA==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoxP-0005cm-EP; Wed, 13 May 2020 10:49:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: merge part_{inc,dev}_in_flight into their only callers
Date:   Wed, 13 May 2020 12:49:35 +0200
Message-Id: <20200513104935.2338779-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513104935.2338779-1-hch@lst.de>
References: <20200513104935.2338779-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

part_inc_in_flight and part_dec_in_flight only have one caller each, and
those callers are purely for bio based drivers.  Merge each function into
the only caller, and remove the superflous blk-mq checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c   | 10 ++++++++--
 block/blk.h   |  4 ----
 block/genhd.c | 20 --------------------
 3 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e4c46e2bd5ba5..1d93d74bf7f30 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1390,13 +1390,16 @@ void generic_start_io_acct(struct request_queue *q, int op,
 			   unsigned long sectors, struct hd_struct *part)
 {
 	const int sgrp = op_stat_group(op);
+	int rw = op_is_write(op);
 
 	part_stat_lock();
 
 	update_io_ticks(part, jiffies, false);
 	part_stat_inc(part, ios[sgrp]);
 	part_stat_add(part, sectors[sgrp], sectors);
-	part_inc_in_flight(q, part, op_is_write(op));
+	part_stat_local_inc(part, in_flight[rw]);
+	if (part->partno)
+		part_stat_local_inc(&part_to_disk(part)->part0, in_flight[rw]);
 
 	part_stat_unlock();
 }
@@ -1408,12 +1411,15 @@ void generic_end_io_acct(struct request_queue *q, int req_op,
 	unsigned long now = jiffies;
 	unsigned long duration = now - start_time;
 	const int sgrp = op_stat_group(req_op);
+	int rw = op_is_write(req_op);
 
 	part_stat_lock();
 
 	update_io_ticks(part, now, true);
 	part_stat_add(part, nsecs[sgrp], jiffies_to_nsecs(duration));
-	part_dec_in_flight(q, part, op_is_write(req_op));
+	part_stat_local_dec(part, in_flight[rw]);
+	if (part->partno)
+		part_stat_local_dec(&part_to_disk(part)->part0, in_flight[rw]);
 
 	part_stat_unlock();
 }
diff --git a/block/blk.h b/block/blk.h
index a813c573a48d5..7fe3d6ed22356 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -354,10 +354,6 @@ void blk_queue_free_zone_bitmaps(struct request_queue *q);
 static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
 #endif
 
-void part_dec_in_flight(struct request_queue *q, struct hd_struct *part,
-			int rw);
-void part_inc_in_flight(struct request_queue *q, struct hd_struct *part,
-			int rw);
 void update_io_ticks(struct hd_struct *part, unsigned long now, bool end);
 struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
 
diff --git a/block/genhd.c b/block/genhd.c
index 56e0560738c49..094ed90964964 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -119,26 +119,6 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 }
 #endif /* CONFIG_SMP */
 
-void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
-{
-	if (queue_is_mq(q))
-		return;
-
-	part_stat_local_inc(part, in_flight[rw]);
-	if (part->partno)
-		part_stat_local_inc(&part_to_disk(part)->part0, in_flight[rw]);
-}
-
-void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
-{
-	if (queue_is_mq(q))
-		return;
-
-	part_stat_local_dec(part, in_flight[rw]);
-	if (part->partno)
-		part_stat_local_dec(&part_to_disk(part)->part0, in_flight[rw]);
-}
-
 static unsigned int part_in_flight(struct request_queue *q,
 		struct hd_struct *part)
 {
-- 
2.26.2

