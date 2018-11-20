Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFF5C43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9378E2080C
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SroPo51z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9378E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbeKTMT0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:19:26 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40409 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbeKTMT0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 07:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542678769; x=1574214769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vuBdbepM0Yy0VdI3VUb8R1S5fsJ4V8LQf3FXWW4S2LI=;
  b=SroPo51zcw3cZ9BXtDcy8QL3asY6Z7E6C6bWFwBV1Gs3uFItKUjKo4CG
   y2VlBYyw665iqB0g9CQBQPbbtLZKSTXNP+NKnP1zvYIOSFEwVfnN4Rw7w
   VSbu+Qe/GmZxUHLz++TZmSWfUpmCpC2/tqV66QjLQX5ErfJKQHCIRt5oD
   Va4mnGZqaXcG/EmxqG2AzkPwNcfuRYAu+DIANV8pz0y4YLOZEPJxcE/mi
   srqjI9XGdFGCh2bMPryu78YQd5wU1wGBKQNNHxqg1qmBlUWpl2vSKPTLA
   HUJktxlr5P4rFxQ84yrVoxfv0gluBO+68I+NvxLiGMaE8SR2Tq91TWwfH
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,255,1539619200"; 
   d="scan'208";a="95813269"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 09:52:49 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Nov 2018 17:36:04 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2018 17:52:47 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/6] block: Introduce get_current_ioprio()
Date:   Tue, 20 Nov 2018 10:52:35 +0900
Message-Id: <20181120015238.26467-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120015238.26467-1-damien.lemoal@wdc.com>
References: <20181120015238.26467-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define get_current_ioprio() as an inline helper to obtain the caller
I/O priority from its task I/O context. Use this helper in
blk_init_request_from_bio() to set a request ioprio.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-core.c       |  6 +-----
 include/linux/ioprio.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 492648c96992..4450d3c08f25 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -813,18 +813,14 @@ unsigned int blk_plug_queued_count(struct request_queue *q)
 
 void blk_init_request_from_bio(struct request *req, struct bio *bio)
 {
-	struct io_context *ioc = current->io_context;
-
 	if (bio->bi_opf & REQ_RAHEAD)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
 
 	req->__sector = bio->bi_iter.bi_sector;
 	if (ioprio_valid(bio_prio(bio)))
 		req->ioprio = bio_prio(bio);
-	else if (ioc)
-		req->ioprio = ioc->ioprio;
 	else
-		req->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+		req->ioprio = get_current_ioprio();
 	req->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(req->q, req, bio);
 }
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 9e30ed6443db..e9bfe6972aed 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -70,6 +70,19 @@ static inline int task_nice_ioclass(struct task_struct *task)
 		return IOPRIO_CLASS_BE;
 }
 
+/*
+ * If the calling process has set an I/O priority, use that. Otherwise, return
+ * the default I/O priority.
+ */
+static inline int get_current_ioprio(void)
+{
+	struct io_context *ioc = current->io_context;
+
+	if (ioc)
+		return ioc->ioprio;
+	return IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+}
+
 /*
  * For inheritance, return the highest of the two given priorities
  */
-- 
2.19.1

