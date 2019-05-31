Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA76EC28CC3
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F0625972
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfEaABK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 20:01:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42666 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaABJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 20:01:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so1672183pgd.9
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 17:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKYMpr3av6c92Yl0BWJMzu7c0k4yiUm12PuuJC1EqMY=;
        b=I8DdqmBeWCAqkUIwHiCsPGQp1SQVX12uIhoTP5Eq9pfy5kmDvAyqAwm8iy7NbASnnm
         U5NWEPWX1hwZ5FHbThhVvZ49EOcZNeoBipM/oS2jYuWajHWM++B04bDZJbX9oMe8BNpr
         x0lZAECOXItikyR3J7C8EiDsnIiFIvqow0Hi5FqgHAIzxYIFvS06h3qk335gH8VnkZh4
         Rt/Du/En2XyngZ5XgcR60etEEqaUz0/nskLZaGL79imZZK1tXVXsbC7JwA2YsraXIpha
         bM0rIL00P58eqMfY0AIxF7l1XFhHLvB8gsRjwPyIFxd1G7wahsxa/icY9h/KdGWeKsgw
         aeFg==
X-Gm-Message-State: APjAAAVBdOpxnVM82d6QdjVbgvga05auKSAeQmVVloy5tlb52TRKnZNE
        YeBLY4/bPJOIGcDDhV0U/hs=
X-Google-Smtp-Source: APXvYqwbRIabVlUNQzp8vJOUkLM/w6+FPnqjer3AeIoZ9kHmaHWSiALvW1cDn4jgikxBe/Xq8RaTUQ==
X-Received: by 2002:a65:5203:: with SMTP id o3mr5969493pgp.379.1559260869000;
        Thu, 30 May 2019 17:01:09 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g8sm3539851pjp.17.2019.05.30.17.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:01:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 7/8] blk-mq: Fix spelling in a source code comment
Date:   Thu, 30 May 2019 17:00:52 -0700
Message-Id: <20190531000053.64053-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190531000053.64053-1-bvanassche@acm.org>
References: <20190531000053.64053-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change one occurrence of 'performace' into 'performance'.

Cc: Max Gurtovoy <maxg@mellanox.com>
Fixes: fe631457ff3e ("blk-mq: map all HWQ also in hyperthreaded system") # v4.13.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-cpumap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 48bebf00a5f3..0afa4dc48365 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -42,8 +42,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 		/*
 		 * First do sequential mapping between CPUs and queues.
 		 * In case we still have CPUs to map, and we have some number of
-		 * threads per cores then map sibling threads to the same queue for
-		 * performace optimizations.
+		 * threads per cores then map sibling threads to the same queue
+		 * for performance optimizations.
 		 */
 		if (cpu < nr_queues) {
 			map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
-- 
2.22.0.rc1

