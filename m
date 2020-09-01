Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A028C433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 18:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA052065F
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598986616;
	bh=HbKlxLoyNfuJ+PYxw3pGmdfgMjFnR8bPA42Ap6SI98Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WZNlH47fdQsBWyN+piYsUG/yOsJ3NieWq9QXigdGiRIab8lBa37Sy2unrnrOh0RfJ
	 XSVZqTkW0xk3bg6wmTynQUebgcN9mE6k5NR+j4zSF/+7xgrUYr9vrCk2cGYyWfVwql
	 vAOP/WQBIxd1YM69eFfVuUV7LLNv7fsV+SJpUvik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbgIAS4x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 14:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731245AbgIASxJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 14:53:09 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71775C06124F;
        Tue,  1 Sep 2020 11:53:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d20so1996903qka.5;
        Tue, 01 Sep 2020 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLHwGiWfWkP5kcHSnqjONlJj/O0Qbx60l9TYb+oGkco=;
        b=B3K+LIBrV807PBKY6u2wypELmyggq3KtY8cxZwTKZ8RQA/n1e71fVHCy4sRQklcUtr
         CREI/4x1mQ+mcdi46kL6S9vLmtbUlnz9bBxhQWCYyCv2fc8NYLI9HGzXRFS12nQnr/7r
         ClhF+3BwIXFLZqWPw7pfXSiCSun3gZx/vd+gKCAmgcbETNSruJmVVwEXokDYSM3piiJU
         Kl96VzKmr+GcZYj7+ZLR+PoPVmd0WtAM4O/uxMk5okGAOPNdjr14YsIo2gBwdDgqKjIQ
         2rly3BSMOKkL/pVu0MvnbEvXy4n1PpK9mIplhN1bpK56tpdiUGmth5nbGN49e2UaWbtV
         H2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uLHwGiWfWkP5kcHSnqjONlJj/O0Qbx60l9TYb+oGkco=;
        b=aprzarl+XOLn8Qco4ucUL0vr0zoMclLak5/hCgl2GzVytxAA9zntJ/bXBBpQAk4e1C
         2/XjeS+SZELUOxIZx/OFw4UUINx5kICmIM7wRrLOgebeuN4fOVxxlqLqr+OeopoiqN/p
         I6SPWVlKAKivwGEwE7jzuCEz/63HDBbQ2m5k3/YF3tRqnE8RRDFucs1YGgRxR0viLLFH
         V6ag8iEZQDFBFuZoCaPeFcfpbV+1SMqjqOSbiwmXQl571g5zEaXZ6Yk1oUEe2aX2BmyN
         v1p6760MVwJ13iUf2Bk6dur6O4ZCatH23hZRnh3nJ/IaRa3QnINC4tpUvmxjC0Y0KM6l
         m5EQ==
X-Gm-Message-State: AOAM531XskOITEueK6O9l7++jIjCJ87XdNRj+wlZ/5FDLrrCjTmN8D8k
        uDV0BsESOB4m++aMfO4kGRM9hl7hlMxSFg==
X-Google-Smtp-Source: ABdhPJz/FzbNt/DYQEKFdJtI4ZeTtPEVzwUyDfGj2haKHEtcgF8tR5a76OyunS6WmzWCcMJ5geoj4w==
X-Received: by 2002:a37:9d4d:: with SMTP id g74mr3064979qke.422.1598986387528;
        Tue, 01 Sep 2020 11:53:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id b13sm1675828qkl.46.2020.09.01.11.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:07 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 02/27] blk-stat: make q->stats->lock irqsafe
Date:   Tue,  1 Sep 2020 14:52:32 -0400
Message-Id: <20200901185257.645114-3-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-iocost calls blk_stat_enable_accounting() while holding an irqsafe lock
which triggers a lockdep splat because q->stats->lock isn't irqsafe. Let's
make it irqsafe.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: cd006509b0a9 ("blk-iocost: account for IO size when testing latencies")
Cc: stable@vger.kernel.org # v5.8+
---
 block/blk-stat.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 7da302ff88d0..ae3dd1fb8e61 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -137,6 +137,7 @@ void blk_stat_add_callback(struct request_queue *q,
 			   struct blk_stat_callback *cb)
 {
 	unsigned int bucket;
+	unsigned long flags;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
@@ -147,20 +148,22 @@ void blk_stat_add_callback(struct request_queue *q,
 			blk_rq_stat_init(&cpu_stat[bucket]);
 	}
 
-	spin_lock(&q->stats->lock);
+	spin_lock_irqsave(&q->stats->lock, flags);
 	list_add_tail_rcu(&cb->list, &q->stats->callbacks);
 	blk_queue_flag_set(QUEUE_FLAG_STATS, q);
-	spin_unlock(&q->stats->lock);
+	spin_unlock_irqrestore(&q->stats->lock, flags);
 }
 
 void blk_stat_remove_callback(struct request_queue *q,
 			      struct blk_stat_callback *cb)
 {
-	spin_lock(&q->stats->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->stats->lock, flags);
 	list_del_rcu(&cb->list);
 	if (list_empty(&q->stats->callbacks) && !q->stats->enable_accounting)
 		blk_queue_flag_clear(QUEUE_FLAG_STATS, q);
-	spin_unlock(&q->stats->lock);
+	spin_unlock_irqrestore(&q->stats->lock, flags);
 
 	del_timer_sync(&cb->timer);
 }
@@ -183,10 +186,12 @@ void blk_stat_free_callback(struct blk_stat_callback *cb)
 
 void blk_stat_enable_accounting(struct request_queue *q)
 {
-	spin_lock(&q->stats->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->stats->lock, flags);
 	q->stats->enable_accounting = true;
 	blk_queue_flag_set(QUEUE_FLAG_STATS, q);
-	spin_unlock(&q->stats->lock);
+	spin_unlock_irqrestore(&q->stats->lock, flags);
 }
 EXPORT_SYMBOL_GPL(blk_stat_enable_accounting);
 
-- 
2.26.2

