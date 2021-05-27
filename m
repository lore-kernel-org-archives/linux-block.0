Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DBCC4708A
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3711A6128B
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 01:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhE0BDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 21:03:22 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:35824 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhE0BDW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 21:03:22 -0400
Received: by mail-pf1-f174.google.com with SMTP id g18so2348297pfr.2
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 18:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBVcGmIsQ4t8SQd6Cf5AhXexoCdVAbFCg7YYTBO9lk0=;
        b=DevwN+9CRswWsVUoiBQa9hKcFSgfLyCHRkM7u7QQGTVnr6Nup4iOt5F/gZ7HvGBl8p
         EjHH5XPQ9e2vopXt1sWr7k+f4E704q/+c9AKSb+6p6f9MM/QhXAa9KM91x7yQmSRvz2b
         7wJczVfs6N2PPf/7G7a1lqlE7YFhMyFnU9EA41PvwXG8f27NGPGvr6mlqgflttqPbmah
         i6sZLcaFjAZ+zuUqKChb8CvGoXPffzUWdlunTMzR+odFW1pnbgnK8p8yez+L+ZIkm8OG
         31MQ5gODYISbjFzP4or3qItrohw3Rne0xhZGJ23eK65VK5bbaicV7jCcEe2MukZq+4TZ
         j3cw==
X-Gm-Message-State: AOAM530mB3bZcpAw98QYJRC29qcHyx3gHIcud11e0oYRAhXxHoWLL5dK
        yUIldgl273ZuuuXhv572urnzZ6xeHE8=
X-Google-Smtp-Source: ABdhPJwSSR4A1A7bHNEM05bJapun4betSESNjjqj4m3hymTBGBLBEtQdOXX+nZxGcgv8HZaSckuvFg==
X-Received: by 2002:a05:6a00:1a0a:b029:2e0:11d1:6d73 with SMTP id g10-20020a056a001a0ab02902e011d16d73mr1209737pfv.34.1622077308618;
        Wed, 26 May 2021 18:01:48 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j22sm310707pfd.215.2021.05.26.18.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 18:01:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/9] block/mq-deadline: Add two lockdep_assert_held() statements
Date:   Wed, 26 May 2021 18:01:27 -0700
Message-Id: <20210527010134.32448-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527010134.32448-1-bvanassche@acm.org>
References: <20210527010134.32448-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Document the locking strategy by adding two lockdep_assert_held()
statements.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 64cabbc157ea..4da0bd3b9827 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -279,6 +279,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	bool reads, writes;
 	int data_dir;
 
+	lockdep_assert_held(&dd->lock);
+
 	if (!list_empty(&dd->dispatch)) {
 		rq = list_first_entry(&dd->dispatch, struct request, queuelist);
 		list_del_init(&rq->queuelist);
@@ -501,6 +503,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const int data_dir = rq_data_dir(rq);
 
+	lockdep_assert_held(&dd->lock);
+
 	/*
 	 * This may be a requeue of a write request that has locked its
 	 * target zone. If it is the case, this releases the zone lock.
