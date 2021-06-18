Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B4BC49361
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2706613B9
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhFRArX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:23 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:44727 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhFRArW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:22 -0400
Received: by mail-pl1-f172.google.com with SMTP id x22so2272003pll.11
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sC//DSflrYYUUqwO5cZ8eH2Jsx8jSOvCgTNVQdA4IeM=;
        b=fjT64s3lJHCRXZ2rPxv1tKw07LFh4aEYGB2jvill8AWjQye7bbmzAcseFiyLNMoeUv
         9uYQiOPpTk4nbCxp2eGLbyHcGD8maKqPYpieOGt9rioWn2E9HKVaOF0N8o10pIjCrbfo
         odZvYbgA70sq0anuw4UwfNFisQMff58dl56a3YWKoALUdBNQT0nXxg6YaRENj+8q3lQj
         o69df+PgWP4u8vXHQBQnJI5HDRHrT6ItE1tkEeCrcgBnaX+qYIUAyosQG/en6LzZsWaJ
         u/P9LEe/LjEOKytOkIow+xSepgDspAkqPXgR7dFPzX+SWM6p60C1CyL6x6Z3tGdlKi+5
         9qIQ==
X-Gm-Message-State: AOAM533PdG9+foLdtMCzhvL0yEo9+0sjbQs1g/Pyzjkz7F3mknle/KKq
        J7pQY0+InJv/k5HFRnJZf87rU+hTHhI=
X-Google-Smtp-Source: ABdhPJxIfR4zLfuGvcn3+vPGiN/lyl1iOzU1EJPhoxXMVclbz1dM/gqtt395sdMh4esZsbxZKAdKBQ==
X-Received: by 2002:a17:902:bb90:b029:11a:cf7c:997c with SMTP id m16-20020a170902bb90b029011acf7c997cmr2306440pls.80.1623977113306;
        Thu, 17 Jun 2021 17:45:13 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:12 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 06/16] block/mq-deadline: Add two lockdep_assert_held() statements
Date:   Thu, 17 Jun 2021 17:44:46 -0700
Message-Id: <20210618004456.7280-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
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
