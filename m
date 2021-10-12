Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A74C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E956103D
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 16:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhJLQ0H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 12:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLQ0G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:26:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FB2C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Qi7gtfGsDlyNA2zx3pA8M0H+iVgo8hVXljBMKXmXzZQ=; b=qq8GNL7BMEttCkgDoSu7lTosp1
        qQYieK8IFlRYnuZPFKd24H9RwKZ30EKwGBxASKQ/p6g9bEUwago/selQBWoMEKYtcVJAZxJHvsw1U
        3oNBT1etyILdWzAAXVrijvDaf4SFr1o08v/ArHy2xcuAqE38jESvjErTvhEXEvrTmJWS8/rVxXNGc
        Ob9Ot7Dz/GvGCtopCz9jzANiRGPvwpraJdwATUdF/jOE3YxraI+86gyv7et+UWMgApF/gQWAyr7vi
        9gb5R+cxVOOkCynMTlrTyJo8qrUu5qWKR91lyHpP1m1Izz0IaOxGma4MX/63cxW42RBRZR2cvWPLz
        ZMQmtDTQ==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKYd-006eB9-Eh; Tue, 12 Oct 2021 16:23:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/8] block: fold bio_cur_bytes into blk_rq_cur_bytes
Date:   Tue, 12 Oct 2021 18:18:00 +0200
Message-Id: <20211012161804.991559-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012161804.991559-1-hch@lst.de>
References: <20211012161804.991559-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold bio_cur_bytes into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio.h    | 8 --------
 include/linux/blk-mq.h | 6 +++++-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ec255f2829948..cffd5eba401ed 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -69,14 +69,6 @@ static inline bool bio_no_advance_iter(const struct bio *bio)
 	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
 }
 
-static inline unsigned int bio_cur_bytes(struct bio *bio)
-{
-	if (bio_has_data(bio))
-		return bio_iovec(bio).bv_len;
-	else /* dataless requests such as discard */
-		return bio->bi_iter.bi_size;
-}
-
 static inline void *bio_data(struct bio *bio)
 {
 	if (bio_has_data(bio))
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0e941f2175784..2219e92771186 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -927,7 +927,11 @@ static inline unsigned int blk_rq_bytes(const struct request *rq)
 
 static inline int blk_rq_cur_bytes(const struct request *rq)
 {
-	return rq->bio ? bio_cur_bytes(rq->bio) : 0;
+	if (!rq->bio)
+		return 0;
+	if (!bio_has_data(rq->bio))	/* dataless requests such as discard */
+		return rq->bio->bi_iter.bi_size;
+	return bio_iovec(rq->bio).bv_len;
 }
 
 unsigned int blk_rq_err_bytes(const struct request *rq);
-- 
2.30.2

