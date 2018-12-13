Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF06CC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7558220851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y+4j312K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7558220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeLMUcW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:32:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeLMUcV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rFwEksawrS4vimAdcZEpD717UbwJqIi/0IsOoqDJK2E=; b=Y+4j312KHxSGY/kzczG7yMi1hY
        8AqlOizxSO0c8yJ+nOpoiqJCR+ArG5Rd/tLdXjL4y+6y0sKviVEqvLjqNqXo7l6rIQlksbIcPrLRt
        toG6AF2jdz8JBpgvJJrLvUyUqQv+9J3cBxabg/TtphGOdmXBn6b3vyhKwjnaXXyfdraCxMwFWbAN3
        hDgcJhDJv6SNeF4NpJ4E+AtYJFrP1dMhDSjcoVcBoivYX4Ym1N6ysmcE4QDt2sjXvhu4Mpu7S1tdb
        t0aIJ2tS0aeVW25LDfQDh+3Bll9Yrqt0D0jgmXbB1SGetL+2pjuPLIB/Yw31hWcqbvnqYo8trdQmI
        qQ0NVgPA==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXXef-0005s6-5R; Thu, 13 Dec 2018 20:32:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/7] block: remove bio_set_prio and bio_prio
Date:   Thu, 13 Dec 2018 21:32:08 +0100
Message-Id: <20181213203214.10650-2-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213203214.10650-1-hch@lst.de>
References: <20181213203214.10650-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no good reason to not just use the fields directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c              | 2 +-
 block/blk-merge.c             | 2 +-
 drivers/md/bcache/movinggc.c  | 2 +-
 drivers/md/bcache/writeback.c | 2 +-
 include/linux/bio.h           | 3 ---
 5 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 268d2b8e9843..34619001a5dd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -734,7 +734,7 @@ void blk_init_request_from_bio(struct request *req, struct bio *bio)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
 
 	req->__sector = bio->bi_iter.bi_sector;
-	req->ioprio = bio_prio(bio);
+	req->ioprio = bio->bi_ioprio;
 	req->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(req->q, req, bio);
 }
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 9da5629d0887..09591daf4993 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -882,7 +882,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (rq->write_hint != bio->bi_write_hint)
 		return false;
 
-	if (rq->ioprio != bio_prio(bio))
+	if (rq->ioprio != bio->bi_ioprio)
 		return false;
 
 	return true;
diff --git a/drivers/md/bcache/movinggc.c b/drivers/md/bcache/movinggc.c
index 7891fb512736..3bc85277e284 100644
--- a/drivers/md/bcache/movinggc.c
+++ b/drivers/md/bcache/movinggc.c
@@ -82,7 +82,7 @@ static void moving_init(struct moving_io *io)
 	bio_init(bio, bio->bi_inline_vecs,
 		 DIV_ROUND_UP(KEY_SIZE(&io->w->key), PAGE_SECTORS));
 	bio_get(bio);
-	bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
+	bio->bi_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0);
 
 	bio->bi_iter.bi_size	= KEY_SIZE(&io->w->key) << 9;
 	bio->bi_private		= &io->cl;
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 73f0efac2b9f..09620652c786 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -250,7 +250,7 @@ static void dirty_init(struct keybuf_key *w)
 	bio_init(bio, bio->bi_inline_vecs,
 		 DIV_ROUND_UP(KEY_SIZE(&w->key), PAGE_SECTORS));
 	if (!io->dc->writeback_percent)
-		bio_set_prio(bio, IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
+		bio->bi_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0);
 
 	bio->bi_iter.bi_size	= KEY_SIZE(&w->key) << 9;
 	bio->bi_private		= w;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7380b094dcca..261b15483c69 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -44,9 +44,6 @@
 #define BIO_MAX_PAGES		256
 #endif
 
-#define bio_prio(bio)			(bio)->bi_ioprio
-#define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
-
 #define bio_iter_iovec(bio, iter)				\
 	bvec_iter_bvec((bio)->bi_io_vec, (iter))
 
-- 
2.19.2

