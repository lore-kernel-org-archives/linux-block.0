Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA2C04AB1
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2647620879
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 06:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tCkswAlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfEMGiy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 02:38:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfEMGiy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 02:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2z5ifdjK8OavhOyzD7FuJciQC5qugfi1KRTeW53Bkqo=; b=tCkswAlfFCeVatG2PHN1GEA1wN
        HPtNGmISaVYfmxH4Kic+I0Vnvl560tlflhW73owFiRe33zIG0D/6R7DxDl3k0jwI4vQTwESIo5i64
        UYmQCVb8ZD/JEO5NFsDTxK5vK2K5xsQcx5lXDonGKzflHam/8BcWENEUJn3W/vlRbgylzR2hEh/tz
        ts4EsrrCUHrzBkO3SPSga8czkcqfV+hbn6F4whEAwwfm1KBOPhJDZNvPQq1DQN6bhsZn4iGAXLzAQ
        3+x28mi+NsMdBu2LBD6g98SPgsd6WvpNFdNYnj9cMOpGReDQJYp7GNpRdmIwl7MNTabukUuWxZrM9
        ign9/gHQ==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ4bs-0007QL-GV; Mon, 13 May 2019 06:38:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: [PATCH 06/10] block: remove blk_init_request_from_bio
Date:   Mon, 13 May 2019 08:37:50 +0200
Message-Id: <20190513063754.1520-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513063754.1520-1-hch@lst.de>
References: <20190513063754.1520-1-hch@lst.de>
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
index 7fb394dd3e11..b46ea531cb07 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -710,17 +710,6 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
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
index 08a6248d8536..c0e5132d9103 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1765,7 +1765,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 
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
index 949e29e1d782..6cc050894d3a 100644
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
index 1aafeb923e7b..05bc85cdbc25 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -823,7 +823,6 @@ extern void blk_unregister_queue(struct gendisk *disk);
 extern blk_qc_t generic_make_request(struct bio *bio);
 extern blk_qc_t direct_make_request(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
-extern void blk_init_request_from_bio(struct request *req, struct bio *bio);
 extern void blk_put_request(struct request *);
 extern struct request *blk_get_request(struct request_queue *, unsigned int op,
 				       blk_mq_req_flags_t flags);
-- 
2.20.1

