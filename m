Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F791C4320A
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 18:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4994560EEA
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 18:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbhHCSXZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 14:23:25 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:33450 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbhHCSXZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 14:23:25 -0400
Received: by mail-pj1-f54.google.com with SMTP id j18-20020a17090aeb12b029017737e6c349so3534843pjz.0
        for <linux-block@vger.kernel.org>; Tue, 03 Aug 2021 11:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HnyuQQktS9v+8+m+6iiFsor3omgIHwpHGbY15tJhIhA=;
        b=Ed0HiL0QFrnsSZs0bYgw97FBms9xrlE20pwXbw3C2qs6BoXC6L/v6wojU+gUhIFJHZ
         1lBvt/aZFzYdKVet8tOeb7oavznGi6TaOTfE4+e4i3dRqX/SmPe+6j7AWp2FeCyAuQkc
         jn0lPVbwEjzuhfbNm/Wxd/GeFBAM9I9khgC8uTGBQDbRI+UnRfKstGkObzQylTC6QGFu
         B4GRrven0Nbrq6KDaom25pqwU/R9JCKklqDKtyIzuyFSlDspeJlsivbFKJlPTvBavexv
         ct+CpxaYxIyr7GKOWgh2XN24MN9evGMzQukJ7wyp7SUuXZtmZjjtGGAclLFVL1UNCZhB
         KhFg==
X-Gm-Message-State: AOAM533l23/RkzOBYo80pOO/x+LBYk5h1xMQjozw+PvxgkOVZ0+h0wu5
        eYEobLcWYHP9WdIlLe4xOmM=
X-Google-Smtp-Source: ABdhPJxJYFnotiIhWYqxXHzr1R0662PU6xau7pQA2BFwBAOe9rmDlwVab6ciBkRFs7q7CTIKgKePJQ==
X-Received: by 2002:a17:903:248f:b029:128:d5ea:18a7 with SMTP id p15-20020a170903248fb0290128d5ea18a7mr19533013plw.83.1628014993890;
        Tue, 03 Aug 2021 11:23:13 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:f630:1578:90bf:ff92])
        by smtp.gmail.com with ESMTPSA id ms8sm3476279pjb.36.2021.08.03.11.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:23:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v2 1/3] blk-mq: Introduce the BLK_MQ_F_NO_SCHED_BY_DEFAULT flag
Date:   Tue,  3 Aug 2021 11:23:02 -0700
Message-Id: <20210803182304.365053-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210803182304.365053-1-bvanassche@acm.org>
References: <20210803182304.365053-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

elevator_get_default() uses the following algorithm to select an I/O
scheduler from inside add_disk():
- In case of a single hardware queue or sharing hardware queues across
  multiple request queues (BLK_MQ_F_TAG_HCTX_SHARED), use mq-deadline.
- Otherwise, use 'none'.

This is a good choice for most but not for all block drivers. Make it
possible to override the selection of mq-deadline with a new flag,
namely BLK_MQ_F_NO_SCHED_BY_DEFAULT.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martijn Coenen <maco@android.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/elevator.c       | 3 +++
 include/linux/blk-mq.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index 52ada14cfe45..ae23da291297 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -630,6 +630,9 @@ static inline bool elv_support_iosched(struct request_queue *q)
  */
 static struct elevator_type *elevator_get_default(struct request_queue *q)
 {
+	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
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
 
