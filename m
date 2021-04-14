Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A70C433ED
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 09:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925CC61249
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 09:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhDNJ7X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 05:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhDNJ7X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 05:59:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5CDC061574
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 02:59:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u7so7998850plr.6
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rD7Q03Tn6R2dCr+TvTwn+QNm2A89LKxc8tnwYSYvqio=;
        b=km0h0MtMhsJwNIyKAp3LWUsHrhDznwjWRLt7x1s4kXWELfBgGSrRnHd6x1gkDqQSFL
         CfkR0NTY4D2B+K6q/DQsDhz00hL8lUGm8RHRB6zFFmph7jr7HRVsNuOGpQ2pWanPZEiZ
         NEzqybGzTKcvIu83qlVw0nX38GEEBb+A/K+2s4S9+pHK/8Yw1oNZGEgUHrEEL87m4wxP
         LCjK66dOyaDu7pBoYZ05z1LpDaMgzmg4qwum0/skFs0LrWf0wnR7ssWZ9PRDdB4JDaa/
         4brw3L8FWWtOKqj1XEbIPwl9/vYRfvB/1fmAzkL12YGOcoXN4ickduc6y1ncmgkjPEyR
         9MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rD7Q03Tn6R2dCr+TvTwn+QNm2A89LKxc8tnwYSYvqio=;
        b=SSwJd6CI3EP6YZvd2x+F3JbVVBx4lEIOzcanPKOUtRZZxtPC/VWh6qVCNpybQ4laU1
         zTTre2V1mqNMD8409Cjyf8A80NE7c/HK5v5ZJTqFypkLuLdcDyBw7aK7Z2WsmQLNw2I0
         FF0nTw3dau6YyJjWrRSuYEoZ9bIaLV1nSU0q3JdN5ZhXHc7USnipQgnEpWtNcM41eMqt
         gcyaIndJ8n2mSGug5WX+2DNwAxW8VLddU/g2vTlTLmAwXS4ZV0ajjoAcnCz9W0iJd/fv
         CQWlW3svhgaOdA2a1C8NETNCgO7CSkkGklONVnfo4pyRw+z3iR1+AbQx1nThtNtoGR0Z
         fBCQ==
X-Gm-Message-State: AOAM533KhPairvm0xOfnfwPPJEisvkzh95846lXtdCMg92tUoWuznknq
        2brtemKtVFvP9ut2E9GOOJcxRHev5C0=
X-Google-Smtp-Source: ABdhPJy5crgrYryao249bqioGTeurBfxWQFCsdHPJAVhWLnQnNJEaIfI946M2x3y6VwxPf75oP0caw==
X-Received: by 2002:a17:902:74c2:b029:e9:a966:2e1b with SMTP id f2-20020a17090274c2b02900e9a9662e1bmr20167039plt.43.1618394342321;
        Wed, 14 Apr 2021 02:59:02 -0700 (PDT)
Received: from localhost.localdomain (23.83.224.125.16clouds.com. [23.83.224.125])
        by smtp.gmail.com with ESMTPSA id r11sm4263074pjp.46.2021.04.14.02.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 02:59:01 -0700 (PDT)
From:   Jackie Liu <jackieliu2113@gmail.com>
X-Google-Original-From: Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH] block: elevator: remove dead elevator code
Date:   Wed, 14 Apr 2021 17:58:41 +0800
Message-Id: <20210414095841.46553-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since a1ce35fa4985 ("block: remove dead elevator code") we droped
ELEVATOR_INSERT_SORT, ELEVATOR_INSERT_BACK and so on.

After f382fb0bcef4 ("block: remove legacy IO schedulers") we droped
rq_end_sector(rq) use.

After f382fb0bcef4 ("block: remove legacy IO schedulers") we droped
rq_fifo_clear(rq) use.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/blk-flush.c        |  5 -----
 include/linux/elevator.h | 13 -------------
 2 files changed, 18 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 7942ca6ed321..0cba5bb2c5e0 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -361,11 +361,6 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 /**
  * blk_insert_flush - insert a new PREFLUSH/FUA request
  * @rq: request to insert
- *
- * To be called from __elv_add_request() for %ELEVATOR_INSERT_FLUSH insertions.
- * or __blk_mq_run_hw_queue() to dispatch request.
- * @rq is being submitted.  Analyze what needs to be done and put it on the
- * right queue.
  */
 void blk_insert_flush(struct request *rq)
 {
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 1fe8e105b83b..727f74ae77c8 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -150,21 +150,8 @@ extern void elv_rb_add(struct rb_root *, struct request *);
 extern void elv_rb_del(struct rb_root *, struct request *);
 extern struct request *elv_rb_find(struct rb_root *, sector_t);
 
-/*
- * Insertion selection
- */
-#define ELEVATOR_INSERT_FRONT	1
-#define ELEVATOR_INSERT_BACK	2
-#define ELEVATOR_INSERT_SORT	3
-#define ELEVATOR_INSERT_REQUEUE	4
-#define ELEVATOR_INSERT_FLUSH	5
-#define ELEVATOR_INSERT_SORT_MERGE	6
-
-#define rq_end_sector(rq)	(blk_rq_pos(rq) + blk_rq_sectors(rq))
 #define rb_entry_rq(node)	rb_entry((node), struct request, rb_node)
-
 #define rq_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
-#define rq_fifo_clear(rq)	list_del_init(&(rq)->queuelist)
 
 /*
  * Elevator features.
-- 
2.25.1

