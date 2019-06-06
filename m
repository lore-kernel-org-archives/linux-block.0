Return-Path: <SRS0=ECsc=UF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55359C28EB5
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 10:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2195820868
	for <linux-block@archiver.kernel.org>; Thu,  6 Jun 2019 10:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F0PlAt5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfFFK3N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:29:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfFFK3N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jun 2019 06:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/7tIThSUcLvYWpz7b1fuEsl/GAhVB0FKbzoySqNV5zE=; b=F0PlAt5Hy5oMHGcGg97UmCeCNz
        7h4QwkGfuXmIKhrChi5599WvOQgPgUt3DL9IS3Le2Bq10c6ln8jz8nPRqYwCCn2TyCLNwaKRDYKwq
        aYVn8HexNdsVprjWq3oJM/fT7Y+TDV/p7eV6tO5yxpns62AwCtRcsUtZxFpHyRWj3VtlxT9lNDKtp
        AzMVGtTZ6gIr9Ao3EdRI0jZfUVDWEFV0YlOm6C5ScZ/Q4R7cg7sArXyvnM2DO97WHQarDDO7Rd3am
        1esY8imt0pdyz9yHgWuzZxtLZ7nMtdOWBmpYu7iITFdszKaV8rfPb6CScZZcpfjFYL3tQlw+SogUK
        joPQH6dw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpdu-0008RE-N1; Thu, 06 Jun 2019 10:29:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/6] block: initialize the write priority in blk_rq_bio_prep
Date:   Thu,  6 Jun 2019 12:28:59 +0200
Message-Id: <20190606102904.4024-2-hch@lst.de>
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

The priority field also makes sense for passthrough requests, so
initialize it in blk_rq_bio_prep.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ee1b35fe8572..9b88b1a3eb43 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -680,7 +680,6 @@ void blk_init_request_from_bio(struct request *req, struct bio *bio)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
 
 	req->__sector = bio->bi_iter.bi_sector;
-	req->ioprio = bio_prio(bio);
 	req->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(req->q, req, bio);
 }
@@ -1436,6 +1435,7 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 
 	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
+	rq->ioprio = bio_prio(bio);
 
 	if (bio->bi_disk)
 		rq->rq_disk = bio->bi_disk;
-- 
2.20.1

