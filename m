Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D3C76196
	for <linux-block@archiver.kernel.org>; Fri,  7 Apr 2023 23:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjDGX6z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjDGX6x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 19:58:53 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFECE19A
        for <linux-block@vger.kernel.org>; Fri,  7 Apr 2023 16:58:50 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-632384298b3so180466b3a.0
        for <linux-block@vger.kernel.org>; Fri, 07 Apr 2023 16:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911929; x=1683503929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3jAvSoEVRdwVTbsDZcxY/yQqNhvxOtP9gEd9bVOfiY=;
        b=A+MCN4/vbYqOkgJAhTS0JsJe+K7hLTHaCCqsFRUDJSIbjtvobE83mxLyZhbgwYttWo
         CqPMABd+QRtpHW4EGuHdv37zNGS//HJ7RSdPQmSh7ZOipKLtrA57OGYeisFs5SbDEnnc
         fUsuZhtQ6xibVkSohSaGUQY2KI5oV8BLTWqyTVxfJ5nOudJ8hirwHmY+1zVhzjttQc+c
         63Wgauj2I+gzG2F6ckdKoJ+e5gqQmvtrjkJpGsq9QiJL/sixhip3pbAA9q5E0g5UzT/S
         jrkYObLN9RKXdkMQb1szPn0U2uHRzH3EIu46oq8EIG5KDQAW+28qrf0h4igOLFpba3ov
         YemA==
X-Gm-Message-State: AAQBX9dxxnr44U/SQBVG0tMpsNbyYi1o+QGJnp+6ee5hJLWr7Q2R8QRT
        YAiB3glQck1WdZUx2bOAdis=
X-Google-Smtp-Source: AKy350bv9QkGix6FiD/bgHn6C7xcYUSjUv6GKxKdmt6yx5hr2fliWsKeWorlGezCv8vl1bSr2LcxaQ==
X-Received: by 2002:a62:5204:0:b0:629:fae0:d96a with SMTP id g4-20020a625204000000b00629fae0d96amr3473563pfb.16.1680911929386;
        Fri, 07 Apr 2023 16:58:49 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:f2c:4ac2:6000:5900])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006258dd63a3fsm3556003pfh.56.2023.04.07.16.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:58:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 07/12] block: Make it easier to debug zoned write reordering
Date:   Fri,  7 Apr 2023 16:58:17 -0700
Message-Id: <20230407235822.1672286-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230407235822.1672286-1-bvanassche@acm.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Issue a kernel warning if reordering could happen.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 562868dff43f..d89a0e6cf37d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2478,6 +2478,8 @@ void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
+	WARN_ON_ONCE(rq->q->elevator && blk_rq_is_seq_zoned_write(rq));
+
 	spin_lock(&hctx->lock);
 	if (at_head)
 		list_add(&rq->queuelist, &hctx->dispatch);
@@ -2570,6 +2572,8 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	bool run_queue = true;
 	int budget_token;
 
+	WARN_ON_ONCE(q->elevator && blk_rq_is_seq_zoned_write(rq));
+
 	/*
 	 * RCU or SRCU read lock is needed before checking quiesced flag.
 	 *
