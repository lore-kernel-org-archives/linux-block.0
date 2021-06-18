Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD07C49361
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2194613BA
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhFRArd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:33 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:43587 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhFRArc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:32 -0400
Received: by mail-pg1-f170.google.com with SMTP id e22so177342pgv.10
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yvij12V8EFxk4M9IphIW5nqaS4WuR6RiEeKAJdWKVNs=;
        b=n0rXYdnr8estSHgpoq089Z13n/z0EZu8Ply/9VWJK4YwSt7wfc+zBYIDw2WOut1g5A
         PvlrxKXb7cSd1TJQpPO32b/KLIOndSjJAatV9MjPMUL/+Eg59APEa8hqzcDuf/N9DdbW
         vP+7dXNGVnqorP8BS+fkdRL5eVOUYdNzQSl8xygYN8gH/LiQZpGTs1b4J6Fn+O0TLLuJ
         ezHixfGHkVMQEBtBQqpmxuh2n0erjiRL8S6ElH+qW3yWJqq3TepuNWG0uIuclCOK531/
         QqKkPtHNrPthS/6QzLATC8nvvFma91pgUlL97BHMeA3pU+UCSGwsHndHjk/om+25OY2n
         GeVQ==
X-Gm-Message-State: AOAM5326LCZWWyHn99TsjrHAxt2rwGYrZvofSM0cAhun3E1MHamIz3jR
        omSFR7so0smD3OoRTeRfsMw=
X-Google-Smtp-Source: ABdhPJw4Z0svvqjY1zfZuYbwfI5MW9RvkT738F3N1zcCKZ0tZXN81EZZiAcwRS6KhAAlX/IPxpo5mQ==
X-Received: by 2002:a63:bf0d:: with SMTP id v13mr7302535pgf.303.1623977123336;
        Thu, 17 Jun 2021 17:45:23 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v3 12/16] block/mq-deadline: Micro-optimize the batching algorithm
Date:   Thu, 17 Jun 2021 17:44:52 -0700
Message-Id: <20210618004456.7280-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When dispatching the first request of a batch, the deadline_move_request()
call clears .next_rq[] for the opposite data direction. .next_rq[] is not
restored when changing data direction. Fix this by not clearing .next_rq[]
and by keeping track of the data direction of a batch in a variable instead.

This patch is a micro-optimization because:
- The number of deadline_next_request() calls for the read direction is
  halved.
- The number of times that deadline_next_request() returns NULL is reduced.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 44da481c3fea..b09ae1f332a2 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -53,6 +53,8 @@ struct deadline_data {
 	struct rb_root sort_list[DD_DIR_COUNT];
 	struct list_head fifo_list[DD_DIR_COUNT];
 
+	/* Data direction of latest dispatched request. */
+	enum dd_data_dir last_dir;
 	/*
 	 * next in sort order. read, write or both are NULL
 	 */
@@ -179,8 +181,6 @@ deadline_move_request(struct deadline_data *dd, struct request *rq)
 {
 	const enum dd_data_dir data_dir = rq_data_dir(rq);
 
-	dd->next_rq[DD_READ] = NULL;
-	dd->next_rq[DD_WRITE] = NULL;
 	dd->next_rq[data_dir] = deadline_latter_request(rq);
 
 	/*
@@ -292,10 +292,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	/*
 	 * batches are currently reads XOR writes
 	 */
-	rq = deadline_next_request(dd, DD_WRITE);
-	if (!rq)
-		rq = deadline_next_request(dd, DD_READ);
-
+	rq = deadline_next_request(dd, dd->last_dir);
 	if (rq && dd->batching < dd->fifo_batch)
 		/* we have a next request are still entitled to batch */
 		goto dispatch_request;
@@ -361,6 +358,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd)
 	if (!rq)
 		return NULL;
 
+	dd->last_dir = data_dir;
 	dd->batching = 0;
 
 dispatch_request:
@@ -473,6 +471,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	dd->fifo_expire[DD_WRITE] = write_expire;
 	dd->writes_starved = writes_starved;
 	dd->front_merges = 1;
+	dd->last_dir = DD_WRITE;
 	dd->fifo_batch = fifo_batch;
 	spin_lock_init(&dd->lock);
 	spin_lock_init(&dd->zone_lock);
