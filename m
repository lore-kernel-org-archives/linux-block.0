Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45025C4338F
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2595A61104
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhHERmZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 13:42:25 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:43612 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhHERmZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 13:42:25 -0400
Received: by mail-pj1-f48.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so11348413pjb.2
        for <linux-block@vger.kernel.org>; Thu, 05 Aug 2021 10:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CB7SvHbKMaUaPt3Ci5PlkFunOEsthh1lpDInkmwyLlA=;
        b=sEg0uIxDULZXjZu9kjQ+yibJ/NkmWN+ax5Zw0E5pzdq8W4snD7QWwk4tEjllsVdTCa
         OOt9p3q6F3UMLjG0HSy0aMy7CCYaonOLW33LUPPExODqmwWaZSFdmI4wn7OQptU0m/4D
         +paUvgNkcfIKaH4HSqI2e0KwlHq2QakNtstJFpk/0QaKn4OmdvlX+8lGfjAMydZl9OZz
         /kpYNWA+6MZWwThu4FPmINPj9t9Uxq8UoOfp7hADGmG5NJlrTIkwsp6o3gfWISLZkDZn
         I0pDYFfhiw8MGrb9j7bCDQh9KZ1lzx0LLL3vQsCIoxjkzsFZPbVAQu9Lll8mp6wDOweE
         bDUw==
X-Gm-Message-State: AOAM532FoSgn8Kf6n5ABB7Lvx/cb8vIByWKrBmugwe+5rlgRxgQKrI5x
        hscyEGSH8sRz47XkiNpd+aE=
X-Google-Smtp-Source: ABdhPJy99OTKESnYKVhs1h8DOe/uEkPyfcmx7Y3DHSbJQfxPJ7mwv+3LOR9vkl84bkbq+50UgNtyvA==
X-Received: by 2002:a17:902:7481:b029:12c:9cf8:bc5f with SMTP id h1-20020a1709027481b029012c9cf8bc5fmr4974202pll.52.1628185329499;
        Thu, 05 Aug 2021 10:42:09 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:93c2:eaf5:530d:627d])
        by smtp.gmail.com with ESMTPSA id m11sm10381834pjn.2.2021.08.05.10.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 10:42:08 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v3 1/2] blk-mq: Introduce the BLK_MQ_F_NO_SCHED_BY_DEFAULT flag
Date:   Thu,  5 Aug 2021 10:41:59 -0700
Message-Id: <20210805174200.3250718-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210805174200.3250718-1-bvanassche@acm.org>
References: <20210805174200.3250718-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

elevator_get_default() uses the following algorithm to select an I/O
scheduler from inside add_disk():
- In case of a single hardware queue or if sharing hardware queues across
  multiple request queues (BLK_MQ_F_TAG_HCTX_SHARED), use mq-deadline.
- Otherwise, use 'none'.

This is a good choice for most but not for all block drivers. Make it
possible to override the selection of mq-deadline with a new flag,
namely BLK_MQ_F_NO_SCHED_BY_DEFAULT.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Martijn Coenen <maco@android.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/elevator.c       | 3 +++
 include/linux/blk-mq.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index 52ada14cfe45..d0295e68f481 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -630,6 +630,9 @@ static inline bool elv_support_iosched(struct request_queue *q)
  */
 static struct elevator_type *elevator_get_default(struct request_queue *q)
 {
+	if (q->tag_set && q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
+		return NULL;
+
 	if (q->nr_hw_queues != 1 &&
 			!blk_mq_is_sbitmap_shared(q->tag_set->flags))
 		return NULL;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1d18447ebebc..22215db36122 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -404,7 +404,13 @@ enum {
 	BLK_MQ_F_STACKING	= 1 << 2,
 	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
+	/* Do not allow an I/O scheduler to be configured. */
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
+	/*
+	 * Select 'none' during queue registration in case of a single hwq
+	 * or shared hwqs instead of 'mq-deadline'.
+	 */
+	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 7,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
