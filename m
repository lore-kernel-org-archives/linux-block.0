Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48B5C48BCD
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75C561361
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhFHXJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:09:30 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:35836 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhFHXJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 19:09:29 -0400
Received: by mail-pf1-f169.google.com with SMTP id h12so14066195pfe.2
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 16:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvzcpYyxUXsxaJFPAswnHIuD6teUMMAJH/ZJ8ZfJmVQ=;
        b=Qcre7h2a4M9bRAle/elrg1uo5Hm3bmJPe4cPrjMnwfNubd+9suVDN+vSdZzSigPoiW
         6QxjlQUQxUBicr0qkAxoaUcKI8p5s8FGZbzNBuldDYvRg3HWcPNqe4eMWugbUP5jw5/E
         3L/2bnm1uSjEfCJDfP6cZhqrrd+eZNLyML1pOZgawysWjWfuDi5zF0506OUPsqGYsI1M
         iLn2qydKBCC/4JNsncLTmZS9950JxBmz/Cnbrs4PLcRZ7mEP3YFCRhOhRzGGLBqAq4qD
         z9/IqJRa/aJ2uWkX9lAOIS+2O71He59o9dJccDGNfn9Ni/X04G1/tPwjPTFMVS/ZNpNH
         XVlA==
X-Gm-Message-State: AOAM530bNFKVCaM8E/cBRCZoqT1TDm94DAYtR0Cg2zpqeWL13yVUd8Ye
        e+95cLO2OQyLTZGmj8Rm3go=
X-Google-Smtp-Source: ABdhPJzDWFCjKgw1M+OrP/pUzJPEGZHgCbB/GXnv4i4bC2swZS9skM0IVjT4E8ZAGK0fsMfcC+dZUQ==
X-Received: by 2002:a63:451f:: with SMTP id s31mr596413pga.209.1623193642588;
        Tue, 08 Jun 2021 16:07:22 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s21sm11395838pfw.57.2021.06.08.16.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:07:22 -0700 (PDT)
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
Subject: [PATCH 08/14] block/mq-deadline: Rename dd_init_queue() and dd_exit_queue()
Date:   Tue,  8 Jun 2021 16:06:57 -0700
Message-Id: <20210608230703.19510-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608230703.19510-1-bvanassche@acm.org>
References: <20210608230703.19510-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change "queue" into "sched" to make the function names reflect better the
purpose of these functions.

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
 block/mq-deadline.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index caa438f62a4d..d823ba7cb084 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -395,7 +395,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	return rq;
 }
 
-static void dd_exit_queue(struct elevator_queue *e)
+static void dd_exit_sched(struct elevator_queue *e)
 {
 	struct deadline_data *dd = e->elevator_data;
 
@@ -408,7 +408,7 @@ static void dd_exit_queue(struct elevator_queue *e)
 /*
  * initialize elevator private data (deadline_data).
  */
-static int dd_init_queue(struct request_queue *q, struct elevator_type *e)
+static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 {
 	struct deadline_data *dd;
 	struct elevator_queue *eq;
@@ -800,8 +800,8 @@ static struct elevator_type mq_deadline = {
 		.requests_merged	= dd_merged_requests,
 		.request_merged		= dd_request_merged,
 		.has_work		= dd_has_work,
-		.init_sched		= dd_init_queue,
-		.exit_sched		= dd_exit_queue,
+		.init_sched		= dd_init_sched,
+		.exit_sched		= dd_exit_sched,
 	},
 
 #ifdef CONFIG_BLK_DEBUG_FS
