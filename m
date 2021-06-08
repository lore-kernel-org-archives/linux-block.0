Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD86C4743F
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127EB61361
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhFHXJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:09:13 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:44849 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhFHXJN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 19:09:13 -0400
Received: by mail-pg1-f181.google.com with SMTP id y11so9667950pgp.11
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 16:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sC//DSflrYYUUqwO5cZ8eH2Jsx8jSOvCgTNVQdA4IeM=;
        b=SWpeOU6bhRzoXrM3xM5h9m0wlWXHcWSvZVGDQ61m2cYl4roDgRvZmi7VKeZyWAfVwX
         Vt3QP5Q06PPquwnWc0FtbpDJlkizLlT3mUZPob5EDWJPouwvLl3hyxGJI9SWuxHfJs1V
         gZPHzUQJFGsmHqo7AKSm6ZxdCSGzpL7qCuWoAMXADnurs8qhe1NAZq6P5jcOA16WX6U4
         ZOeBkqj+LJ1SohpNdGWCMEZFjwYtd0+YytDSFLvseN2aTQCpiysMaUKqTKh1ficrakJx
         QGBUzFdNaHrhle0Ob/GJoAtojhIgBy60zqVgzFz4QEojX0IOhfemyA+gEtlY7RG5ouy/
         GjHQ==
X-Gm-Message-State: AOAM533FOGXh5k2e2CyBjslQ13E3ScHJ7WiSx3k37despiyF/Zhm5uui
        dFqxnvUzFdNd19YrCnWYkw8=
X-Google-Smtp-Source: ABdhPJx/VSoaOvVnVaGwWYqpAfDQeMZUdXzjsd/WR7q5fpvGfArhtD0/WYwzgXcrT+OhB+5nP7ODpg==
X-Received: by 2002:a62:5285:0:b029:2e9:e0d5:67dc with SMTP id g127-20020a6252850000b02902e9e0d567dcmr2302182pfb.79.1623193639782;
        Tue, 08 Jun 2021 16:07:19 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s21sm11395838pfw.57.2021.06.08.16.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:07:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 06/14] block/mq-deadline: Add two lockdep_assert_held() statements
Date:   Tue,  8 Jun 2021 16:06:55 -0700
Message-Id: <20210608230703.19510-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608230703.19510-1-bvanassche@acm.org>
References: <20210608230703.19510-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Document the locking strategy by adding two lockdep_assert_held()
statements.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 31418e9ce9e2..191ff5ce629c 100644
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
