Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EA0C433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79346134F
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhJSNmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 09:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJSNmE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 09:42:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B064C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jjowhwMXxEEnD4prU88hNY1JptGR6lw7nLgSsaG9/pM=; b=pVzdpdfxoRPsn/vqMGoYcGiu4P
        9otfwZiBwukWO8E3C7SxC6aUGJvt6XVIkfr+0+p/1KyngpCNZIkkx4uJQ7Sog150kJ9ZpJRIc3jJ4
        9B/hf/JjU1+uexixULMOzRBcl7QFvUAwyEpwNJVDZ8RZ+rzSKEfIWeUkVR4pphndvBAynK/ekrqIS
        L0wujB45WaQqwhPUdkp1X1MJ1FOeHb91SzGGcxJ6eJXV3IQ/1sd8YxO/HLdQNRX8mPQRH78wEfM+B
        Fgdx31IozK07tujqD/MKwqUL0XbTASz4NiOnbZV4ywlEoVKl/oCmPPsc7aV21E7dR1YyePKU0mZkl
        uahJYDsQ==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcpLK-001Roe-Nu; Tue, 19 Oct 2021 13:39:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: remove the RQF_ELVPRIV check in blk_mq_free_request
Date:   Tue, 19 Oct 2021 15:39:43 +0200
Message-Id: <20211019133944.2500822-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019133944.2500822-1-hch@lst.de>
References: <20211019133944.2500822-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If RQF_ELVPRIV is set RQF_ELV is by definition set as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 428e0e0fd5504..34392c439d2a8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -580,7 +580,7 @@ void blk_mq_free_request(struct request *rq)
 	struct request_queue *q = rq->q;
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
-	if (rq->rq_flags & (RQF_ELVPRIV | RQF_ELV)) {
+	if (rq->rq_flags & RQF_ELV) {
 		struct elevator_queue *e = q->elevator;
 
 		if (e->type->ops.finish_request)
-- 
2.30.2

