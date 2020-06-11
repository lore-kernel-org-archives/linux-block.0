Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786A4C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEA920812
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gH0894s3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgFKGpK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgFKGpK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:45:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A2EC08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=O5HtLWkNtZS+beER9D2bB08qynuLAFSNc4aOpQpZTbc=; b=gH0894s3NNQuUZYPY2BH20vVZu
        Po/CSBMCLtpxCqozPIE5ZOHNhZ35aypPS0BCJcsy81SasyVWyUxLej5f1GhN2abxcOAqw9JTAQig/
        10NEJ6PLeeTCbnk6RzDXqNmuzoH2l1VX8SI/D7cYfcPtTK4xQuLbJ4AYf7sUjoBuzTPhZPsiy18vn
        MklUhby+RwHUjo27ycyd+6PVdGCVFV5+t+FsrLFVGEqroNwOBbh39/pa3kVWXTcp6CSzJTHkVau8B
        9Be8cGY+Zm4QheXDys7A5lkhCSvCFAv6ajR8b+4EWd2usBnVd3dp3QAJn226+Yc/bsUJTPzF0eBqF
        Fwmttl+w==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxZ-0006Op-HO; Thu, 11 Jun 2020 06:45:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 05/12] blk-mq: short cut the IPI path in blk_mq_force_complete_rq for !SMP
Date:   Thu, 11 Jun 2020 08:44:45 +0200
Message-Id: <20200611064452.12353-6-hch@lst.de>
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

Let the compile optimize out the entire IPI path, given that we are
obviously not going to use it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 25ce40b367a635..059d30c522f2ad 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -727,7 +727,8 @@ void blk_mq_force_complete_rq(struct request *rq)
 		return;
 	}
 
-	if (!test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
+	if (!IS_ENABLED(CONFIG_SMP) ||
+	    !test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
 		q->mq_ops->complete(rq);
 		return;
 	}
-- 
2.26.2

