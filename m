Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C096CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5C520675
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G7pOmtxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbgEMKtk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 06:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgEMKtk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 06:49:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE14C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 03:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HAt1SiZNFPhBW+unObitU31wyI7uy3wWia4HI82MED0=; b=G7pOmtxGhV2UmiwGjIBxRqrbU+
        bxp+uph1qhAJyDIzBfUbyqSwHbyq2gW3ymA9gQU6Zy7irOR6ClrrYavflvQ3zWN0HksyL9b5rNleu
        y1BhLoQCJB0RysrWoga42EV7bjdlJfcpXEsLESviGlv2rnEugaVhSeqtWKEYHnZXZZCFWlZJg7i6w
        8Q2ui9G5Xb5XOIFf5xKRJokYjwJluW8NXnPOCD4FKlaOFYt/rfsEKRIPxrsq8OPjOfohsQ+TcDbqN
        y3s8CsMZZxU4msYBXuKsSL8I47DHS4YpwO+BcsauawBJVjztbB/k1KacAqv3PxYEemQiA9BgVV3Gp
        KxWMe9uQ==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoxH-0005b1-Qf; Wed, 13 May 2020 10:49:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/4] block: mark blk_account_io_completion static
Date:   Wed, 13 May 2020 12:49:32 +0200
Message-Id: <20200513104935.2338779-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513104935.2338779-1-hch@lst.de>
References: <20200513104935.2338779-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 2 +-
 block/blk.h      | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cf5b2163edfef..fe73e816dae36 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1361,7 +1361,7 @@ unsigned int blk_rq_err_bytes(const struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
 
-void blk_account_io_completion(struct request *req, unsigned int bytes)
+static void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
 	if (req->part && blk_do_io_stat(req)) {
 		const int sgrp = op_stat_group(req_op(req));
diff --git a/block/blk.h b/block/blk.h
index e5cd350ca3798..a813c573a48d5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -196,7 +196,6 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs, struct request **same_queue_rq);
 
 void blk_account_io_start(struct request *req, bool new_io);
-void blk_account_io_completion(struct request *req, unsigned int bytes);
 void blk_account_io_done(struct request *req, u64 now);
 
 /*
-- 
2.26.2

