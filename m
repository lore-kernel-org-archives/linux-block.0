Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA26C433E1
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6E9207D4
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 15:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C3aIPhKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgEPPej (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 11:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgEPPei (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 11:34:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E0AC05BD0A
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=byXBp0caXN0TlAOk7RoqqVspGo5Ydc03EkeOXc680jI=; b=C3aIPhKZOpyVrM3BKo+UIiuoGX
        hSL5CWqy5DrDjDkIM2/IPchu9giWapzb5FJyRDxFShlTTBedOfJTWgoPcX+tYIzmLQnYQc7Cr44Pp
        xj9kpJ0f7oWe9x7dzmlWIXCfpvDPJITj0OvvjS0dKvRzRY4wSjlKKMjQvhD4967w05vInpV5IH2is
        dmtc32fSRSbv9EkqGssio18Bpr5YxkVssWH+vVdN4jl3PBPMKYdy0eCq8s7Q7A2+cP1hYhj9MwBAh
        pdFry/TIafmz2ZryiDB4vdh+knyqMScLzgzf95MFQR0U2fV1zIViCISsYy4sPAyjKXM79zGPkWY5+
        70v4C1zA==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZypi-000515-03; Sat, 16 May 2020 15:34:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/4] blk-mq: remove a pointless queue enter pair in blk_mq_alloc_request
Date:   Sat, 16 May 2020 17:34:28 +0200
Message-Id: <20200516153430.294324-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516153430.294324-1-hch@lst.de>
References: <20200516153430.294324-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need for two queue references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d2962863e629f..d96d3931f33e6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -406,10 +406,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	if (ret)
 		return ERR_PTR(ret);
 
-	blk_queue_enter_live(q);
 	rq = blk_mq_get_request(q, NULL, &alloc_data);
-	blk_queue_exit(q);
-
 	if (!rq) {
 		blk_queue_exit(q);
 		return ERR_PTR(-EWOULDBLOCK);
-- 
2.26.2

