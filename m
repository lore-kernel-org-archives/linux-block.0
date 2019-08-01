Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69B8C19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADBD206A2
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 22:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389848AbfHAWkD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:40:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36601 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHAWkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 18:40:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so34884961pfl.3
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 15:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ytbQCHcSIKXpBuEXUiPVXkoo30AV6azdUGtYr6rjxJQ=;
        b=k1jAlAcCS74GDmxrps8JGB/bcWsJxI1Cwl38e0XykjSLEAYfFLdIMzXTixJ/heLKI2
         C6YPNXr+R0IHU68I9nC9ONkiow34DLx5x6TmmTco7eiJLntrTb4P9jfN9sCkyrBVLa64
         WSVkuvnNUXK3cYUCofKDxvwv9G8XBciLjpnAM/xxbhwT2K6lnEA/djA6AVpks7tWkMxn
         FBzJ7pVOaB0+Sj5vgGpVO06vmDRDCVEyxMcr8QNoW2WPV1DpIBlTfmCg++FkXhpRxPnN
         USE1yYzr5U156X1MExoMkJCb3toOF1F4oMzIn5HOK5QwAR/WCYnzDq5ThAi0pjd3qhQb
         Bq2g==
X-Gm-Message-State: APjAAAVvT6BtWA/A7MQptvxe9lbQKE0MByBzA0mcsEBOhI+hMYLZSkEa
        lJXawaF+MmDKFerccVu7GkU=
X-Google-Smtp-Source: APXvYqwHn+zw3/Dmnljq7Uql3mL1fcDLJX8jQ1GdvCJFQLbGuFlj+K+nMlik2IIQIjFg3BEq/4sI9Q==
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr1105855pjh.61.1564699202805;
        Thu, 01 Aug 2019 15:40:02 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s11sm73054392pgv.13.2019.08.01.15.40.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:40:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH] block: Fix a comment in blk_cleanup_queue()
Date:   Thu,  1 Aug 2019 15:39:55 -0700
Message-Id: <20190801223955.141237-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change a reference to the legacy block layer into a reference to blk-mq.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0cc6e14d2f0..5878504a29af 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -344,7 +344,8 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	/*
 	 * Drain all requests queued before DYING marking. Set DEAD flag to
-	 * prevent that q->request_fn() gets invoked after draining finished.
+	 * prevent that blk_mq_run_hw_queues() accesses the hardware queues
+	 * after draining finished.
 	 */
 	blk_freeze_queue(q);
 
-- 
2.22.0.770.g0f2c4a37fd-goog

