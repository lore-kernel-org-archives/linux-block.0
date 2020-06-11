Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D3AC433DF
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC2420814
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 06:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ecsuBeFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgFKGpC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgFKGpC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 02:45:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2ADC08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 23:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=45umEU4tXTK7eau62Mr5IM6AVQskQ+q04h72DSnb3oU=; b=ecsuBeFWarZjNpZmVmY85c4IPR
        uXGQSn8w/7kFb0DLicG9rzJIacjr69vFJSxEuiHKG2CWrqNqXJvrEqfA8PbNMzVNi6O+BxTm0BKkD
        MAiGmyM8QRNJ0lJmiBwSAU+mZ0KGyCjQFKbSDSs7R0WJYBX9yYX2RCPvIfkWPY/eWLIVSg/jvdnOF
        cOEiDUlRGKdTeqmxdzxhtzlPJymZkpWC/2gefKYvl+Wg5jlLZv1OW8fzIZ3kc0u95B19WB6WsJNWc
        5mprJb2MY4ckBAFcTo0bq+GK2mhupZrmSlhjHO2KilbvYeh8ckla6hbr+EaESH3iLLWIXsCaqsbFZ
        OarHCEUg==;
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjGxQ-0004uD-T1; Thu, 11 Jun 2020 06:45:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infrdead.org
Subject: [PATCH 02/12] blk-mq: factor out a helper to reise the block softirq
Date:   Thu, 11 Jun 2020 08:44:42 +0200
Message-Id: <20200611064452.12353-3-hch@lst.de>
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

Add a helper to deduplicate the logic that raises the block softirq.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bbdc6c97bd42db..aa1917949f0ded 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -598,19 +598,27 @@ static __latent_entropy void blk_done_softirq(struct softirq_action *h)
 	}
 }
 
-#ifdef CONFIG_SMP
-static void trigger_softirq(void *data)
+static void blk_mq_trigger_softirq(struct request *rq)
 {
-	struct request *rq = data;
-	struct list_head *list;
+	struct list_head *list = this_cpu_ptr(&blk_cpu_done);
 
-	list = this_cpu_ptr(&blk_cpu_done);
 	list_add_tail(&rq->ipi_list, list);
 
+	/*
+	 * If the list only contains our just added request, signal a raise of
+	 * the softirq.  If there are already entries there, someone already
+	 * raised the irq but it hasn't run yet.
+	 */
 	if (list->next == &rq->ipi_list)
 		raise_softirq_irqoff(BLOCK_SOFTIRQ);
 }
 
+#ifdef CONFIG_SMP
+static void trigger_softirq(void *data)
+{
+	blk_mq_trigger_softirq(data);
+}
+
 /*
  * Setup and invoke a run of 'trigger_softirq' on the given cpu.
  */
@@ -681,19 +689,8 @@ static void __blk_complete_request(struct request *req)
 	 * avoids IPI sending from current CPU to the first CPU of a group.
 	 */
 	if (ccpu == cpu || shared) {
-		struct list_head *list;
 do_local:
-		list = this_cpu_ptr(&blk_cpu_done);
-		list_add_tail(&req->ipi_list, list);
-
-		/*
-		 * if the list only contains our just added request,
-		 * signal a raise of the softirq. If there are already
-		 * entries there, someone already raised the irq but it
-		 * hasn't run yet.
-		 */
-		if (list->next == &req->ipi_list)
-			raise_softirq_irqoff(BLOCK_SOFTIRQ);
+		blk_mq_trigger_softirq(req);
 	} else if (raise_blk_irq(ccpu, req))
 		goto do_local;
 
-- 
2.26.2

