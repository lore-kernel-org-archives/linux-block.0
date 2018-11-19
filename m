Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0D8C43610
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC9320823
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EKOKAZJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC9320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeKSOOS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:14:18 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62743 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbeKSOOR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 09:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542599520; x=1574135520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gxw4QXlXWHHW6qd8AwCOFH6CaAG1U3Df7ye+7Qiwl/E=;
  b=EKOKAZJR2fs3D+cq0u5omemTAovkz2KSJJpiqlXWFGGjTEAqdb4CtKgs
   I/DB3Le80ml3kRgMocWVhXx5wD9oEgihuqB+8MfPwe2ABiUJaT1yZAdDy
   sGAStYliQ3gJZJBXeuY5fggPno1qp6nfzb/MbbLDXdI0c2YuHdqFcWSJZ
   b6je00aIWZzKfXy2YikPcwPF83863mWORgVod0JW5bnCp06tP6RcOaMDv
   N3OqYt4cPsTvOpG3WDOGxWnhALmATVPNL6ul5YAw5GfrB8oVHTMCuCbSm
   iDr4l+YySa/FhY2LBAFCvS8NZ47z1M9i4BSio1Ukr8mLw4OCoqTu6sRtp
   g==;
X-IronPort-AV: E=Sophos;i="5.56,250,1539619200"; 
   d="scan'208";a="96272466"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2018 11:51:49 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 18 Nov 2018 19:34:48 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2018 19:51:48 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] block: prevent merging of requests with different priorities
Date:   Mon, 19 Nov 2018 12:51:30 +0900
Message-Id: <20181119035131.11255-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119035131.11255-1-damien.lemoal@wdc.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
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
 block/blk-core.c  |  3 ---
 block/blk-merge.c | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

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
index b1df622cbd85..129f554d250d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -752,6 +752,12 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req->write_hint != next->write_hint)
 		return NULL;
 
+	/*
+	 * Don't allow merge of different I/O priorities.
+	 */
+	if (req->ioprio != next->ioprio)
+		return NULL;
+
 	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
@@ -807,8 +813,6 @@ static struct request *attempt_merge(struct request_queue *q,
 	 */
 	blk_account_io_merge(next);
 
-	req->ioprio = ioprio_best(req->ioprio, next->ioprio);
-
 	/*
 	 * ownership of bio passed from next to req, return 'next' for
 	 * the caller to free
@@ -883,6 +887,12 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (rq->write_hint != bio->bi_write_hint)
 		return false;
 
+	/*
+	 * Don't allow merge of different I/O priorities.
+	 */
+	if (rq->ioprio != bio_prio(bio))
+		return false;
+
 	return true;
 }
 
-- 
2.19.1

