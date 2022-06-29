Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28706CCA47C
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiF2XcJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiF2XcI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:08 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCFD31F
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:07 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id jh14so15500315plb.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wr/UxPFtRiQyMDCH6oBbNj81g7rToO6NwwME1BTq81Y=;
        b=fkJY39NHsnnR+4fK93VxVZHuZOG0+UniSnKMv4Er0n9o5CgKZLhMbGQbydJMNzVt4u
         yLoIjA3xN8NbonQwb3af9KYA1CLc8bIMdgkY6eCPGWg8+pRvN2pK/0EeLge+ilqTWtbd
         1cMJ6DNkrx0Sou8DFcDlCL9NQdO/9JrcQAd+lZDo7Si6dOX/wBzxyYE7K+enqblzbslX
         auAiFhFE+k2a6tFn6sgPsURBlSt5Ilkztd5Dzyh6nineRBwiFzWUx1xWE2WxDL6ap+4H
         SPF5ZdTFsN+kGpZyOHgDFlelidPkRl31RVWeQoiz/hR/Xl45v+W/T5nuUr2A0CzGi0t+
         sMLQ==
X-Gm-Message-State: AJIora8BLQ4jcZakdKBjn0PMHMALQNt54hksBGwu9G+HcENRTKFnF0Ft
        BaC8ETXJP0QONWh6BTLojCU=
X-Google-Smtp-Source: AGRyM1u/zg5+OVGq5sT2jbW13QWC/ob3EZe7Yhu38kle6+dVDBEukY/j9NzWL6S12DKoltjsVC8cCA==
X-Received: by 2002:a17:90b:4cd0:b0:1ec:b260:db49 with SMTP id nd16-20020a17090b4cd000b001ecb260db49mr6511682pjb.193.1656545526787;
        Wed, 29 Jun 2022 16:32:06 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 08/63] block/mq-deadline: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:30:50 -0700
Message-Id: <20220629233145.2779494-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new blk_opf_t type for an argument that represents a bitwise
combination of a request operation and request flags.

This patch does not change any functionality.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1a9e835e816c..c5589e9155e6 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -543,7 +543,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
  * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
  * function is used by __blk_mq_get_tag().
  */
-static void dd_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
+static void dd_limit_depth(blk_opf_t op, struct blk_mq_alloc_data *data)
 {
 	struct deadline_data *dd = data->q->elevator->elevator_data;
 
