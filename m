Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16BCC433DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 05:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6426820679
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 05:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hVBVtem+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgFCFOs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFCFOs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 01:14:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C504C05BD43
        for <linux-block@vger.kernel.org>; Tue,  2 Jun 2020 22:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=UL+ZcTKrQX8cDo7/dhkfmyIruGwthE9GAeeToAR+I0I=; b=hVBVtem+fNB69SvvXpO7WEH2Nh
        Dj2kV8xeR1ANstdywQPNklDdsj63Gu0PsRX/r8t2WGf6gCyrG4kPSmXXjvCOAjYiWOtoccIHpiWxt
        2rGSSd+F869Ya0q8GMVxZgu71hQMAXwB9RLb3gnihX4EXnT8iDdTZpkXr/urn+ST0eEWgdpz33bMB
        C3mBhye6WJ4Ja4hXueiJoo+cXEwqO2oTh0QFingCV7q9u0euflz09Gvpktxk98WRG5Ot43EsMbBvm
        MYys9G17mRIDu1l8Hjcp+FrftRh0Rm2iJQ7otNpVVCahdE2+hIOPvi5X14Z0mvAXOwU4hkkGhiYto
        TaEEyrHQ==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgLji-0004AN-40; Wed, 03 Jun 2020 05:14:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hare@suse.com
Subject: [PATCH] block: remove the error argument to the block_bio_complete tracepoint
Date:   Wed,  3 Jun 2020 07:14:43 +0200
Message-Id: <20200603051443.579748-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The status can be trivially derived from the bio itself.  That also avoid
callers like NVMe to incorrectly pass a blk_status_t instead of the errno,
and the overhead of translating the blk_status_t to the errno in the I/O
completion fast path when no tracing is enabled.

Fixes: 35fe0d12c8a3 ("nvme: trace bio completion")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                  | 3 +--
 drivers/nvme/host/nvme.h     | 3 +--
 include/trace/events/block.h | 6 +++---
 kernel/trace/blktrace.c      | 6 +++---
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5235da6434aab..a7366c02c9b57 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1434,8 +1434,7 @@ void bio_endio(struct bio *bio)
 	}
 
 	if (bio->bi_disk && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
-		trace_block_bio_complete(bio->bi_disk->queue, bio,
-					 blk_status_to_errno(bio->bi_status));
+		trace_block_bio_complete(bio->bi_disk->queue, bio);
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
 	}
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fa5c75501049d..c0f4226d32992 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -599,8 +599,7 @@ static inline void nvme_trace_bio_complete(struct request *req,
 	struct nvme_ns *ns = req->q->queuedata;
 
 	if (req->cmd_flags & REQ_NVME_MPATH)
-		trace_block_bio_complete(ns->head->disk->queue,
-					 req->bio, status);
+		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 
 extern struct device_attribute dev_attr_ana_grpid;
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 81b43f5bdf237..1257f26bb887b 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -261,9 +261,9 @@ TRACE_EVENT(block_bio_bounce,
  */
 TRACE_EVENT(block_bio_complete,
 
-	TP_PROTO(struct request_queue *q, struct bio *bio, int error),
+	TP_PROTO(struct request_queue *q, struct bio *bio),
 
-	TP_ARGS(q, bio, error),
+	TP_ARGS(q, bio),
 
 	TP_STRUCT__entry(
 		__field( dev_t,		dev		)
@@ -277,7 +277,7 @@ TRACE_EVENT(block_bio_complete,
 		__entry->dev		= bio_dev(bio);
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
-		__entry->error		= error;
+		__entry->error		= blk_status_to_errno(bio->bi_status);
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 	),
 
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ea47f20840870..1e5499414cdf1 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -885,10 +885,10 @@ static void blk_add_trace_bio_bounce(void *ignore,
 }
 
 static void blk_add_trace_bio_complete(void *ignore,
-				       struct request_queue *q, struct bio *bio,
-				       int error)
+				       struct request_queue *q, struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_COMPLETE, error);
+	blk_add_trace_bio(q, bio, BLK_TA_COMPLETE,
+			  blk_status_to_errno(bio->bi_status));
 }
 
 static void blk_add_trace_bio_backmerge(void *ignore,
-- 
2.26.2

