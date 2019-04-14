Return-Path: <SRS0=vbI/=SQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2F8C10F11
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 03:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597372084E
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 03:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt9V7nld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDNDLr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 23:11:47 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44978 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfDNDLr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 23:11:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id y5so7962655qkc.11;
        Sat, 13 Apr 2019 20:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ioRJ93R4bxzTpNrBT/omYLG29991EfOPLpQtPqkqAgQ=;
        b=Gt9V7nldqfsGfseiWXUTcvQun0RkP7BRiVDq+qjLeCcnrVOQ52i+jNnychqaL3vLQ5
         9V4Q3aiX3gbtI/qp3XPeMa2P1pF0cNO3HVlKbVDiCIOCshr/ECkUIg0s7zzoA/p8aTGW
         kLcrf5gA2HPMaFyxh8VFd4WseVbxdeNanrh8VE60kvYYRwKbR5/cQscMJP3DZYSAx1m2
         goa0YCwtLa4O9yxnI4PT4AJ7w3RGUTsymQyJtBA1QB2ZlyauWOcEB0yjE2TMFaWQWNxY
         RP8z1QP6O2/nFQ4CzxhNiCfoc+do2sqgrRzm4b2l+tIrpa9MlCjv61CST/vRHBMx2pXh
         nZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ioRJ93R4bxzTpNrBT/omYLG29991EfOPLpQtPqkqAgQ=;
        b=Q4XbZRknr5bhKoHc+bUHaK8Ypik9fzNvROgNFVd/UrP0CPfMrSlDdr4IagBEriW1jS
         4tt2l1YfwiZWG95uk1yt89/g5AzovqFvoLkNIFS0Tn9o4G62MzepsqukJDAYOgyggpn5
         p9zxIfadE+b5j7gGBK9U45UZhgxJaO7ZPU4btn4OUQ+Yk3Hp1EBV3AIGWRkfghaXhCi5
         nsOhBVI5L0poeAmqJdchRHCgAvthN8CUvEyOtO/8gMdusTkB/DXEXSNVIUsZb/44meq+
         CYBdqO/knhcERzVYJ34Iga0ED2d485gv/5SSMnsj8OamghlT/KiaYpXbJAbv0Yz9ApQU
         lk4Q==
X-Gm-Message-State: APjAAAWuphwMBgiAY5G1ijTaIG9L6MLf5CEqPFWxgQ6x9EJIGP6+ibF2
        RmLYongth8QbRA+A1lIh3M5HTULXpZQ=
X-Google-Smtp-Source: APXvYqz8V3t9H81rbD8ATODHpg3/qZVqTU/c3ijWAkoxAU+ULR2T2GouPXsFYh8QJrfeUza9KUSxIQ==
X-Received: by 2002:ae9:ef07:: with SMTP id d7mr53328282qkg.100.1555211506087;
        Sat, 13 Apr 2019 20:11:46 -0700 (PDT)
Received: from localhost.localdomain ([191.35.237.58])
        by smtp.gmail.com with ESMTPSA id u44sm24668430qte.40.2019.04.13.20.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 20:11:45 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH 2/3] blk-mq.c: Rework documention of blk_mq_init_sq_queue function
Date:   Sun, 14 Apr 2019 00:10:53 -0300
Message-Id: <20190414031055.26350-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190414031055.26350-1-marcos.souza.org@gmail.com>
References: <20190414031055.26350-1-marcos.souza.org@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Describing better what the function does, and what the arguments are
meant for.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 block/blk-mq.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4a8277a54c03..fd0bf89b8a73 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2675,9 +2675,20 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_init_queue);
 
-/*
- * Helper for setting up a queue with mq ops, given queue depth, and
- * the passed in mq ops flags.
+/**
+ * blk_mq_init_sq_queue - Create a new request queue with a SQ queue and tag set
+ * @set: tag set to be associated by the newly created request queue
+ * @ops: operations to be associated with @set
+ * @queue_depth: number of tags of @set
+ * @set_flags: flags of @set
+ *
+ * Description:
+ * @set is initialized using @ops, @queue_depth, @set_flags, and using only one
+ * hw_queue (SQ). Later on blk_mq_alloc_tag_set() is called to validate and/or
+ * adjust values of the tag set. blk_mq_init_queue() is called passing @set as
+ * argument, returning a new request queue with @set associated.
+ *
+ * Returns the newly created request queue on success, or ERR_PTR() on failure.
  */
 struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 					   const struct blk_mq_ops *ops,
-- 
2.16.4

