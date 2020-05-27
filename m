Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC377C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 05:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA113207ED
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 05:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sI1L1kUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgE0FZP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 01:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgE0FZL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 01:25:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A707C061A0F;
        Tue, 26 May 2020 22:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1Ebl3DKp/tyRvnVEw2r5k4+wt6t2CIu1LhAwR5zP94s=; b=sI1L1kUCVsKPT3PJDiwWVR//KL
        jpR+grwUgE85PGxX9y/CxdzT08cfmmLLkpwY5YlQ1IiRxtcz131I/RxckdEudatS8oOdk1rK5jDh1
        4N1XRMES+pKUaE+FgT7VIoPDChsaXTQvq1fCfGM2iD5Apq7tcTUv9Qa8IenWs7dVYDcZgx/But2TH
        g0EHNNrdoYUfnXT7xVC8/gwbhF9aV68JEdtrKApVj8FIWF4l+omJrx+sKsgCmU7cLPh0KyJHs8jyZ
        vqoGzcdPSCpAIt5QuUGzIdQ+uMPXaKkO+ABgHPQIOmgcT81JGpFCMOxkWY++OObYkDqijGF3goPbQ
        qw9YdcQg==;
Received: from [2001:4bb8:18c:5da7:8164:affc:3c20:853d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdoYt-0001mp-Fh; Wed, 27 May 2020 05:25:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] block: reduce part_stat_lock() scope
Date:   Wed, 27 May 2020 07:24:19 +0200
Message-Id: <20200527052419.403583-17-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527052419.403583-1-hch@lst.de>
References: <20200527052419.403583-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We only need the stats lock (aka preempt_disable()) for updating the
states, not for looking up or dropping the hd_struct reference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/blk-core.c  | 5 +++--
 block/blk-merge.c | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bf2f7d4bc0c1c..a01fb2b508f0e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1437,9 +1437,9 @@ void blk_account_io_done(struct request *req, u64 now)
 		update_io_ticks(part, jiffies, true);
 		part_stat_inc(part, ios[sgrp]);
 		part_stat_add(part, nsecs[sgrp], now - req->start_time_ns);
+		part_stat_unlock();
 
 		hd_struct_put(part);
-		part_stat_unlock();
 	}
 }
 
@@ -1448,8 +1448,9 @@ void blk_account_io_start(struct request *rq)
 	if (!blk_do_io_stat(rq))
 		return;
 
-	part_stat_lock();
 	rq->part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
+
+	part_stat_lock();
 	update_io_ticks(rq->part, jiffies, false);
 	part_stat_unlock();
 }
diff --git a/block/blk-merge.c b/block/blk-merge.c
index c3beae5c1be71..f0b0bae075a0c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -674,8 +674,9 @@ static void blk_account_io_merge_request(struct request *req)
 	if (blk_do_io_stat(req)) {
 		part_stat_lock();
 		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
-		hd_struct_put(req->part);
 		part_stat_unlock();
+
+		hd_struct_put(req->part);
 	}
 }
 
-- 
2.26.2

