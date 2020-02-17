Return-Path: <SRS0=O1WO=4F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433EFC3402A
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C6F20801
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgBQVIt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:08:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42611 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgBQVIt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Feb 2020 16:08:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id w21so9841566pgl.9
        for <linux-block@vger.kernel.org>; Mon, 17 Feb 2020 13:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aK4Z7Mphg//NDzdiVLvRspVvZVPkLnrr8/rXfxsJ5jE=;
        b=tBLai4A6Hz6JaNTfyKxoS2inXzbyY6UHr9OrVFCE7I5O01gemVNwwyqymdj27RxzAt
         IEdZ46XcUo6O9Z5SLBAe3IlYDkwvHo2AVKxWxVcKlWHHMhoRuMYu2O5g0dbkfKmWJ9UP
         YTdiMWoK/1ULSWI4COCq6MwwaLjaav5tOy5QyMach3S2BlPQD0orcJe2361aC1NqZ1Ga
         x/Db7v42yegqluq3Gy2Hny1/T7T8n49t4S2QE4qntAZRzQ4isFEMMgqSIoIIToLQuId+
         wK/lo4UsqlSTR4Yvxm/9KlEY3LLA5E7Ge/XkViXJz8nPE59iG3vBtbTktqL87+tIrK45
         3ijQ==
X-Gm-Message-State: APjAAAW4uBaysmY8qvukY0ASEDwm86HHLSuXmismgWvwly0vTMuV4IB9
        aqcbnJupnjzb5cVah2ikaXI=
X-Google-Smtp-Source: APXvYqz5+YhjVWzaE5NgL89NIMi5sANVlxfQH6j/JruIRPuq717GE+Qhnobdvni4iYQCPon2/LSJVQ==
X-Received: by 2002:a63:7d59:: with SMTP id m25mr18751720pgn.356.1581973728770;
        Mon, 17 Feb 2020 13:08:48 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:2474:e036:5bee:ca5b])
        by smtp.gmail.com with ESMTPSA id h13sm362952pjc.9.2020.02.17.13.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 13:08:47 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Subject: [PATCH 2/5] blk-mq: Keep set->nr_hw_queues and set->map[].nr_queues in sync
Date:   Mon, 17 Feb 2020 13:08:36 -0800
Message-Id: <20200217210839.28535-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217210839.28535-1-bvanassche@acm.org>
References: <20200217210839.28535-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch fixes the following kernel warning:

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
 block/blk-mq.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f298500e6dda..2b9f490f5a64 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3050,6 +3050,16 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 	}
 }
 
+static void blk_mq_set_nr_hw_queues(struct blk_mq_tag_set *set,
+				    int new_nr_hw_queues)
+{
+	int i;
+
+	set->nr_hw_queues = new_nr_hw_queues;
+	for (i = 0; i < set->nr_maps; i++)
+		set->map[i].nr_queues = new_nr_hw_queues;
+}
+
 static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 				  int cur_nr_hw_queues, int new_nr_hw_queues)
 {
@@ -3068,7 +3078,7 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 		       sizeof(*set->tags));
 	kfree(set->tags);
 	set->tags = new_tags;
-	set->nr_hw_queues = new_nr_hw_queues;
+	blk_mq_set_nr_hw_queues(set, new_nr_hw_queues);
 
 	return 0;
 }
@@ -3330,7 +3340,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		goto reregister;
 
 	prev_nr_hw_queues = set->nr_hw_queues;
-	set->nr_hw_queues = nr_hw_queues;
+	blk_mq_set_nr_hw_queues(set, nr_hw_queues);
 	blk_mq_update_queue_map(set);
 fallback:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
@@ -3338,7 +3348,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			pr_warn("Increasing nr_hw_queues to %d fails, fallback to %d\n",
 					nr_hw_queues, prev_nr_hw_queues);
-			set->nr_hw_queues = prev_nr_hw_queues;
+			blk_mq_set_nr_hw_queues(set, prev_nr_hw_queues);
 			blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 			goto fallback;
 		}
