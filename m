Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAEECA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA4A206B8
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bjl0ox4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbgEMKtp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgEMKtp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 06:49:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686B4C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 03:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CJm/YlJ6+YP4lPh+XX+4bVmk9tof6oBHlE7qlRl2THs=; b=bjl0ox4wHxQSRMaQzG45jU1XjY
        kyZJKnU7XfOwdb2sZtPVkxluEidrk+JFBrmlo6l9OtDSDy5uNuwmG0v7oHqxuyR9iCwQZRHhAy/2+
        hCHYHoOhYD7Uwe1adKZF/DnLwJdDx6kCepaMAYGcMgofGf1TQhQN6WEYq6T8kzVIBIx2iLvM+8bfl
        G0gNZ638RZrgegNHSSWjumEjag9aNkB4330tsufyHhHfR8dNEcTC57Vhw0bd5Ajs1DGhqRviOO1be
        nSQwLZjb1qbXiBEZNJNBZFEi6jiLzt4r/hwJkqcwz19ys4ljP0mWxRA7+ESu7I5FFvf29qlYGuSVg
        DjRyN48g==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoxM-0005cR-Tr; Wed, 13 May 2020 10:49:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/4] block: don't call part_{inc,dec}_in_flight for blk-mq devices
Date:   Wed, 13 May 2020 12:49:34 +0200
Message-Id: <20200513104935.2338779-4-hch@lst.de>
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

part_inc_in_flight and part_dec_in_flight are no-ops for blk-mq queues,
so remove the calls in purely blk-mq callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c  | 21 +++++----------------
 block/blk-merge.c |  2 --
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fe73e816dae36..c22d3148a146e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1392,7 +1392,6 @@ void blk_account_io_done(struct request *req, u64 now)
 		update_io_ticks(part, jiffies, true);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
-		part_dec_in_flight(req->q, part, rq_data_dir(req));
 
 		hd_struct_put(part);
 		part_stat_unlock();
@@ -1401,25 +1400,15 @@ void blk_account_io_done(struct request *req, u64 now)
 
 void blk_account_io_start(struct request *rq, bool new_io)
 {
-	struct hd_struct *part;
-	int rw = rq_data_dir(rq);
-
 	if (!blk_do_io_stat(rq))
 		return;
 
 	part_stat_lock();
-
-	if (!new_io) {
-		part = rq->part;
-		part_stat_inc(part, merges[rw]);
-	} else {
-		part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
-		part_inc_in_flight(rq->q, part, rw);
-		rq->part = part;
-	}
-
-	update_io_ticks(part, jiffies, false);
-
+	if (!new_io)
+		part_stat_inc(rq->part, merges[rq_data_dir(rq)]);
+	else
+		rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
+	update_io_ticks(rq->part, jiffies, false);
 	part_stat_unlock();
 }
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index a04e991b5ded9..7588523106708 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -670,8 +670,6 @@ static void blk_account_io_merge(struct request *req)
 		part_stat_lock();
 		part = req->part;
 
-		part_dec_in_flight(req->q, part, rq_data_dir(req));
-
 		hd_struct_put(part);
 		part_stat_unlock();
 	}
-- 
2.26.2

