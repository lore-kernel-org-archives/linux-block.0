Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC5CC4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA38022B43
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 15:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgLDPWE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 10:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbgLDPWD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 10:22:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34A1C061A51;
        Fri,  4 Dec 2020 07:21:23 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h7so3918159pjk.1;
        Fri, 04 Dec 2020 07:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8GRsx9W76nEBQns60PeqGvsE174WKc8EGtATwU1W+Mk=;
        b=ZRWSnWUpHR7bxPL4x8js8hAdm6O/rRmk44fJZouOiMlI2fDrcJ/RFeznLWPuvn2To8
         Q5pHXgTK3vb8Y6fBCV1+2NA57tGJk0x+b8OJIwcpfRfTuKWtQIMW0u9L5iL92z2fx55g
         taF5/1LGsR8eDMd3ixu+UAFYskDhQxc7oOlhZ1y4wl8nuSKoA2b6wMsvYd7+vPyFDExS
         GXqsrZ+yXbuYyq79nxvYQCSorXbWCxs/M8DNPZaH8L97s162zClJ683mlwCCkdswrTXS
         2hRAeoO49Ez9ogtp/+sWn7751KQs+J21U2HmSXm5t5EwEt135lCONEN3byraZFFeq8o2
         iY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8GRsx9W76nEBQns60PeqGvsE174WKc8EGtATwU1W+Mk=;
        b=C4Fros4YL01XlNcS1CBLweL8u8BrCmVC2LoOW9wg/gj3cF+P8vjKH8M2zYT+6VlACI
         +vEsP5GMS9VRjZbk4muVgITge56tpTVhst4LtZePlzEqcOgqOFhkJfIvTdaZIoc1VQa0
         V+/cZP3trCq1qXqgJnCnRDsQXYxY/dTkYkcXp7jVN4d2WSHt4VGtoY7MTLfPdtpY4S2O
         qx6iEaMXLLx2CeQS+q6H28ysWTUnubPWzOMyLdIJSZY42SIm5rnLDF6iWsuP5yc5zPbT
         HHjkfxBd0IjHPRyAeP7xDLZ5Q+GYFtVgVRrlfm2B5G3gUQBTJo1JueFDQ6ACeGMQ7uWE
         t4TA==
X-Gm-Message-State: AOAM531wU/Mebi3RoQCRUe06KC/MIBY2dKRdbxntkj/TK/Bavf5qyY+Y
        KPWLS2h8/M9Dc0oeUYdri2qW1uzLb0gZyw==
X-Google-Smtp-Source: ABdhPJxAAjgMASqa7LiteK08rLw7jgKDZKMXTw0cxaAcqYs/DnA/YiChnZ8/8ghAvJig9mWJ3XqYuw==
X-Received: by 2002:a17:90b:1645:: with SMTP id il5mr4658326pjb.15.1607095283170;
        Fri, 04 Dec 2020 07:21:23 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id d20sm2407286pjz.3.2020.12.04.07.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 07:21:22 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 2/3] blk-mq: update arg in comment of blk_mq_map_queue
Date:   Sat,  5 Dec 2020 00:20:54 +0900
Message-Id: <20201204152055.31605-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
References: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update mis-named argument description of blk_mq_map_queue().  This patch
also updates description that argument to software queue percpu context.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 block/blk-mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index c696515766c7..c1458d9502f1 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -99,7 +99,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
  * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
  * @q: request queue
  * @flags: request command flags
- * @cpu: cpu ctx
+ * @ctx: software queue cpu ctx
  */
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 						     unsigned int flags,
-- 
2.17.1

