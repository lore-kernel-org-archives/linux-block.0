Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99876C43444
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD27206C0
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h7Zbs36+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbeLNTGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:06:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730566AbeLNTGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 14:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r0srkHWyOjzOHdDJrFanVqLtshusUsc+4hsA0vhNt+A=; b=h7Zbs36+R6IhuZ4O4JbI6+tbn
        9wAGnJ8+CBpRj+ox2o3xdTaKso2cwAi5+6jOnvA7hzERyyS3w2js4I+STc9PYOsjK1xXIg6R5I2z2
        h7h2QwO/ytrXUYVAHaA/0BJ9mS8sa0hE7Ulo3dtVKBb4SSGd36Qp+XYyJibl0GIfMKPhHcHqppEfY
        gn0/IYr4sIltyOh2Cq9PKq2rhNK71XUm6LGVsO/YjUjq2v8KmIeZSF1STQHudtjPCpiJ2u6M9ufWF
        6TFUVgZhdIhGdthHqv/yxWH3ACVEcub1sEfvykOPcSdBhfut2Z9lJJgVofjWGoVDbto1n91i4TZ9h
        Zuii993BQ==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXsmq-0002PK-Fj; Fri, 14 Dec 2018 19:06:12 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 1/6] block: clear REQ_HIPRI if polling is not supported
Date:   Fri, 14 Dec 2018 11:06:05 -0800
Message-Id: <20181214190610.20086-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181214190610.20086-1-sagi@grimberg.me>
References: <20181214190610.20086-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

This prevents a HIPRI bio from being submitted through a stacking
driver that does not support polling and thus won't poll for I/O
completion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
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
2.17.1

