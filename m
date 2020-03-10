Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B072AC10F27
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 04:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E9E2467D
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 04:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgCJE0f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 00:26:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39099 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgCJE0e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 00:26:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id w65so5330191pfb.6
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 21:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MvC1aHs2ZO2D9gn92BQxEAYcuOjaomxwwJJ0YEkOIfU=;
        b=B2l/xZkuK2vkdiWYVvX2b212oZtpjsdbvrOZTQcOaSNOWP6A63Jpxn/3CKdsReUloa
         FCZofTs8AS+qn+4kH4O8ujb3PMt4tYS8QBJhJHFxZ9Uw3mwcOjhUiGSZHK3zCEtVQp6L
         Vubrmw1MvzvHikVKb3LD0W8KzXrlcHxcNQ2f7LslAWbjOj/HCXuTlB1NZ0BnJ3d5ervN
         EhhP25S0nZ9d3Q2vTwCnI6SAGi/Db2zBHyQAKw0Tc2xj0+4jAZ+pWQa5g3XYjdzkr34/
         Kw9JMQL1WGSMQyCoN73uZx8fRnyfPcV1yQg7fyo18PGaFgDYXT5vLAm6/MftEjkohqGU
         qPKQ==
X-Gm-Message-State: ANhLgQ082QUALLKdi84wgMJO7ulx7oe0qe+Y6F5zL3itnUHooON0+1o0
        6FkLDKzptSHcaWWej4EFPnA=
X-Google-Smtp-Source: ADFU+vtFvnWubtiWoLEWUJglWijivKHSEOna4kvfO/nnm2zB4zp7rY7UBc+/avnRFqAERN6S6/ni6w==
X-Received: by 2002:aa7:8bdd:: with SMTP id s29mr19220929pfd.208.1583814393686;
        Mon, 09 Mar 2020 21:26:33 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c0e4:71da:7a83:2357])
        by smtp.gmail.com with ESMTPSA id l189sm5963240pga.64.2020.03.09.21.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 21:26:32 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Subject: [PATCH v4 2/8] blk-mq: Keep set->nr_hw_queues and set->map[].nr_queues in sync
Date:   Mon,  9 Mar 2020 21:26:17 -0700
Message-Id: <20200310042623.20779-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310042623.20779-1-bvanassche@acm.org>
References: <20200310042623.20779-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_map_queues() and multiple .map_queues() implementations expect that
set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the number of hardware
queues. Hence set .nr_queues before calling these functions. This patch
fixes the following kernel warning:

WARNING: CPU: 0 PID: 2501 at include/linux/cpumask.h:137
Call Trace:
 blk_mq_run_hw_queue+0x19d/0x350 block/blk-mq.c:1508
 blk_mq_run_hw_queues+0x112/0x1a0 block/blk-mq.c:1525
 blk_mq_requeue_work+0x502/0x780 block/blk-mq.c:775
 process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
 worker_thread+0x98/0xe40 kernel/workqueue.c:2415
 kthread+0x361/0x430 kernel/kthread.c:255

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reported-by: syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Fixes: ed76e329d74a ("blk-mq: abstract out queue map") # v5.0
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7a16d61e3cd3..f174b6ad94cb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3027,6 +3027,14 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 
 static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
+	/*
+	 * blk_mq_map_queues() and multiple .map_queues() implementations
+	 * expect that set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the
+	 * number of hardware queues.
+	 */
+	if (set->nr_maps == 1)
+		set->map[HCTX_TYPE_DEFAULT].nr_queues = set->nr_hw_queues;
+
 	if (set->ops->map_queues && !is_kdump_kernel()) {
 		int i;
 
