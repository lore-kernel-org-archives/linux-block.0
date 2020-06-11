Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CC4C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1713E20812
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uHsyoGBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgFKGpT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgFKGpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:45:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C1C08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=25V3VAEOLpZ2bIDoDlxxNPz5OgXI+x+N86ufcWhlEys=; b=uHsyoGBeeXLFtbr2dbvC2ohbR9
        vJDw5gkqGlU9Htpih43y1xrXc6ePVdGxfWEGoNwpGQod8QkoUOA+TngwziRmfdunpYp9Mmsmzdkkp
        9Geh5EVt++dZZq4G8caf310M5OpZNQrz2t5aE/t1cfLwPLq0+LPyVNI+sqedUL9S3SMoDx1spE3sf
        oXn/qqy5DWZ1O96q+zRPcCj4ZV4YHBNF4INn9Z1rs7rYt1wUAIWvLOScEmDT0RjUwiWzDoMg9lUO5
        mpD43tcYN4I+O2fuAcC2KrB7FFvhiDWw2M5Goq5iW0Sn0G8bUrSuVUOm7DMUuc4BAKcDRDAKMMW7q
        q4S32pLA==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxh-0007Nk-NJ; Thu, 11 Jun 2020 06:45:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 08/12] blk-mq: remove the get_cpu/put_cpu pair in blk_mq_complete_request
Date:   Thu, 11 Jun 2020 08:44:48 +0200
Message-Id: <20200611064452.12353-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200611064452.12353-1-hch@lst.de>
References: <20200611064452.12353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We don't really care if we get migrated during the I/O completion.
In the worth case we either perform an IPI that wasn't required, or
complete the request on a CPU which we just migrated off.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b73b193809097b..45294cd5d875cc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -685,7 +685,7 @@ void blk_mq_complete_request(struct request *rq)
 		return;
 	}
 
-	cpu = get_cpu();
+	cpu = raw_smp_processor_id();
 	if (!test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags))
 		shared = cpus_share_cache(cpu, ctx->cpu);
 
@@ -697,7 +697,6 @@ void blk_mq_complete_request(struct request *rq)
 	} else {
 		__blk_mq_complete_request(rq);
 	}
-	put_cpu();
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
-- 
2.26.2

