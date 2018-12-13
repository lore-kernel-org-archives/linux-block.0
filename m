Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F5C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D461820811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JLMYXZac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D461820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeLMVeQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:34:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMVeP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 16:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9hWayTQWFQ/ZmZ27kswGw6fFBZ6/UOFObO+THWubYmk=; b=JLMYXZacOfs7vG4+8//lZadxs
        S2RkHK81czH1jNVet4AlQCqENExWl9IzTEuccYXQMR9B8d2A+q5a/mheiPa7ZsD+6KoVFK86G778W
        dbA2C2oPAxLmiRe/wPTRU0DW0pcMgGkr6lwcTvzAv5mmVNpAYFn2zgrTkKXcXfOJcRdywZxgdNSJh
        Hi79pkqu0VZBszggc2vcXt4lo/lzyGbX9OAkmZATs4aQz0s48cbtKMe++DHf6Qds4hvkouzryMVds
        R7wVeTNuNNVlXmsBJryh0TCB07bCEipu2hAK1eXbU5Mk6GP51q18QV+nEc0AaV7L/sJ+vQz8mXWiy
        4A6QwNF8g==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXYcY-0002ho-OV; Thu, 13 Dec 2018 21:34:14 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 2/6] block: make request_to_qc_t public
Date:   Thu, 13 Dec 2018 13:34:06 -0800
Message-Id: <20181213213410.9841-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213213410.9841-1-sagi@grimberg.me>
References: <20181213213410.9841-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block consumers will need it for polling requests that
are sent with blk_execute_rq_nowait. Also, get rid of
blk_tag_to_qc_t and open-code it instead.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq.c            |  8 --------
 include/linux/blk-mq.h    | 10 ++++++++++
 include/linux/blk_types.h | 11 -----------
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index eff52c33e434..fb4a09b096d5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1745,14 +1745,6 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
 	blk_account_io_start(rq, true);
 }
 
-static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
-{
-	if (rq->tag != -1)
-		return blk_tag_to_qc_t(rq->tag, hctx->queue_num, false);
-
-	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
-}
-
 static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 					    struct request *rq,
 					    blk_qc_t *cookie, bool last)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 57eda7b20243..2dd84feaf1ef 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -357,4 +357,14 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
 	     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
 
+static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx,
+		struct request *rq)
+{
+	if (rq->tag != -1)
+		return rq->tag | (hctx->queue_num << BLK_QC_T_SHIFT);
+
+	return rq->internal_tag | (hctx->queue_num << BLK_QC_T_SHIFT) |
+			BLK_QC_T_INTERNAL;
+}
+
 #endif
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 46c005d601ac..ee1ce9058302 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -424,17 +424,6 @@ static inline bool blk_qc_t_valid(blk_qc_t cookie)
 	return cookie != BLK_QC_T_NONE;
 }
 
-static inline blk_qc_t blk_tag_to_qc_t(unsigned int tag, unsigned int queue_num,
-				       bool internal)
-{
-	blk_qc_t ret = tag | (queue_num << BLK_QC_T_SHIFT);
-
-	if (internal)
-		ret |= BLK_QC_T_INTERNAL;
-
-	return ret;
-}
-
 static inline unsigned int blk_qc_t_to_queue_num(blk_qc_t cookie)
 {
 	return (cookie & ~BLK_QC_T_INTERNAL) >> BLK_QC_T_SHIFT;
-- 
2.17.1

