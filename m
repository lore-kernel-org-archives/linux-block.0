Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A2EC28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5E825972
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEaABK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 20:01:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43201 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaABK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 20:01:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so4961786pfa.10
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 17:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xWeZvctfD9fE8Y0f4Sc6Wt0Ue8JDElg+hHaYI60+tA=;
        b=rw36F+KNXMH3QbhqJNk66JATCdOlprJD9apvPyiCRHDLbMS6H/tFotHeXLr0FGL4rC
         33G4pLLMcxs5g3ynP0EmxfruJRqcbikzSigcVstVdDBIFTMgvU+djdfo4iOUAieHFAYc
         USdCLcq93LEAqkdIXXb+owRvZqO5AbJkaTKFfTxkJHiqheOcLlWaYuCoKJYDU+Mv1CbE
         o6w7lQ5YMkzeuSvLCxYNRNALiVRWxhk9ROI0ztwMGNg/xFVHaZ9/HzFdln5Kzz51J6IQ
         iWtjUJeLnOfleu29wmoUi6LSIhkrK/dmCBJUWkI46uKC6grSPJw1uwHTM4KWd1+f/gqS
         Vhgg==
X-Gm-Message-State: APjAAAUkEZaqSWrkqRu+hqEwfwsOr70golq+4UwbKC/4keCeqS665L2D
        XbUUtpIQfRaOldsUhs2xUokFATZY
X-Google-Smtp-Source: APXvYqzZGXrrWNG8b4NWSlV0Om8EDB879zyV6UM0Cf/0W8hx1caIQFLaqU74SPxN4fXDeBdzLjKt/A==
X-Received: by 2002:a62:2805:: with SMTP id o5mr6330238pfo.256.1559260869779;
        Thu, 30 May 2019 17:01:09 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g8sm3539851pjp.17.2019.05.30.17.01.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:01:09 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 8/8] blk-mq: Document the blk_mq_hw_queue_to_node() arguments
Date:   Thu, 30 May 2019 17:00:53 -0700
Message-Id: <20190531000053.64053-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190531000053.64053-1-bvanassche@acm.org>
References: <20190531000053.64053-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Document the meaning of the blk_mq_hw_queue_to_node() arguments.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-cpumap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 0afa4dc48365..f945621a0e8f 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -60,7 +60,11 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_queues);
 
-/*
+/**
+ * blk_mq_hw_queue_to_node - Look up the memory node for a hardware queue index
+ * @qmap: CPU to hardware queue map.
+ * @index: hardware queue index.
+ *
  * We have no quick way of doing reverse lookups. This is only used at
  * queue init time, so runtime isn't important.
  */
-- 
2.22.0.rc1

