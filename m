Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5091BC43387
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 16:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8839206E0
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 16:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QpGqc665"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeLNQVZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:21:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeLNQVZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 11:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bggtyBEbG34io588W2NZDb84f8RWVx7porrtxyQOIqI=; b=QpGqc665kXyTlJZjz0LpBtMeB
        SjuLjn3StMd0Y2wHy9rHl9mNnT38lUOq6IDuwLu6yqtajEM2TomFDQswmcbV61yjHINj9TlhFdQ9j
        uBTd1Lu+wpSMKgy4ZJ2Lm2WOsLe4u2SfHRci1FudDXM77Fzor1kE3Ms/WTj065oLU8p5UlDiAeM9J
        6IJla6jTAWQaB/Mu3RVhPsmKPFKdv6NBzqcWm9FkI3ELFQUanXEMkY+3RZAlkpSsj8WCgz/u5ymmt
        SyiJ3kgVqqRnJC7kEQqaZ3r3mCmc8v9JBDsPByiW8irB6ZwHDk4KFkF69Dys7Tp5Sd+zF0V8DXRa1
        HGFhYDo4Q==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXqDM-0006Yi-Do; Fri, 14 Dec 2018 16:21:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: clear REQ_HIPRI if polling is not supported
Date:   Fri, 14 Dec 2018 17:21:22 +0100
Message-Id: <20181214162122.14937-1-hch@lst.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This prevents a HIPRI bio from being submitted through a stacking
driver that does not support polling and thus won't poll for I/O
completion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 268d2b8e9843..efa10789ddc0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -921,6 +921,9 @@ generic_make_request_checks(struct bio *bio)
 		}
 	}
 
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+		bio->bi_opf &= ~REQ_HIPRI;
+
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 		if (!blk_queue_discard(q))
-- 
2.19.2

