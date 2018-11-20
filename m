Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CB3C43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5A02080C
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aFcAAINq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5A02080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbeKTMTb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:19:31 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40409 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbeKTMTb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 07:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542678774; x=1574214774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vWI5hiLR1Vd86YclP29pJ4JZOvyQnFq+3CxVZMtcm9I=;
  b=aFcAAINqumMST8C/o3iE6ZYwRbvIDzpHJbbbTYnaMUC1Z+D5h/YVd7Jd
   TZyTz9F0ehhI0Bs516CU/DoMYNCUPH4+NGfMB2s7RivxMtw5WXMDsFakQ
   QFTHDPNgE9lLHnqN1voCzen5q1Kut3TkgM/7SVp2qgdYTPWdVLbeSzmaj
   wMb236/xMNT1uzqC9VkpM+Xl9iPs6Vndv+Pf67zpNBpyKeMG0t+yHKSEC
   76qidQVvrwN2xR7pZenjfIM8pTN14uKGEqA61Oai1nrBX96kFIz7gL2+Y
   Xhtf6lCw5RLX6D4XHc2EUrSPMFHKuhpBRsWIP4lwzhzQxWlM3zXGjh2JU
   g==;
X-IronPort-AV: E=Sophos;i="5.56,255,1539619200"; 
   d="scan'208";a="95813294"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 09:52:54 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Nov 2018 17:36:09 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2018 17:52:52 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/6] block: prevent merging of requests with different priorities
Date:   Tue, 20 Nov 2018 10:52:37 +0900
Message-Id: <20181120015238.26467-6-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120015238.26467-1-damien.lemoal@wdc.com>
References: <20181120015238.26467-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Growing in size a high priority request by merging it with a lower
priority BIO or request will increase the request execution time. This
is the opposite result of the desired effect of high I/O priorities,
namely getting low I/O latencies. Prevent merging of requests and BIOs
that have different I/O priorities to fix this.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-core.c  | 3 ---
 block/blk-merge.c | 8 ++++++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4450d3c08f25..dde30b08aa14 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -662,7 +662,6 @@ bool bio_attempt_back_merge(struct request_queue *q, struct request *req,
 	req->biotail->bi_next = bio;
 	req->biotail = bio;
 	req->__data_len += bio->bi_iter.bi_size;
-	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
 
 	blk_account_io_start(req, false);
 	return true;
@@ -686,7 +685,6 @@ bool bio_attempt_front_merge(struct request_queue *q, struct request *req,
 
 	req->__sector = bio->bi_iter.bi_sector;
 	req->__data_len += bio->bi_iter.bi_size;
-	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
 
 	blk_account_io_start(req, false);
 	return true;
@@ -706,7 +704,6 @@ bool bio_attempt_discard_merge(struct request_queue *q, struct request *req,
 	req->biotail->bi_next = bio;
 	req->biotail = bio;
 	req->__data_len += bio->bi_iter.bi_size;
-	req->ioprio = ioprio_best(req->ioprio, bio_prio(bio));
 	req->nr_phys_segments = segments + 1;
 
 	blk_account_io_start(req, false);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index b1df622cbd85..6be04ef8da5b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -752,6 +752,9 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req->write_hint != next->write_hint)
 		return NULL;
 
+	if (req->ioprio != next->ioprio)
+		return NULL;
+
 	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
@@ -807,8 +810,6 @@ static struct request *attempt_merge(struct request_queue *q,
 	 */
 	blk_account_io_merge(next);
 
-	req->ioprio = ioprio_best(req->ioprio, next->ioprio);
-
 	/*
 	 * ownership of bio passed from next to req, return 'next' for
 	 * the caller to free
@@ -883,6 +884,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (rq->write_hint != bio->bi_write_hint)
 		return false;
 
+	if (rq->ioprio != bio_prio(bio))
+		return false;
+
 	return true;
 }
 
-- 
2.19.1

