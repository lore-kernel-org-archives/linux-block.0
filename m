Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DD9C49361
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416C5613BF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhFRAr0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:26 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:46925 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhFRAr0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:26 -0400
Received: by mail-pl1-f169.google.com with SMTP id c15so3733097pls.13
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvzcpYyxUXsxaJFPAswnHIuD6teUMMAJH/ZJ8ZfJmVQ=;
        b=YmgH9bjqGeFtL1EhGzkIkfENEpFl7bJaQzbMtfdWsLDXieOceRuIB2xnmpgGuQprLi
         OXOt++NRs0URzy0zawCwpFK9sW7dV91Com+C7wlUa9fqdXQ82QsmwHVOeYFD2XAS2sXt
         CyAr12tsHHZK+x85xChenzhJZTet6McQcM8qPDSRnx7riwg/2tmxWTCzn+nzSVUjafoZ
         lmKdl6MjY+jgFNDUvxeoY4qpSmFPFwlmKIzucKxrMpcsVCym5feaQuu05FmvRo8TyFlz
         tVseyyZIP+nZF5rIikKYpLzJ+4R95VoDxYTlXjwDAr93CkFYZrQLnjmJ1qm4eMrpuBWi
         ldsw==
X-Gm-Message-State: AOAM531dT12/DxifID+bMtZ5D9JPWuBU4S1OyrVnQdOWfZrRfBMg4W51
        g+OS5VX/pfUva9GdZlZfQT8=
X-Google-Smtp-Source: ABdhPJwUKgPAS+BP8+FnSm+goBAENx7zWmMsyXNNxYePs5ueGLDeQx9rmX0/hz0EgvwkyLtjrBO1iQ==
X-Received: by 2002:a17:90b:1d89:: with SMTP id pf9mr18875944pjb.26.1623977116667;
        Thu, 17 Jun 2021 17:45:16 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:16 -0700 (PDT)
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
Subject: [PATCH v3 08/16] block/mq-deadline: Rename dd_init_queue() and dd_exit_queue()
Date:   Thu, 17 Jun 2021 17:44:48 -0700
Message-Id: <20210618004456.7280-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
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
