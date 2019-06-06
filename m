Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A998C28EB4
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 10:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F410920657
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 10:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="epcnQz60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfFFK3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:29:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfFFK3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jun 2019 06:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m3Rw5M/iV5LDma0YZV7iOwpcybeY1et62aUt2BePKzA=; b=epcnQz60DfYslR7kuB1cSdjLVS
        QH5qTBCvKB2YQC1nm69G0OkLkjy4GKReiZCkJWXE1BfYYFwvBcOZCMfqXjw6lqF3nF/tu++eVZk3z
        h5LRCIk60rHimfRyeku7jh+jjkZ0yDyLj0+0W+nPALLCd7pT4mjncwUcnmUw+/4y/7SLXw05VROTm
        fRqgB27uZ6JzEji2zCahiJKG15c3CmrTTG1eCTHgWxdqzToobF5FEvNqUpc6NxPy0BGDKxLbxJAOp
        i8v4uHbP2pVzvue3syZSLwef3IS9vycPoHoqV6g6X0VlRxGQmyKaHKK0lyBD1MQUoaTp9VbES5xWZ
        O9rwWYwg==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpdy-0008Tq-3L; Thu, 06 Jun 2019 10:29:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Subject: [PATCH 2/6] block: remove blk_init_request_from_bio
Date:   Thu,  6 Jun 2019 12:29:00 +0200
Message-Id: <20190606102904.4024-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606102904.4024-1-hch@lst.de>
References: <20190606102904.4024-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

lightnvm should have never used this function, as it is sending
passthrough requests, so switch it to blk_rq_append_bio like all the
other passthrough request users.  Inline blk_init_request_from_bio into
the only remaining caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c             | 11 -----------
 block/blk-mq.c               |  7 ++++++-
 drivers/nvme/host/lightnvm.c |  2 +-
 include/linux/blkdev.h       |  1 -
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9b88b1a3eb43..a9cb465c7ef7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -674,17 +674,6 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	return false;
 }
 
-void blk_init_request_from_bio(struct request *req, struct bio *bio)
-{
-	if (bio->bi_opf & REQ_RAHEAD)
-		req->cmd_flags |= REQ_FAILFAST_MASK;
-
-	req->__sector = bio->bi_iter.bi_sector;
-	req->write_hint = bio->bi_write_hint;
-	blk_rq_bio_prep(req->q, req, bio);
-}
-EXPORT_SYMBOL_GPL(blk_init_request_from_bio);
-
 static void handle_bad_sector(struct bio *bio, sector_t maxsector)
 {
 	char b[BDEVNAME_SIZE];
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ce0f5f4ede70..61457bffa55f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1766,7 +1766,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 
 static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
 {
-	blk_init_request_from_bio(rq, bio);
+	if (bio->bi_opf & REQ_RAHEAD)
+		rq->cmd_flags |= REQ_FAILFAST_MASK;
+
+	rq->__sector = bio->bi_iter.bi_sector;
+	rq->write_hint = bio->bi_write_hint;
+	blk_rq_bio_prep(rq->q, rq, bio);
 
 	blk_account_io_start(rq, true);
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 4f20a10b39d3..ba009d4c9dfa 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -660,7 +660,7 @@ static struct request *nvme_nvm_alloc_request(struct request_queue *q,
 	rq->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 
 	if (rqd->bio)
-		blk_init_request_from_bio(rq, rqd->bio);
+		blk_rq_append_bio(rq, &rqd->bio);
 	else
 		rq->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 592669bcc536..c67a9510e532 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -828,7 +828,6 @@ extern void blk_unregister_queue(struct gendisk *disk);
 extern blk_qc_t generic_make_request(struct bio *bio);
 extern blk_qc_t direct_make_request(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
-extern void blk_init_request_from_bio(struct request *req, struct bio *bio);
 extern void blk_put_request(struct request *);
 extern struct request *blk_get_request(struct request_queue *, unsigned int op,
 				       blk_mq_req_flags_t flags);
-- 
2.20.1

