Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82086C7619D
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6457724671
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 02:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBTCou (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:44:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46466 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbgBTCou (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 21:44:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id y30so1129811pga.13
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 18:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5m6ZyW02AM7svaF7KIyDHbzAfYKA5zVKeqe99DoBEhc=;
        b=qn1clfdS4aWzbd0XAM5I5Is73jQYhg2EeY+V/xrKzpl6g36JECtjoLlMFcBK2vFcdK
         ALb31DcVcfzGkv7tNmBmvkdRu5XQv2v8Cph9RMge09QFtO4nUymRWKVZ+fjiz737H4v9
         5GyLJH2rGZP3Hs/bI1OfCecZNvlhaGne9BaW/2BGCKEw3SpK+2dtQHERVg+rVV7I+GIO
         gMmnb7XjMtnPUh6Yg787oqopxr3oVOFGnhjawagWpX6Bv7qCbAIagYKpjN97aAvmfs3w
         Dloq9k1xMZmsw5xlxRYaX+ffxdUvOfdIzEVncudPhqEO4dEbdAyym1V9cZUo3obzkNPg
         M0cw==
X-Gm-Message-State: APjAAAVaCJRrVrruNvJN1yw/8bJIzzPQsI9dVvmhyp5QJ6vJ475D1/ba
        I/AfIlGoBbQJhtd9cQD2l/4=
X-Google-Smtp-Source: APXvYqxxBpZ4Q0wcS24E+iWz87NRPKfSYuAUld9+Met8+cK2s5G4RyyXRyuoMAlOdlOKYfrHi+WLJA==
X-Received: by 2002:a63:7802:: with SMTP id t2mr29922490pgc.352.1582166689925;
        Wed, 19 Feb 2020 18:44:49 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:29a7:b1bb:5b40:3d61])
        by smtp.gmail.com with ESMTPSA id t23sm1005466pfq.6.2020.02.19.18.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 18:44:49 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Subject: [PATCH v2 2/8] blk-mq: Keep set->nr_hw_queues and set->map[].nr_queues in sync
Date:   Wed, 19 Feb 2020 18:44:35 -0800
Message-Id: <20200220024441.11558-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220024441.11558-1-bvanassche@acm.org>
References: <20200220024441.11558-1-bvanassche@acm.org>
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
Reported-by: syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Fixes: ed76e329d74a ("blk-mq: abstract out queue map") # v5.0
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f298500e6dda..7f996e427733 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3023,6 +3023,13 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 
 static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
+	/*
+	 * blk_mq_map_queues() and multiple .map_queues() implementations
+	 * expect that set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the
+	 * number of hardware queues.
+	 */
+	set->map[HCTX_TYPE_DEFAULT].nr_queues = set->nr_hw_queues;
+
 	if (set->ops->map_queues && !is_kdump_kernel()) {
 		int i;
 
