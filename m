Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17848C67872
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C243320811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gE++VQgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C243320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeLMVeQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:34:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeLMVeP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 16:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r0srkHWyOjzOHdDJrFanVqLtshusUsc+4hsA0vhNt+A=; b=gE++VQgwNlqI42DHhJWEuRfan
        AfFZWRkYDAvauaMgpao7NtRW9VCjDn21uV4fNzA82eMG4FkqhiVt8CI7oJctEkFpmwuUX643PuDUK
        2KVd4+P5uH2Q2CjHDGKpPkhGQkNSZkUV0/EU5WUqlWVPcWf2q5EVtpO7ti2OS0EskBSVkpZ+lJx2A
        48Ar4NEsApsJ3QBl5s8lcWIhoZzt1e0PzkGC677EGLun2RqIcIES2jNFJDjHSOSrQwmwDVpZ80XTN
        ejRJNB07AAEN9VMfpyv+0CFkRx8VEmw7WAhJ0+LN8hnz6yqDtHxgcE+kw34+mn2bjgQGgXKtKL+vw
        QV+EB37tQ==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXYcY-0002ho-K3; Thu, 13 Dec 2018 21:34:14 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 1/6] block: clear REQ_HIPRI if polling is not supported
Date:   Thu, 13 Dec 2018 13:34:05 -0800
Message-Id: <20181213213410.9841-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213213410.9841-1-sagi@grimberg.me>
References: <20181213213410.9841-1-sagi@grimberg.me>
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

