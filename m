Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438ADC282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C4B20869
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GcbR0lUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfBAH4f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:56:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfBAH4e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 02:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QTk8yy6Tq85np+klWEpAX5EzkU34M4EWaZkZQuGSmxs=; b=GcbR0lUtqEVlH6lTFZjvsQkO2t
        nFdNvm/ycGYFzs5+dS0xowuSf+PoHbD13mYe4VCbP3wWIBAOydrkyiuJ25+P/NW5CMxqze9BqqL8+
        xtpciXdigZZtf1904Rl0ldl6NevuzzN0YTsgRWbijna9PJJfBjvTewtrjSKljOpQJ1IT9ybzQ0ls/
        3IrqzD58HRa99GWLLScGSECos9ahOEsTHSoReX1i1BstQj6p4LfD1eUTh7AqS1EnSzfwpTAl3RlRk
        BX2HjjfolvVsyipUAoii6DckoIxJ40TmU/RQB+LwcPE6AHRvZ41TsAUuGXAIPb6QqK6XTM0k0q6aM
        /iIxKvug==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpTgb-0005sr-NB; Fri, 01 Feb 2019 07:56:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] block: remove bidi support
Date:   Fri,  1 Feb 2019 08:55:57 +0100
Message-Id: <20190201075557.9249-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201075557.9249-1-hch@lst.de>
References: <20190201075557.9249-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unused now, and another field in struct request bites the dust.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c | 1 -
 block/blk-mq.c         | 3 ---
 include/linux/blkdev.h | 6 ------
 3 files changed, 10 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 90d68760af08..ac832547160a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -115,7 +115,6 @@ static int queue_pm_only_show(void *data, struct seq_file *m)
 static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(STOPPED),
 	QUEUE_FLAG_NAME(DYING),
-	QUEUE_FLAG_NAME(BIDI),
 	QUEUE_FLAG_NAME(NOMERGES),
 	QUEUE_FLAG_NAME(SAME_COMP),
 	QUEUE_FLAG_NAME(FAIL_IO),
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 502cbf964a3b..820d131a6893 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -339,7 +339,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
-	rq->next_rq = NULL;
 
 	data->ctx->rq_dispatched[op_is_sync(op)]++;
 	refcount_set(&rq->ref, 1);
@@ -549,8 +548,6 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 		rq_qos_done(rq->q, rq);
 		rq->end_io(rq, error);
 	} else {
-		if (unlikely(blk_bidi_rq(rq)))
-			blk_mq_free_request(rq->next_rq);
 		blk_mq_free_request(rq);
 	}
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fd1450d53f1c..21beb456b97a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -234,9 +234,6 @@ struct request {
 	 */
 	rq_end_io_fn *end_io;
 	void *end_io_data;
-
-	/* for bidi */
-	struct request *next_rq;
 };
 
 static inline bool blk_op_is_scsi(unsigned int op)
@@ -572,7 +569,6 @@ struct request_queue {
 
 #define QUEUE_FLAG_STOPPED	1	/* queue is stopped */
 #define QUEUE_FLAG_DYING	2	/* queue being torn down */
-#define QUEUE_FLAG_BIDI		4	/* queue supports bidi requests */
 #define QUEUE_FLAG_NOMERGES     5	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	6	/* complete on same CPU-group */
 #define QUEUE_FLAG_FAIL_IO	7	/* fake timeout */
@@ -644,8 +640,6 @@ static inline bool blk_account_rq(struct request *rq)
 	return (rq->rq_flags & RQF_STARTED) && !blk_rq_is_passthrough(rq);
 }
 
-#define blk_bidi_rq(rq)		((rq)->next_rq != NULL)
-
 #define list_entry_rq(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define rq_data_dir(rq)		(op_is_write(req_op(rq)) ? WRITE : READ)
-- 
2.20.1

